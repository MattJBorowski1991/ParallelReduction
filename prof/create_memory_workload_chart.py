#!/usr/bin/env python3
from PIL import Image, ImageDraw, ImageFont

# Data from Memory Workload Analysis table
kernel_ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

# Correct data from GPU Speed Of Light and Memory Workload Analysis tables
duration = [23.76, 26.87, 88.73, 66.60, 51.91, 29.03, 30.15, 44.91, 32.37, 28.63, 28.63, 28.63]
max_bandwidth = [67.89, 76.03, 45.65, 60.83, 78.03, 77.18, 71.93, 90.20, 55.38, 55.73, 55.73, 55.73]
mem_busy = [36.22, 41.03, 25.55, 48.18, 43.69, 43.23, 40.43, 46.90, 30.18, 30.68, 30.68, 30.68]
dram_throughput = [34.33, 30.61, 10.30, 13.89, 17.83, 31.52, 30.17, 20.96, 25.87, 29.43, 29.43, 29.43]

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
draw_text_centered("Memory Workload", width // 2, 20, fill='black', font=title_font)

# Draw main axes
draw.line([(chart_left, chart_bottom), (chart_right, chart_bottom)], fill='black', width=2)  # x-axis
draw.line([(chart_left, chart_top), (chart_left, chart_bottom)], fill='black', width=2)      # y-axis left
draw.line([(chart_right, chart_top), (chart_right, chart_bottom)], fill='black', width=2)    # y-axis right

# Axis labels
draw_text_centered("Kernel ID", (chart_left + chart_right) // 2, chart_bottom + 44, fill='black', font=axis_font)

# Normalize duration to actual milliseconds (0-100 ms range)
duration_min, duration_max = 0, 100
duration_norm = [chart_bottom - (d - duration_min) / (duration_max - duration_min) * (chart_bottom - chart_top) for d in duration]

# Normalize percentage data to 0-100% range
def normalize_percent(data):
    return [chart_bottom - (v / 100.0) * (chart_bottom - chart_top) for v in data]

max_bandwidth_norm = normalize_percent(max_bandwidth)
mem_busy_norm = normalize_percent(mem_busy)
dram_throughput_norm = normalize_percent(dram_throughput)

# Calculate positions
num_kernels = len(kernel_ids)
x_spacing = (chart_right - chart_left) / (num_kernels + 1)
bar_width = x_spacing * 0.24  # Adjusted for 3 bars per kernel

# Draw Y-axis labels - Left side is duration in ms, Right side is percentages
for val in range(0, 101, 10):
    y = chart_bottom - (val / 100.0) * (chart_bottom - chart_top)
    # Left y-axis: duration in ms
    draw.text((chart_left - 42, y - 8), f"{val}", fill='black', font=tick_font)
    draw.line([(chart_left - 3, y), (chart_left, y)], fill='black', width=1)
    # Right y-axis: percentages
    draw.text((chart_right + 10, y - 8), f"{val}", fill='black', font=tick_font)
    draw.line([(chart_right, y), (chart_right + 3, y)], fill='black', width=1)

# Draw X-axis labels
for i, kid in enumerate(kernel_ids):
    x = chart_left + x_spacing * (i + 1)
    # Tick mark
    draw.line([(x, chart_bottom), (x, chart_bottom + 5)], fill='black', width=1)
    # Kernel ID label
    draw_text_centered(str(kid), x, chart_bottom + 10, fill='black', font=tick_font)

# Draw bars (Max Bandwidth - corporate red, Mem Busy - forest green, DRAM Throughput - corporate teal) - adjacent columns
for i in range(len(kernel_ids)):
    x = chart_left + x_spacing * (i + 1)
    
    # Max Bandwidth bar (left column) - corporate red
    max_bw_y = max_bandwidth_norm[i]
    max_bw_x1 = x - bar_width * 1.5
    max_bw_x2 = x - bar_width * 0.5
    draw.rectangle([(max_bw_x1, max_bw_y), (max_bw_x2, chart_bottom)], fill='#C84C3C', outline='#8B3A2D', width=2)
    draw_text_centered(f"{max_bandwidth[i]:.1f}", (max_bw_x1 + max_bw_x2) / 2, max_bw_y - 22, fill='#8B3A2D', font=value_font)
    
    # Mem Busy bar (middle column) - forest green
    mem_y = mem_busy_norm[i]
    mem_x1 = x - bar_width * 0.5
    mem_x2 = x + bar_width * 0.5
    draw.rectangle([(mem_x1, mem_y), (mem_x2, chart_bottom)], fill='#3D7C47', outline='#254E2E', width=2)
    draw_text_centered(f"{mem_busy[i]:.1f}", (mem_x1 + mem_x2) / 2, mem_y - 22, fill='#254E2E', font=value_font)
    
    # DRAM Throughput bar (right column) - corporate teal
    dram_y = dram_throughput_norm[i]
    dram_x1 = x + bar_width * 0.5
    dram_x2 = x + bar_width * 1.5
    draw.rectangle([(dram_x1, dram_y), (dram_x2, chart_bottom)], fill='#2E8B9E', outline='#1B5A6B', width=2)
    draw_text_centered(f"{dram_throughput[i]:.1f}", (dram_x1 + dram_x2) / 2, dram_y - 22, fill='#1B5A6B', font=value_font)

# Draw Duration line (blue)
for i in range(len(kernel_ids) - 1):
    x1 = chart_left + x_spacing * (i + 1)
    y1 = duration_norm[i]
    x2 = chart_left + x_spacing * (i + 2)
    y2 = duration_norm[i + 1]
    draw.line([(x1, y1), (x2, y2)], fill='blue', width=3)

# Draw Duration points (circles)
for i in range(len(kernel_ids)):
    x = chart_left + x_spacing * (i + 1)
    y = duration_norm[i]
    draw.ellipse([(x - 5, y - 5), (x + 5, y + 5)], fill='blue', outline='darkblue', width=2)

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
# Max Bandwidth
draw.rectangle([(legend_x + 12, key_y + 28), (legend_x + 28, key_y + 42)], fill='#C84C3C', outline='#8B3A2D', width=2)
draw.text((legend_x + 38, key_y + 24), "Max Bandwidth (%)", fill='#8B3A2D', font=legend_font)
# Mem Busy
draw.rectangle([(legend_x + 12, key_y + 52), (legend_x + 28, key_y + 66)], fill='#3D7C47', outline='#254E2E', width=2)
draw.text((legend_x + 38, key_y + 48), "Mem Busy (%)", fill='#254E2E', font=legend_font)
# DRAM Throughput
draw.rectangle([(legend_x + 12, key_y + 76), (legend_x + 28, key_y + 90)], fill='#2E8B9E', outline='#1B5A6B', width=2)
draw.text((legend_x + 38, key_y + 72), "DRAM Throughput (%)", fill='#1B5A6B', font=legend_font)

# Save image
img.save('/teamspace/studios/this_studio/ParallelReduction/prof/ncu_memory_workload_analysis.png')
print("Chart saved as ncu_memory_workload_analysis.png")
