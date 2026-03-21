#!/usr/bin/env python3
from PIL import Image, ImageDraw, ImageFont

# Data from Source Counters table
kernel_ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

duration = [23.76, 26.87, 88.73, 66.60, 51.91, 29.03, 30.15, 44.91, 32.37, 28.63, 28.63, 28.63]

# Branch Instructions in millions
branch_instr = [
    69206016 / 1e6,
    69206016 / 1e6,
    169869312 / 1e6,
    203423744 / 1e6,
    169869312 / 1e6,
    93323264 / 1e6,
    143654912 / 1e6,
    69206016 / 1e6,
    98566144 / 1e6,
    71303168 / 1e6,
    71303168 / 1e6,
    71303168 / 1e6,
]

# Chart dimensions
width = 1700
height = 900
margin_left = 250
margin_right = 100
margin_top = 80
margin_bottom = 150

chart_left = margin_left
chart_right = width - margin_right
chart_top = margin_top
chart_bottom = height - margin_bottom

# Create image
img = Image.new('RGB', (width, height), color='white')
draw = ImageDraw.Draw(img)

try:
    title_font = ImageFont.truetype("DejaVuSans-Bold.ttf", 30)
    axis_font = ImageFont.truetype("DejaVuSans-Bold.ttf", 21)
    legend_font = ImageFont.truetype("DejaVuSans.ttf", 16)
    tick_font = ImageFont.truetype("DejaVuSans.ttf", 16)
    value_font = ImageFont.truetype("DejaVuSans-Bold.ttf", 8)
except OSError:
    title_font = ImageFont.load_default()
    axis_font = ImageFont.load_default()
    legend_font = ImageFont.load_default()
    tick_font = ImageFont.load_default()
    value_font = ImageFont.load_default()


def draw_text_centered(text, x_center, y, fill='black', font=None):
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    draw.text((int(x_center - text_width / 2), y), text, fill=fill, font=font)

# Draw title
draw_text_centered("Source Counters", width // 2, 20, fill='black', font=title_font)

# Draw main axes
draw.line([(chart_left, chart_bottom), (chart_right, chart_bottom)], fill='black', width=2)
draw.line([(chart_left, chart_top), (chart_left, chart_bottom)], fill='black', width=2)
draw.line([(chart_right, chart_top), (chart_right, chart_bottom)], fill='black', width=2)

# Axis label
draw_text_centered("Kernel ID", (chart_left + chart_right) // 2, chart_bottom + 44, fill='black', font=axis_font)

# Normalize duration to actual ms (0-100 ms range on left y-axis)
duration_norm = [chart_bottom - (d / 100.0) * (chart_bottom - chart_top) for d in duration]

# Normalize branch instructions to 0-250 million range (right y-axis)
instr_max = 250.0  # million
instr_norm = [chart_bottom - (v / instr_max) * (chart_bottom - chart_top) for v in branch_instr]

# Calculate x positions
num_kernels = len(kernel_ids)
x_spacing = (chart_right - chart_left) / (num_kernels + 1)
bar_width = x_spacing * 0.50  # Single bar per kernel, wider

# Left y-axis: duration 0-100 ms
for val in range(0, 101, 10):
    y = chart_bottom - (val / 100.0) * (chart_bottom - chart_top)
    draw.text((chart_left - 42, y - 8), f"{val}", fill='black', font=tick_font)
    draw.line([(chart_left - 3, y), (chart_left, y)], fill='black', width=1)

# Right y-axis: 0 to 250M in steps of 25M
for i in range(0, 11):
    val = i * 25
    y = chart_bottom - (val / instr_max) * (chart_bottom - chart_top)
    label = f"{val}M"
    draw.text((chart_right + 10, y - 8), label, fill='black', font=tick_font)
    draw.line([(chart_right, y), (chart_right + 3, y)], fill='black', width=1)

# Draw X-axis labels
for i, kid in enumerate(kernel_ids):
    x = chart_left + x_spacing * (i + 1)
    draw.line([(x, chart_bottom), (x, chart_bottom + 5)], fill='black', width=1)
    draw_text_centered(str(kid), x, chart_bottom + 10, fill='black', font=tick_font)

# Draw bars - Branch Instructions (corporate red)
for i in range(len(kernel_ids)):
    x = chart_left + x_spacing * (i + 1)
    bar_x1 = x - bar_width / 2
    bar_x2 = x + bar_width / 2
    bar_y = instr_norm[i]

    draw.rectangle([(bar_x1, bar_y), (bar_x2, chart_bottom)], fill='#2E8B9E', outline='#1B5A6B', width=2)
    draw_text_centered(f"{branch_instr[i]:.1f}M", x, bar_y - 22, fill='#1B5A6B', font=value_font)

# Draw Duration line (navy blue)
for i in range(len(kernel_ids) - 1):
    x1 = chart_left + x_spacing * (i + 1)
    y1 = duration_norm[i]
    x2 = chart_left + x_spacing * (i + 2)
    y2 = duration_norm[i + 1]
    draw.line([(x1, y1), (x2, y2)], fill='#1F3A5C', width=3)

# Draw Duration points
for i in range(len(kernel_ids)):
    x = chart_left + x_spacing * (i + 1)
    y = duration_norm[i]
    draw.ellipse([(x - 6, y - 6), (x + 6, y + 6)], fill='#1F3A5C', outline='#0F1F35', width=2)

# Legend
legend_x = chart_right - 330
legend_y = chart_top + 8
legend_box_width = 320
legend_box_height = 65

draw.rectangle(
    [(legend_x, legend_y), (legend_x + legend_box_width, legend_y + legend_box_height)],
    fill='white', outline='black', width=2
)

key_y = legend_y + 12
# Duration
draw.line([(legend_x + 12, key_y + 7), (legend_x + 30, key_y + 7)], fill='#1F3A5C', width=3)
draw.ellipse([(legend_x + 19, key_y + 3), (legend_x + 25, key_y + 9)], fill='#1F3A5C', outline='#0F1F35', width=2)
draw.text((legend_x + 38, key_y), "Duration (ms)", fill='#1F3A5C', font=legend_font)
# Branch Instructions
draw.rectangle([(legend_x + 12, key_y + 28), (legend_x + 28, key_y + 42)], fill='#2E8B9E', outline='#1B5A6B', width=2)
draw.text((legend_x + 38, key_y + 24), "Branch Instructions (M)", fill='#1B5A6B', font=legend_font)

# Save image
img.save('/teamspace/studios/this_studio/ParallelReduction/prof/ncu_source_counters.png')
print("Chart saved as ncu_source_counters.png")
