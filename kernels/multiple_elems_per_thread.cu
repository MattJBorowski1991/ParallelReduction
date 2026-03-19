#include <cuda_runtime.h>
#include "../include/config.h"
#include "../tools/check_cuda.h"

#define REDUCE_KERNEL multiple_elems_per_thread_step

__global__ void multiple_elems_per_thread_step(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
)
{
    __shared__ int s[THREADS];

    const int tid = threadIdx.x;
    s[tid] = 0;
    __syncthreads();

    const int bid = blockIdx.x;

    const int idx = bid * elemsPerThread * THREADS + tid;

    #pragma unroll
    for(int e = 0; e < elemsPerThread; ++e){
        int element = idx + e * THREADS;
        if(element < N){
            s[tid] += input[element];
        }
    }
    __syncthreads();

    for(int off = THREADS >> 1; off > 0; off >>= 1){
        if (tid < off) s[tid] += s[tid + off];
        __syncthreads();
    }

    if(tid == 0) output[bid] = s[0];
}

#include "reduce_launcher.h"