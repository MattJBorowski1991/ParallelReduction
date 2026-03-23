# CUDA Parallel Reduction Benchmark

A CUDA implementation of 12 parallel reduction kernels with Nsight Compute profiling analysis.

## Profiling Results

Average execution times (ms) over 15 profiling runs per kernel and array size varies in the columns from `N=4M` to `N=1073M`. 
Measured with cudaEventRecord.

| ID | Kernel | 4M | 8M | 16M | 33M | 67M | 134M | 268M | 536M | 1073M |
|:--:|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|-----|
| 1 | [atomic_global](kernels/atomic_global.cu) | 0.111 | 0.195 | 0.360 | 0.699 | 1.365 | 2.713 | 5.556 | 11.258 | 22.509 |
| 2 | [atomic_per_block](kernels/atomic_per_block.cu) | 0.121 | 0.210 | 0.394 | 0.767 | 1.496 | 3.003 | 6.116 | 12.312 | 24.704 |
| 3 | [interleaved_addr_divergent_branch](kernels/interleaved_addr_divergent_branch.cu) | 0.289 | 0.544 | 1.067 | 2.134 | 4.489 | 9.308 | 18.687 | 37.218 | 74.731 |
| 4 | [interleaved_addr_bank_conflicts](kernels/interleaved_addr_bank_conflicts.cu) | 0.225 | 0.423 | 0.820 | 1.613 | 3.168 | 6.360 | 12.756 | 25.615 | 51.450 |
| 5 | [sequential_addressing](kernels/sequential_addressing.cu) | 0.185 | 0.343 | 0.654 | 1.283 | 2.551 | 5.105 | 10.259 | 20.632 | 41.467 |
| 6 | [two_elems_per_thread](kernels/two_elems_per_thread.cu) | 0.115 | 0.203 | 0.377 | 0.730 | 1.439 | 2.860 | 5.946 | 12.102 | 24.383 |
| 7 | [two_elems_per_thread_grid_strided](kernels/two_elems_per_thread_grid_strided.cu) | 0.121 | 0.214 | 0.397 | 0.769 | 1.500 | 3.128 | 6.653 | 13.587 | 27.106 |
| 8 | [unroll_last_warp](kernels/unroll_last_warp.cu) | 0.162 | 0.305 | 0.561 | 1.098 | 2.167 | 4.369 | 8.942 | 17.922 | 35.855 |
| 9 | [unroll_fully](kernels/unroll_fully.cu) | 0.137 | 0.248 | 0.468 | 0.917 | 1.792 | 3.551 | 7.102 | 14.112 | 28.183 |
| 10 | [warp_intrinsics_shfl_down_sync](kernels/warp_intrinsics_shfl_down_sync.cu) | 0.125 | 0.222 | 0.421 | 0.815 | 1.599 | 3.177 | 6.417 | 12.912 | 25.839 |
| 11 | [warp_intrinsics_shfl_up_sync](kernels/warp_intrinsics_shfl_up_sync.cu) | 0.127 | 0.224 | 0.422 | 0.814 | 1.596 | 3.171 | 6.398 | 12.885 | 25.828 |
| 12 | [warp_intrinsics_shfl_xor_sync](kernels/warp_intrinsics_shfl_xor_sync.cu) | 0.123 | 0.224 | 0.433 | 0.829 | 1.595 | 3.178 | 6.403 | 12.897 | 25.848 |

![Duration Plot](prof/images/profiling_summary.svg)

![Percent Speedup Plot](prof/images/profiling_percent_vs_atomic.svg)

**Observations:**
- Performance advantage of faster kernels over the slowest grows with input size, though the gap plateaus beyond ~134M elements.
- Notable divergence in performance among the three warp-intrinsic kernels at small input sizes (N = 4M–33M).
- Relative performance of `two_elems_per_thread` and `two_elems_per_thread_grid_strided` deteriorates at larger input sizes.

---

## Charts

Measured with NCU for `N = 1,073,741,824` (`2^30`).

### Memory Workload

![Memory Workload Analysis](prof/graphs/ncu_memory_workload_analysis.png)

Kernel 1 (`atomic_global`) achieves the highest DRAM throughput, directly contributing to its best-in-class execution time. Lower values of the following metrics in other kernels do not necessarily imply proportionally worse performance:

