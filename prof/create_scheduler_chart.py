#!/usr/bin/env python3
from PIL import Image, ImageDraw, ImageFont
import math

# Data from Scheduler Statistics table
kernel_ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

# Correct data from GPU Speed Of Light and Scheduler Statistics tables
duration = [23.76, 26.87, 88.73, 66.60, 51.91, 29.03, 30.15, 44.91, 32.37, 28.63, 28.63, 28.63]
active_warps = [6.21, 6.34, 7.50, 7.26, 7.17, 7.24, 7.29, 6.97, 5.36, 5.93, 5.93, 5.93]
eligible_warps = [0.37, 0.36, 1.29, 0.53, 0.56, 0.60, 0.96, 0.52, 0.34, 0.41, 0.41, 0.41]
# Achieved warps = "One or More Eligible" % rounded up to nearest 0.01, converted to 0.xx scale
# One or More Eligible values: 26.88, 25.76, 58.92, 31.66, 34.40, 34.15, 51.02, 30.59, 23.16, 28.05, 28.05, 28.05
one_or_more_eligible = [26.88, 25.76, 58.92, 31.66, 34.40, 34.15, 51.02, 30.59, 23.16, 28.05, 28.05, 28.05]
achieved_warps = [math.ceil(val) / 100.0 for val in one_or_more_eligible]

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
draw_text_centered("Scheduler Statistics", width // 2, 20, fill='black', font=title_font)

# Draw main axes
draw.line([(chart_left, chart_bottom), (chart_right, chart_bottom)], fill='black', width=2)  # x-axis
draw.line([(chart_left, chart_top), (chart_left, chart_bottom)], fill='black', width=2)      # y-axis left
draw.line([(chart_right, chart_top), (chart_right, chart_bottom)], fill='black', width=2)    # y-axis right

# Axis labels
draw_text_centered("Kernel ID", (chart_left + chart_right) // 2, chart_bottom + 44, fill='black', font=axis_font)

# Normalize duration to actual milliseconds (0-100 ms range)
duration_min, duration_max = 0, 100
duration_norm = [chart_bottom - (d - duration_min) / (duration_max - duration_min) * (chart_bottom - chart_top) for d in duration]

# Normalize warp data to 0-100 scale (for display on right y-axis)
def normalize_percent(data, data_max=None):
    if data_max is None:
        data_max = max(data)
    return [chart_bottom - (v / data_max * 100) / 100.0 * (chart_bottom - chart_top) for v in data]

# Scale warp metrics to 0-8 range for display
active_warps_norm = [chart_bottom - (v / 8.0) * (chart_bottom - chart_top) for v in active_warps]
eligible_warps_norm = [chart_bottom - (v / 8.0) * (chart_bottom - chart_top) for v in eligible_warps]
achieved_warps_norm = [chart_bottom - (v / 8.0) * (chart_bottom - chart_top) for v in achieved_warps]

# Calculate positions
num_kernels = len(kernel_ids)
x_spacing = (chart_right - chart_left) / (num_kernels + 1)
bar_width = x_spacing * 0.24  # Adjusted for 3 bars per kernel

# Draw Y-axis labels - Left side is duration in ms, Right side is warp count 0-8
for val in range(0, 101, 10):
    y = chart_bottom - (val / 100.0) * (chart_bottom - chart_top)
    # Left y-axis: duration in ms
    draw.text((chart_left - 42, y - 8), f"{val}", fill='black', font=tick_font)
    draw.line([(chart_left - 3, y), (chart_left, y)], fill='black', width=1)

# Draw right Y-axis labels (0-8 scale for warps)
for val in range(0, 9):
    y = chart_bottom - (val / 8.0) * (chart_bottom - chart_top)
    draw.text((chart_right + 10, y - 8), f"{val}", fill='black', font=tick_font)
    draw.line([(chart_right, y), (chart_right + 3, y)], fill='black', width=1)

# Draw X-axis labels
for i, kid in enumerate(kernel_ids):
    x = chart_left + x_spacing * (i + 1)
    # Tick mark
    draw.line([(x, chart_bottom), (x, chart_bottom + 5)], fill='black', width=1)
    # Kernel ID label
    draw_text_centered(str(kid), x, chart_bottom + 10, fill='black', font=tick_font)

# Draw bars (Active Warps - corporate red, Eligible Warps - forest green, Achieved Warps - corporate teal)
for i in range(len(kernel_ids)):
    x = chart_left + x_spacing * (i + 1)
    
    # Active Warps bar (left column) - corporate red
    active_y = active_warps_norm[i]
    active_x1 = x - bar_width * 1.5
    active_x2 = x - bar_width * 0.5
    draw.rectangle([(active_x1, active_y), (active_x2, chart_bottom)], fill='#C84C3C', outline='#8B3A2D', width=2)
    draw_text_centered(f"{active_warps[i]:.2f}", (active_x1 + active_x2) / 2, active_y - 22, fill='#8B3A2D', font=value_font)
    
    # Eligible Warps bar (middle column) - forest green
    eligible_y = eligible_warps_norm[i]
    eligible_x1 = x - bar_width * 0.5
    eligible_x2 = x + bar_width * 0.5
    draw.rectangle([(eligible_x1, eligible_y), (eligible_x2, chart_bottom)], fill='#3D7C47', outline='#254E2E', width=2)
    draw_text_centered(f"{eligible_warps[i]:.2f}", (eligible_x1 + eligible_x2) / 2, eligible_y - 22, fill='#254E2E', font=value_font)
    
    # Issued Warps bar (right column) - corporate teal
    achieved_y = achieved_warps_norm[i]
    achieved_x1 = x + bar_width * 0.5
    achieved_x2 = x + bar_width * 1.5
    draw.rectangle([(achieved_x1, achieved_y), (achieved_x2, chart_bottom)], fill='#2E8B9E', outline='#1B5A6B', width=2)
    draw_text_centered(f"{achieved_warps[i]:.2f}", (achieved_x1 + achieved_x2) / 2, achieved_y - 22, fill='#1B5A6B', font=value_font)

# Draw Duration line (navy blue)
for i in range(len(kernel_ids) - 1):
    x1 = chart_left + x_spacing * (i + 1)
    y1 = duration_norm[i]
    x2 = chart_left + x_spacing * (i + 2)
    y2 = duration_norm[i + 1]
    draw.line([(x1, y1), (x2, y2)], fill='#1F3A5C', width=3)

# Draw Duration points (circles with elegant style)
for i in range(len(kernel_ids)):
    x = chart_left + x_spacing * (i + 1)
    y = duration_norm[i]
    draw.ellipse([(x - 6, y - 6), (x + 6, y + 6)], fill='#1F3A5C', outline='#0F1F35', width=2)

# Metric legend on the right
legend_x = chart_right - 330
legend_y = chart_top + 8
legend_box_width = 320
legend_box_height = 110

draw.rectangle(
    [(legend_x, legend_y), (legend_x + legend_box_width, legend_y + legend_box_height)],
    fill='white',
    outline='black',
    width=2
)

key_y = legend_y + 12
# Duration (top)
draw.line([(legend_x + 12, key_y + 7), (legend_x + 30, key_y + 7)], fill='#1F3A5C', width=3)
draw.ellipse([(legend_x + 19, key_y + 3), (legend_x + 25, key_y + 9)], fill='#1F3A5C', outline='#0F1F35', width=2)
draw.text((legend_x + 38, key_y), "Duration (ms)", fill='#1F3A5C', font=legend_font)
# Active Warps
draw.rectangle([(legend_x + 12, key_y + 28), (legend_x + 28, key_y + 42)], fill='#C84C3C', outline='#8B3A2D', width=2)
draw.text((legend_x + 38, key_y + 24), "Active Warps", fill='#8B3A2D', font=legend_font)
# Eligible Warps
draw.rectangle([(legend_x + 12, key_y + 52), (legend_x + 28, key_y + 66)], fill='#3D7C47', outline='#254E2E', width=2)
draw.text((legend_x + 38, key_y + 48), "Eligible Warps", fill='#254E2E', font=legend_font)
# Issued Warps
draw.rectangle([(legend_x + 12, key_y + 76), (legend_x + 28, key_y + 90)], fill='#2E8B9E', outline='#1B5A6B', width=2)
draw.text((legend_x + 38, key_y + 72), "Issued Warps", fill='#1B5A6B', font=legend_font)

# Save image
img.save('/teamspace/studios/this_studio/ParallelReduction/prof/ncu_scheduler_analysis.png')
print("Chart saved as ncu_scheduler_analysis.png")
