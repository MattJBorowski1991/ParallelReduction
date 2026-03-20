# CUDA Parallel Reduction Benchmark

A CUDA implementation of parallel reduction using interleaved addressing, optimized for profiling and performance analysis.

## Build

### Prerequisites
- NVIDIA CUDA Toolkit (11.0+)
- NVIDIA GPU (compute capability 7.0+)
- `nvcc` compiler in PATH

### Compile

**Default kernel (interleaved_addressing_1):**
```bash
make clean
make
```

Output: `bin/profile_interleaved_addressing_1`

**Custom GPU architecture (e.g., compute capability 8.0):**
```bash
make clean
make NVCC_ARCH=80
```

**With register constraints:**
```bash
make clean
make MAXRREGCOUNT=64
```

## Run

**Basic correctness check and duration measurement with cudaEventRecord**
```bash
./bin/profile_interleaved_addressing_1 --warmups=5 --runs=10
```

**Run all kernels at once and save each output to its own `.txt` file:**
```bash
make profile
```

**Customize warmups/runs for the batch run:**
```bash
make profile PROFILE_WARMUPS=5 PROFILE_RUNS=20
```

## Behavior

- **Input:** Array of N ones (N = 8,388,608 by default)
- **Output:** Single integer = sum = N
- **First run:** Computes CPU reference and caches to `.cache/ref_N*.bin`
- **Correctness check:** Verifies GPU output against cached reference
- **Profiling:** Runs warmup iterations, then timed profiling iterations
- **NVIDIA Tools:** Use `ncu` (NVIDIA Compute Profiler) or `nvprof` for detailed metrics

## Profile with NCU


**Run NCU on all kernels at once:**
```bash
make profile_ncu
```

**Output to file:**
```bash
ncu --set full ./bin/profile_unroll_last_warp >> unroll_last_warp.txt --warmups=3 --runs=15
```

**Batch NCU run with a lighter configuration:**
```bash
make profile_ncu NCU_SET=default NCU_FLAGS='--clock-control none --cache-control none --launch-count 1'
```

**Note:** `--set full` replays kernels multiple times and lowers SM clocks for metric collection, so `ncu`-reported kernel durations will be significantly longer (~2x) than `cudaEvent` timings measured outside `ncu`. To get closer agreement, disable clock and cache control:
```bash
ncu --set default --clock-control none --cache-control none --launch-count 1 ./bin/profile_<kernel> --warmups=0 --runs=1
```

## Directory Structure

```
.
├── bin/                      # Compiled executables
├── drivers/                  # Main driver (main.cu)
├── kernels/                  # Kernel implementations (*.cu)
├── inputs/                   # Data generation and I/O (data.cu, data.h)
├── include/                  # Configuration (config.h)
├── tools/                    # Utilities (check_cuda.h)
├── .cache/                   # Reference output cache
├── Makefile                  # Build configuration
└── README.md                 # This file
```

## Notes

- All device memory is allocated/freed within the kernel and main driver
- Reduction outputs a single value (sum of input)
- Caching avoids redundant CPU reference computation
- Check `include/config.h` to adjust `N`, `THREADS`, or `BLOCKS` at compile time
