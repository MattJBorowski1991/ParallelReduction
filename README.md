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

**Basic correctness check and profiling:**
```bash
./bin/profile_interleaved_addressing_1
```

**With custom parameters:**
```bash
./bin/profile_interleaved_addressing_1 --warmups=5 --runs=10
```

## Behavior

- **Input:** Array of N ones (N = 8,388,608 by default)
- **Output:** Single integer = sum = N
- **First run:** Computes CPU reference and caches to `.cache/ref_N*.bin`
- **Correctness check:** Verifies GPU output against cached reference
- **Profiling:** Runs warmup iterations, then timed profiling iterations
- **NVIDIA Tools:** Use `ncu` (NVIDIA Compute Profiler) or `nvprof` for detailed metrics

## Profile with NVIDIA Tools

**Using `ncu` (newer, recommended):**
```bash
ncu --set full ./bin/profile_interleaved_addressing_1
```

**Output to file:**
```bash
ncu --set full -o results.ncu-rep ./bin/profile_interleaved_addressing_1
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
