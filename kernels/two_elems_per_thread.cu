#include <cuda_runtime.h>
#include "../include/config.h"
#include "../tools/check_cuda.h"

#define REDUCE_KERNEL two_elems_per_thread_step
#define BLOCKS_DIVISOR elemsPerThread

__global__ void two_elems_per_thread_step(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
)
{
    extern __shared__ int s[];

    const int tid = threadIdx.x;
    s[tid] = 0;
    __syncthreads();

    const int bid = blockIdx.x;

    const int idx = bid * elemsPerThread * blockDim.x + tid;
    
    // // Early exit if block starts beyond data
    // if(idx >= N) {
    //     s[tid] = 0;
    //     __syncthreads();
    //     if(tid == 0) output[bid] = 0;
    //     return;
    // }

    if(idx >= N) return;

    #pragma unroll
    for(int e = 0; e < elemsPerThread; ++e){
        int element = idx + e * blockDim.x;
        if(element < N){
            s[tid] += input[element];
        }
    }
    __syncthreads();

    for(int off = blockDim.x >> 1; off > 0; off >>= 1){
        if (tid < off) s[tid] += s[tid + off];
        __syncthreads();
    }

    if(tid == 0) output[bid] = s[0];
}

#include "reduce_launcher.h"