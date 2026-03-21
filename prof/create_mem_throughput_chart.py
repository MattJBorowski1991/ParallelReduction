#!/usr/bin/env python3
from PIL import Image, ImageDraw, ImageFont

# Data from Memory Workload Analysis table
kernel_ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

duration = [23.76, 26.87, 88.73, 66.60, 51.91, 29.03, 30.15, 44.91, 32.37, 28.63, 28.63, 28.63]

# Memory Throughput in Gbyte/s
mem_throughput = [109.73, 97.90, 32.94, 44.42, 57.01, 100.77, 96.46, 67.00, 82.73, 94.09, 94.09, 94.09]

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
draw_text_centered("Memory Throughput", width // 2, 20, fill='black', font=title_font)

# Draw main axes
draw.line([(chart_left, chart_bottom), (chart_right, chart_bottom)], fill='black', width=2)
draw.line([(chart_left, chart_top), (chart_left, chart_bottom)], fill='black', width=2)
draw.line([(chart_right, chart_top), (chart_right, chart_bottom)], fill='black', width=2)

# Axis label
draw_text_centered("Kernel ID", (chart_left + chart_right) // 2, chart_bottom + 44, fill='black', font=axis_font)

# Normalize duration to actual ms (0-100 ms left y-axis)
duration_norm = [chart_bottom - (d / 100.0) * (chart_bottom - chart_top) for d in duration]

# Normalize memory throughput to 0-120 Gbyte/s (right y-axis)
throughput_max = 120.0
throughput_norm = [chart_bottom - (v / throughput_max) * (chart_bottom - chart_top) for v in mem_throughput]

# Calculate x positions
num_kernels = len(kernel_ids)
x_spacing = (chart_right - chart_left) / (num_kernels + 1)
bar_width = x_spacing * 0.50

# Left y-axis: duration 0-100 ms
for val in range(0, 101, 10):
    y = chart_bottom - (val / 100.0) * (chart_bottom - chart_top)
    draw.text((chart_left - 42, y - 8), f"{val}", fill='black', font=tick_font)
    draw.line([(chart_left - 3, y), (chart_left, y)], fill='black', width=1)

# Right y-axis: 0-120 Gbyte/s in steps of 10
for val in range(0, 121, 10):
    y = chart_bottom - (val / throughput_max) * (chart_bottom - chart_top)
    draw.text((chart_right + 10, y - 8), f"{val}", fill='black', font=tick_font)
    draw.line([(chart_right, y), (chart_right + 3, y)], fill='black', width=1)

# Draw X-axis labels
for i, kid in enumerate(kernel_ids):
    x = chart_left + x_spacing * (i + 1)
    draw.line([(x, chart_bottom), (x, chart_bottom + 5)], fill='black', width=1)
    draw_text_centered(str(kid), x, chart_bottom + 10, fill='black', font=tick_font)

# Draw bars - Memory Throughput (professional purple)
for i in range(len(kernel_ids)):
    x = chart_left + x_spacing * (i + 1)
    bar_x1 = x - bar_width / 2
    bar_x2 = x + bar_width / 2
    bar_y = throughput_norm[i]

    draw.rectangle([(bar_x1, bar_y), (bar_x2, chart_bottom)], fill='#7B4FA8', outline='#4E2D72', width=2)
    draw_text_centered(f"{mem_throughput[i]:.1f}", x, bar_y - 22, fill='#4E2D72', font=value_font)

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
# Memory Throughput
draw.rectangle([(legend_x + 12, key_y + 28), (legend_x + 28, key_y + 42)], fill='#7B4FA8', outline='#4E2D72', width=2)
draw.text((legend_x + 38, key_y + 24), "Memory Throughput (Gbyte/s)", fill='#4E2D72', font=legend_font)

# Save image
img.save('/teamspace/studios/this_studio/ParallelReduction/prof/ncu_mem_throughput_gbytes.png')
print("Chart saved as ncu_mem_throughput_gbytes.png")
