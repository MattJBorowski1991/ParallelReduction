#include <cuda_runtime.h>
#include "../include/config.h"
#include "../tools/check_cuda.h"

#define REDUCE_KERNEL two_elems_per_thread_grid_strided_step
#define BLOCKS_DIVISOR 2


__global__ void two_elems_per_thread_grid_strided_step(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
)
{
    extern __shared__ int s[];
    const int threads = blockDim.x;

    const int tid = threadIdx.x;
    s[tid] = 0;
    __syncthreads();

    const int bid = blockIdx.x;

    int idx = bid * (2 * threads) + tid;

    const int gridSize = gridDim.x * (2 * threads);

    while(idx < N){
        int val1 = input[idx];
        int val2 = (idx + threads < N) ? input[idx + threads] : 0;
        s[tid] += val1 + val2;
        idx += gridSize;
    }
    __syncthreads();

    for(int off = threads >> 1; off > 0; off >>= 1){
        if (tid < off) s[tid] += s[tid + off];
        __syncthreads();
    }

    if(tid == 0) output[bid] = s[0];
}

#include "reduce_launcher.h"