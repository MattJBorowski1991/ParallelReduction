#include <cuda_runtime.h>
#include "../include/config.h"
#include "../tools/check_cuda.h"

#define REDUCE_KERNEL multiple_elems_per_thread_2_step

__global__ void multiple_elems_per_thread_2_step(
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
        s[tid] += input[idx] + input[idx + threads];
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