- **Max Bandwidth** — percentage of peak bandwidth on data paths connecting SMs to caches and DRAM.
- **Mem Busy** — percentage of peak bandwidth for data transfers within the cache and DRAM hierarchy.

### Memory Throughput (Gbyte/s)

![Memory Throughput](prof/graphs/ncu_mem_throughput_gbytes.png)

The best-performing kernel 1 achieves the highest memory throughput, while the worst-performing kernel 3 yields the lowest — consistent with the expectation that reduction is a bandwidth-bound workload.

### Scheduler Statistics

![Scheduler Statistics](prof/graphs/ncu_scheduler_analysis.png)

High occupancy does not guarantee best performance. Kernels 1 and 2, which achieve the shortest execution times, exhibit the lowest occupancy. Conversely, Kernel 3 — the worst performer — shows the highest occupancy, illustrating that warp divergence and instruction overhead outweigh any occupancy benefit.

### Instruction Statistics

![Instruction Statistics](prof/graphs/ncu_instruction_statistics.png)

Kernel 3 (`interleaved_addr_divergent_branch`) executes approximately 10× more instructions than Kernels 1 and 2 due to warp divergence, making instruction overhead — rather than memory bandwidth — the dominant bottleneck.

### Source Counters

![Source Counters](prof/graphs/ncu_source_counters.png)

Surprisingly, Kernel 4 records more branch instructions than Kernel 3 despite the latter's higher divergence overhead. Also notable is the substantially higher branch instruction count for the fully unrolled kernel (ID 9) compared to the warp-intrinsic kernels (IDs 10–12).

## Architecture Notes

1. **No global synchronization** (beyond cooperative launch) exists in CUDA — the cost is prohibitive on hardware with a large number of SMs.
2. **Cooperative launch** restricts the grid to at most the maximum resident block count per device, which is a small number. Inputs requiring more blocks necessitate serialization.
3. **Multi-pass reduction** is therefore used: the kernel is launched multiple times, reducing the array in stages.
4. **Reductions are bandwidth-bound** — arithmetic intensity is 1 FLOP per input element. The primary optimization goal is maximizing memory throughput.
5. **Potential bottlenecks** include instruction overhead from any operation beyond loads, stores, and the reduction computation itself.

## Compile & Profile

**Compile all kernels, measure duration with cudaEventRecord**
```bash
make clean && make profile PROFILE_WARMUPS=5 PROFILE_RUNS=20
```

**Compile all kernels, profile with NCU**
```bash
make clean && make profile_ncu PROFILE_WARMUPS=5 PROFILE_RUNS=20
```

**Compile one kernel**
```bash
make clean && make KERNEL=interleaved_addr_divergent_branch
```

**Check correctness, measure duration with cudaEventRecord**
```bash
./bin/profile_interleaved_addr_divergent_branch --warmups=5 --runs=10
```

**Profile one kernel with NCU:**
```bash
ncu --set full ./bin/profile_unroll_last_warp >> unroll_last_warp.txt --warmups=5 --runs=20
```

**Batch NCU run with a lighter configuration:**
```bash
make profile_ncu NCU_SET=default NCU_FLAGS='--clock-control none --cache-control none --launch-count 1'
```

**Note:** `--set full` replays kernels multiple times and lowers SM clocks for metric collection, so `ncu`-reported kernel durations will be significantly longer (~2x) than `cudaEventRecord` timings measured outside `ncu`. To get closer agreement, disable clock and cache control:
```bash
ncu --set default --clock-control none --cache-control none --launch-count 1 ./bin/profile_<kernel> --warmups=0 --runs=1
```

## Full Nsight Compute report

Profile with PTX and SASS embedded:

```bash
ncu --import-source yes --set full --export prof/ncu/interleaved_addr_divergent_branch.ncu-rep ./bin/profile_interleaved_addr_divergent_branch --kernel=interleaved_addr_divergent_branch --warmup=5 --runs=10
```


## Directory Structure

```
.
├── bin/                      # Compiled executables
├── drivers/                  # Main driver (main.cu)
├── kernels/                  # Kernel implementations (*.cu)
├── inputs/                   # Data generation and I/O (data.cu, data.h)
├── include/                  # Configuration (config.h)
├── prof/                     # Profiling results and analysis
├── tools/                    # Utilities (check_cuda.h)
├── .cache/                   # Reference output cache
├── Makefile                  # Build configuration
└── README.md                 # This file
```
