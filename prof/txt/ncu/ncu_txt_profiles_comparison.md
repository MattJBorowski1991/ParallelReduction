# NVIDIA Nsight Compute (NCU) Profiles Comparison

> **Dataset:** Parallel Reduction Kernels | **Array Size:** N = 1,073,741,824 elements | **Device:** CC 7.5 (NVIDIA RTX)

---

## Table of Contents

1. [GPU Speed Of Light Throughput](#gpu-speed-of-light-throughput)
2. [PM Sampling](#pm-sampling)
3. [Compute Workload Analysis](#compute-workload-analysis)
4. [Memory Workload Analysis](#memory-workload-analysis)
5. [Scheduler Statistics](#scheduler-statistics)
6. [Warp State Statistics](#warp-state-statistics)
7. [Instruction Statistics](#instruction-statistics)
8. [Launch Statistics](#launch-statistics)
9. [Occupancy](#occupancy)
10. [GPU and Memory Workload Distribution](#gpu-and-memory-workload-distribution)
11. [Source Counters](#source-counters)
12. [Summary Notes](#summary-notes)

---

## Kernel Reference Guide

| ID | Kernel Name | Description |
|:--:|---|---|
| 1 | atomic_global | Global atomic operations for parallel reduction |
| 2 | atomic_per_block | Per-block atomic operations |
| 3 | interleaved_addr_divergent_branches | Interleaved addressing with divergent branches |
| 4 | interleaved_addr_bank_conflicts | Interleaved addressing with bank conflict analysis |
| 5 | sequential_addressing | Sequential memory addressing pattern |
| 6 | two_elems_per_thread | Two elements processed per thread |
| 7 | two_elems_per_thread_grid_strided | Two elements with grid-stride loop |
| 8 | unroll_last_warp | Unrolled loop with last warp handling |
| 9 | unroll_fully | Fully unrolled loop optimization |
| 10 | shfl_down_sync | Shuffle operation - down variant with sync |
| 11 | shfl_up_sync | Shuffle operation - up variant with sync |
| 12 | shfl_xor_sync | Shuffle operation - XOR variant with sync |

---

## GPU Speed Of Light Throughput

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| DRAM Frequency | Ghz | 5.00 | 5.00 | 5.00 | 5.00 | 5.00 | 5.00 | 5.00 | 5.00 | 5.00 | 5.00 | 5.00 | 5.00 |
| SM Frequency | Mhz | 585.00 | 585.00 | 585.00 | 585.00 | 585.00 | 585.00 | 585.00 | 585.00 | 585.00 | 585.00 | 585.00 | 585.00 |
| Elapsed Cycles | cycle | 13902433 | 15719444 | 51906057 | 38959465 | 30369710 | 16984455 | 17638388 | 26272450 | 18934552 | 16747339 | 16747077 | 16746741 |
| Memory Throughput | % | 67.89 | 76.03 | 45.65 | 60.83 | 78.03 | 77.18 | 71.93 | 90.20 | 55.38 | 55.73 | 55.73 | 55.73 |
| DRAM Throughput | % | 34.33 | 30.61 | 10.30 | 13.89 | 17.83 | 31.52 | 30.17 | 20.96 | 25.87 | 29.43 | 29.43 | 29.43 |
| Duration | ms | 23.76 | 26.87 | 88.73 | 66.60 | 51.91 | 29.03 | 30.15 | 44.91 | 32.37 | 28.63 | 28.63 | 28.63 |
| L1/TEX Cache Throughput | % | 72.43 | 82.05 | 51.10 | 96.36 | 87.37 | 86.45 | 80.85 | 93.80 | 60.37 | 61.36 | 61.37 | 61.36 |
| L2 Cache Throughput | % | 10.65 | 9.41 | 2.86 | 3.80 | 4.88 | 8.58 | 8.27 | 5.63 | 7.82 | 8.83 | 8.84 | 8.83 |
| SM Active Cycles | cycle | 13901237.70 | 15722142.70 | 51908653.67 | 38958718.23 | 30368401.82 | 16981664.98 | 17637795.27 | 26270287.57 | 18930750.20 | 16742064.32 | 16745090.22 | 16743481.05 |
| Compute (SM) Throughput | % | 67.89 | 76.03 | 58.90 | 60.83 | 78.03 | 77.18 | 71.93 | 90.20 | 55.38 | 55.73 | 55.73 | 55.73 |

### Analysis Comments

> **ℹ️ INF** — **Kernel 1** · Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. Check both the Compute Workload Analysis and Memory Workload Analysis sections.

> **ℹ️ INF** — **Kernel 2** · Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. Check both the Compute Workload Analysis and Memory Workload Analysis sections.

> **⚙️ OPT** — **Kernel 3** · This workload exhibits low compute throughput and memory bandwidth utilization relative to the peak performance of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak typically indicate latency issues. Look at Scheduler Statistics and Warp State Statistics for potential reasons.

> **ℹ️ INF** — **Kernel 4** · Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. Check both the Compute Workload Analysis and Memory Workload Analysis sections.

> **ℹ️ INF** — **Kernel 5** · Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. Check both the Compute Workload Analysis and Memory Workload Analysis sections.

> **ℹ️ INF** — **Kernel 6** · Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. Check both the Compute Workload Analysis and Memory Workload Analysis sections.

> **ℹ️ INF** — **Kernel 7** · Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. Check both the Compute Workload Analysis and Memory Workload Analysis sections.

> **ℹ️ INF** — **Kernel 8** · This workload is utilizing greater than 80.0% of the available compute or memory performance of the device. To further improve performance, work will likely need to be shifted from the most utilized to another unit. Start by analyzing workloads in the Compute Workload Analysis section.

> **⚙️ OPT** — **Kernel 9** · This workload exhibits low compute throughput and memory bandwidth utilization relative to the peak performance of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak typically indicate latency issues. Look at Scheduler Statistics and Warp State Statistics for potential reasons.

> **⚙️ OPT** — **Kernel 10** · This workload exhibits low compute throughput and memory bandwidth utilization relative to the peak performance of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak typically indicate latency issues. Look at Scheduler Statistics and Warp State Statistics for potential reasons.

> **⚙️ OPT** — **Kernel 11** · This workload exhibits low compute throughput and memory bandwidth utilization relative to the peak performance of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak typically indicate latency issues. Look at Scheduler Statistics and Warp State Statistics for potential reasons.

> **⚙️ OPT** — **Kernel 12** · This workload exhibits low compute throughput and memory bandwidth utilization relative to the peak performance of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak typically indicate latency issues. Look at Scheduler Statistics and Warp State Statistics for potential reasons.



---

## PM Sampling

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Maximum Buffer Size | Mbyte | 7.47 | 7.47 | 14.94 | 14.94 | 14.94 | 7.47 | 7.47 | 7.47 | 7.47 | 7.47 | 7.47 | 7.47 |
| Maximum Sampling Interval | cycle | 20000 | 20000 | 20000 | 20000 | 20000 | 20000 | 20000 | 20000 | 20000 | 20000 | 20000 | 20000 |
| # Pass Groups |  | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |

---

## Compute Workload Analysis

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Executed Ipc Active | inst/cycle | 1.07 | 1.03 | 2.36 | 1.27 | 1.38 | 1.37 | 2.04 | 1.22 | 0.88 | 1.06 | 1.06 | 1.06 |
| Executed Ipc Elapsed | inst/cycle | 1.07 | 1.03 | 2.36 | 1.27 | 1.38 | 1.37 | 2.04 | 1.22 | 0.88 | 1.06 | 1.06 | 1.06 |
| Issue Slots Busy | % | 26.87 | 25.76 | 58.90 | 31.66 | 34.40 | 34.15 | 51.01 | 30.58 | 22.01 | 26.61 | 26.61 | 26.61 |
| Issued Ipc Active | inst/cycle | 1.07 | 1.03 | 2.36 | 1.27 | 1.38 | 1.37 | 2.04 | 1.22 | 0.88 | 1.06 | 1.06 | 1.06 |
| SM Busy | % | 28.66 | 32.46 | 58.90 | 31.66 | 35.22 | 34.78 | 51.01 | 34.33 | 24.37 | 26.61 | 26.61 | 26.61 |

### Analysis Comments

> **⚙️ OPT** — **Kernel 1** · **Est. Local Speedup: 86.42%** · All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.

> **⚙️ OPT** — **Kernel 2** · **Est. Local Speedup: 89.33%** · All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.

> **ℹ️ INF** — **Kernel 3** · ALU is the highest-utilized pipeline (50.5%) based on elapsed cycles in the workload, taking into account the rates of its different instructions. It executes integer and logic operations. It is well-utilized, but should not be a bottleneck.

> **⚙️ OPT** — **Kernel 4** · **Est. Local Speedup: 80.08%** · All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.

> **ℹ️ INF** — **Kernel 5** · ALU is the highest-utilized pipeline (24.9%) based on elapsed cycles in the workload, taking into account the rates of its different instructions. It executes integer and logic operations. It is well-utilized, but should not be a bottleneck.

> **ℹ️ INF** — **Kernel 6** · ALU is the highest-utilized pipeline (24.2%) based on elapsed cycles in the workload, taking into account the rates of its different instructions. It executes integer and logic operations. It is well-utilized, but should not be a bottleneck.

> **ℹ️ INF** — **Kernel 7** · ALU is the highest-utilized pipeline (36.3%) based on elapsed cycles in the workload, taking into account the rates of its different instructions. It executes integer and logic operations. It is well-utilized, but should not be a bottleneck.

> **⚙️ OPT** — **Kernel 8** · **Est. Local Speedup: 84.03%** · All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.

> **⚙️ OPT** — **Kernel 9** · **Est. Local Speedup: 92.66%** · All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.

> **⚙️ OPT** — **Kernel 10** · **Est. Local Speedup: 82.94%** · All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.

> **⚙️ OPT** — **Kernel 11** · **Est. Local Speedup: 82.94%** · All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.

> **⚙️ OPT** — **Kernel 12** · **Est. Local Speedup: 82.94%** · All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.



## Memory Workload Analysis

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| L1/TEX Hit Rate | % | 0.76 | 0.76 | 0.06 | 0.13 | 0.11 | 0.08 | 0.04 | 0.19 | 1.44 | 1.35 | 1.35 | 1.34 |
| L2 Hit Rate | % | 2.70 | 2.66 | 2.71 | 2.83 | 2.79 | 1.52 | 1.39 | 2.76 | 2.69 | 2.62 | 2.77 | 2.72 |
| Local Memory Spilling Request Overhead | % | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Max Bandwidth | % | 67.89 | 76.03 | 45.65 | 60.83 | 78.03 | 77.18 | 71.93 | 90.20 | 55.38 | 55.73 | 55.73 | 55.73 |
| Mem Busy | % | 36.22 | 41.03 | 25.55 | 48.18 | 43.69 | 43.23 | 40.43 | 46.90 | 30.18 | 30.68 | 30.68 | 30.68 |
| Mem Pipes Busy | % | 67.89 | 76.03 | 45.65 | 60.83 | 78.03 | 77.18 | 71.93 | 90.20 | 55.38 | 55.73 | 55.73 | 55.73 |
| Memory Throughput | Gbyte/s | 109.73 | 97.90 | 32.94 | 44.42 | 57.01 | 100.77 | 96.46 | 67.00 | 82.73 | 94.09 | 94.09 | 94.09 |


## Memory Workload Analysis Tables

### Optimization Insights

- **⚙️ OPT** — **Kernel 1** · Est. Speedup: **63.38%**
- **⚙️ OPT** — **Kernel 2** · Est. Speedup: **71.80%**
- **⚙️ OPT** — **Kernel 4** · Est. Speedup: **84.32%** | **71.01%** | **61.32%**
- **⚙️ OPT** — **Kernel 3** · Est. Speedup: **44.72%**
- **⚙️ OPT** — **Kernel 5** · Est. Speedup: **76.45%**
- **⚙️ OPT** — **Kernel 10** · Est. Speedup: **53.69%**
- **⚙️ OPT** — **Kernel 11** · Est. Speedup: **53.70%**
- **⚙️ OPT** — **Kernel 12** · Est. Speedup: **53.69%**
- **⚙️ OPT** — **Kernel 6** · Est. Speedup: **75.65%**
- **⚙️ OPT** — **Kernel 7** · Est. Speedup: **70.75%**
- **⚙️ OPT** — **Kernel 9** · Est. Speedup: **52.82%**
- **⚙️ OPT** — **Kernel 8** · Est. Speedup: **82.08%**



---

## Scheduler Statistics

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Active Warps Per Scheduler | warp | 6.21 | 6.34 | 7.50 | 7.26 | 7.17 | 7.24 | 7.29 | 6.97 | 5.36 | 5.93 | 5.93 | 5.93 |
| Eligible Warps Per Scheduler | warp | 0.37 | 0.36 | 1.29 | 0.53 | 0.56 | 0.60 | 0.96 | 0.52 | 0.34 | 0.41 | 0.41 | 0.41 |
| No Eligible | % | 73.12 | 74.24 | 41.08 | 68.34 | 65.60 | 65.85 | 48.98 | 69.41 | 76.84 | 71.95 | 71.95 | 71.95 |
| One or More Eligible | % | 26.88 | 25.76 | 58.92 | 31.66 | 34.40 | 34.15 | 51.02 | 30.59 | 23.16 | 28.05 | 28.05 | 28.05 |

### Optimization Insights

- **⚙️ OPT** — **Kernel 1** · **Est. Local Speedup: 32.11%**
- **⚙️ OPT** — **Kernel 2** · **Est. Local Speedup: 23.97%**
- **⚙️ OPT** — **Kernel 4** · **Est. Local Speedup: 39.17%**
- **⚙️ OPT** — **Kernel 3** · **Est. Local Speedup: 41.08%**
- **⚙️ OPT** — **Kernel 5** · **Est. Local Speedup: 21.97%**
- **⚙️ OPT** — **Kernel 10** · **Est. Local Speedup: 44.27%**
- **⚙️ OPT** — **Kernel 11** · **Est. Local Speedup: 44.27%**
- **⚙️ OPT** — **Kernel 12** · **Est. Local Speedup: 44.27%**
- **⚙️ OPT** — **Kernel 6** · **Est. Local Speedup: 22.82%**
- **⚙️ OPT** — **Kernel 7** · **Est. Local Speedup: 28.07%**
- **⚙️ OPT** — **Kernel 9** · **Est. Local Speedup: 44.62%**
- **⚙️ OPT** — **Kernel 8** · **Est. Local Speedup: 9.80%**



## Warp State Statistics

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Warp Cycles Per Executed Instruction | cycle | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
| Warp Cycles Per Issued Instruction | cycle | 23.09 | 24.62 | 12.74 | 22.94 | 20.83 | 21.19 | 14.28 | 22.80 | 23.14 | 21.16 | 21.16 | 21.16 |

### Comments:

**Kernel 1**
- OPT   Est. Speedup: 32.11%
- INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on

**Kernel 2**
- OPT   Est. Speedup: 23.97%
- INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on

**Kernel 4**
- OPT   Est. Speedup: 20.49%

**Kernel 3**
- OPT   Est. Speedup: 30.12%
- INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on

**Kernel 5**
- OPT   Est. Speedup: 30.26%

**Kernel 10**
- OPT   Est. Speedup: 33%
- INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on

**Kernel 11**
- OPT   Est. Speedup: 33%
- INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on

**Kernel 12**
- OPT   Est. Speedup: 33.01%
- INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on

**Kernel 6**
- OPT   Est. Speedup: 26.95%

**Kernel 7**
- OPT   Est. Speedup: 18.7%

**Kernel 9**
- OPT   Est. Speedup: 33.39%
- INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on

**Kernel 8**
- OPT   Est. Speedup: 38.7%



---

## Instruction Statistics

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Avg. Executed Instructions Per Scheduler | inst | 3735552 | 4050124.80 | 30579097.60 | 12333875.20 | 10446438.40 | 5799936 | 8998092.80 | 8034713.60 | 4168089.60 | 4456448 | 4456448 | 4456448 |
| Avg. Issued Instructions Per Scheduler | inst | 3735584 | 4050156.80 | 30579121.60 | 12333907.20 | 10446462.40 | 5799960 | 8998124.80 | 8034737.60 | 4168121.60 | 4456472 | 4456472 | 4456472 |
| Executed Instructions | inst | 597688320 | 648019968 | 4892655616 | 1973420032 | 1671430144 | 927989760 | 1439694848 | 1285554176 | 666894336 | 713031680 | 713031680 | 713031680 |
| Issued Instructions | inst | 597693440 | 648025088 | 4892659456 | 1973425152 | 1671433984 | 927993600 | 1439699968 | 1285558016 | 666899456 | 713035520 | 713035520 | 713035520 |


## Launch Statistics

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---||
| Driver Shared Memory Per Block | byte/block | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Dynamic Shared Memory Per Block | Kbyte/block | 1.02 | 1.02 | 1.02 | 1.02 | 1.02 | 1.02 | 1.02 | 1.02 | 1.02 | 1.02 | 1.02 | 1.02 |
| Registers Per Thread | register/thread | 16 | 16 | 16 | 16 | 16 | 16 | 30 | 16 | 16 | 16 | 16 | 16 |
| Shared Memory Configuration Size | Kbyte | 32.77 | 32.77 | 32.77 | 32.77 | 32.77 | 32.77 | 32.77 | 32.77 | 32.77 | 32.77 | 32.77 | 32.77 |
| Static Shared Memory Per Block | byte/block | 0 | 16 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Threads | thread | 536870912 | 536870912 | 536870912 | 536870912 | 536870912 | 268435456 | 268435456 | 536870912 | 536870912 | 536870912 | 536870912 | 536870912 |


## Occupancy

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---||
| Achieved Active Warps Per SM | warp | 25.39 | 25.87 | 30.17 | 29.26 | 28.93 | 29.19 | 29.37 | 28.19 | 20.80 | 23.01 | 23.00 | 23.01 |
| Achieved Occupancy | % | 79.36 | 80.85 | 94.29 | 91.43 | 90.40 | 91.22 | 91.78 | 88.11 | 65.01 | 71.89 | 71.88 | 71.90 |
| Block Limit Registers | block | 16 | 16 | 16 | 16 | 16 | 16 | 8 | 16 | 16 | 16 | 16 | 16 |
| Block Limit SM | block | 16 | 16 | 16 | 16 | 16 | 16 | 16 | 16 | 16 | 16 | 16 | 16 |
| Block Limit Shared Mem | block | 32 | 25 | 32 | 32 | 32 | 32 | 32 | 32 | 32 | 32 | 32 | 32 |
| Block Limit Warps | block | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 4 |
| Theoretical Active Warps per SM | warp | 32 | 32 | 32 | 32 | 32 | 32 | 32 | 32 | 32 | 32 | 32 | 32 |
| Theoretical Occupancy | % | 100 | 100 | 100 | 100 | 100 | 100 | 100 | 100 | 100 | 100 | 100 | 100 |

### Comments:

**atomic_global:**
- OPT   Est. Speedup: 20.64%

**atomic_per_block:**
- OPT   Est. Speedup: 19.15%

**shfl_down_sync:**
- OPT   Est. Speedup: 28.11%

**shfl_up_sync:**
- OPT   Est. Speedup: 28.12%

**shfl_xor_sync:**
- OPT   Est. Speedup: 28.1%

**unroll_fully:**
- OPT   Est. Speedup: 34.99%

**unroll_last_warp:**
- OPT   Est. Speedup: 9.795%



## GPU and Memory Workload Distribution

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---||
| Average DRAM Active Cycles | cycle | 40747437 | 41103667 | 45661573.50 | 46226667.50 | 46246582.50 | 45714255 | 45443960.50 | 47016219.50 | 41837156 | 42088217 | 42085528.50 | 42085191 |
| Average L1 Active Cycles | cycle | 13901237.70 | 15722142.70 | 51908653.67 | 38958718.23 | 30368401.82 | 16981664.98 | 17637795.27 | 26270287.57 | 18930750.20 | 16742064.32 | 16745090.22 | 16743481.05 |
| Average L2 Active Cycles | cycle | 18550921.34 | 20413513.94 | 38251265.09 | 39542857.75 | 36651407.34 | 22845282.56 | 23668054.59 | 33450780.19 | 22149979 | 21468039.19 | 21373383.22 | 21320952.75 |
| Average SM Active Cycles | cycle | 13901237.70 | 15722142.70 | 51908653.67 | 38958718.23 | 30368401.82 | 16981664.98 | 17637795.27 | 26270287.57 | 18930750.20 | 16742064.32 | 16745090.22 | 16743481.05 |
| Average SMSP Active Cycles | cycle | 13897871.24 | 15722047.88 | 51903604 | 38956775.49 | 30368337.81 | 16981517.77 | 17636299.94 | 26270062.06 | 17994724.79 | 15887153.43 | 15887560.41 | 15887103.26 |
| Total DRAM Elapsed Cycles | cycle | 949680128 | 1074092032 | 3546660864 | 2661682176 | 2074893312 | 1160269824 | 1205083136 | 1794921472 | 1293925376 | 1144071168 | 1144064000 | 1144033280 |
| Total L1 Elapsed Cycles | cycle | 556060784 | 628878880 | 2076508440 | 1558369576 | 1214764272 | 679338240 | 705575240 | 1050845736 | 757404424 | 669859824 | 669781304 | 669853720 |
| Total L2 Elapsed Cycles | cycle | 650205728 | 735186016 | 2427605376 | 1822103776 | 1420367584 | 794349440 | 824932992 | 1228741856 | 885553952 | 783259872 | 783247488 | 783231904 |
| Total SM Elapsed Cycles | cycle | 556060784 | 628878880 | 2076508440 | 1558369576 | 1214764272 | 679338240 | 705575240 | 1050845736 | 757404424 | 669859824 | 669781304 | 669853720 |
| Total SMSP Elapsed Cycles | cycle | 2224243136 | 2515515520 | 8306033760 | 6233478304 | 4859057088 | 2717352960 | 2822300960 | 4203382944 | 3029617696 | 2679439296 | 2679125216 | 2679414880 |


## Source Counters

| Metric Name | Metric Unit | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---||
| Avg. Divergent Branches | branches | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Branch Efficiency | % | 100 | 100 | 100 | 100 | 100 | 100 | 100 | 100 | 100 | 100 | 100 | 100 |
| Branch Instructions | inst | 69206016 | 69206016 | 169869312 | 203423744 | 169869312 | 93323264 | 143654912 | 69206016 | 98566144 | 71303168 | 71303168 | 71303168 |
| Branch Instructions Ratio | % | 0.12 | 0.11 | 0.03 | 0.10 | 0.10 | 0.10 | 0.10 | 0.05 | 0.15 | 0.10 | 0.10 | 0.10 |

### Optimization Insights

- **⚙️ OPT** — **Kernel 4** · **Est. Speedup: 70%**

---

## Summary Notes

### 📊 Data Consistency Observations

- **PM Sampling**: All kernels have identical Maximum Buffer Size (7.47 Mbyte) except **Kernel 3** and **Kernel 4** (14.94 Mbyte). All have identical Maximum Sampling Interval (20000 cycles) and # Pass Groups (1).

- **Launch Statistics - Registers Per Thread**: Most kernels use 16 registers/thread, except **Kernel 7** which uses 30 registers/thread.

- **Launch Statistics - Static Shared Memory**: **Kernel 2** allocates 16 bytes/block, all others allocate 0 bytes/block.

- **Launch Statistics - Threads**: **Kernel 6** and **Kernel 7** launch 268,435,456 threads (half of other kernels' 536,870,912 threads).

- **Occupancy - Block Limit Registers**: **Kernel 7** has Block Limit Registers of 8 blocks, while all others have 16 blocks.

- **Occupancy - Block Limit Shared Mem**: **Kernel 2** has Block Limit Shared Mem of 25 blocks, while all others have 32 blocks.

### 🚀 Performance Highlights

- **Highest Compute Throughput**: **Kernel 3** (SM Busy 58.90%, Compute Throughput 58.90%)
- **Highest Memory Throughput**: **Kernel 8** (Memory Throughput 90.20%)
- **Best Memory Access Efficiency**: **Kernel 9** (L1/TEX Cache Throughput 60.37%, L2 Cache Throughput 7.82%)
- **Highest Instruction Intensity**: **Kernel 3** (30.6M executed instructions per scheduler)

### 💡 Optimization Recommendations

- Kernels with `OPT` speedup indicators in Compute Workload Analysis (estimated 80-93% local speedup) suggest under-utilized compute pipelines due to small workload or insufficient warp scheduling. These are primary optimization targets.
- Memory bandwidth utilization varies significantly (32-110 Gbyte/s), with atomic operations and shuffle variants experiencing lower throughput.
- Several kernels show potential for ~70% speedup in Memory Workload Analysis, particularly **Kernel 4**.

---

**Document Generated:** NVIDIA Nsight Compute Profiling Report  
**Analysis Type:** Multi-kernel Comparative Analysis  
**Kernels Analyzed:** 12 parallel reduction implementations




