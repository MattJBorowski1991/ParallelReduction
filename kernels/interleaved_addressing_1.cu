
#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"

#define REDUCE_KERNEL interleaved_addressing_1_step

__global__ void interleaved_addressing_1_step(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
){
    __shared__ int shared[THREADS];

    const int tid = threadIdx.x;
    const int bid = blockIdx.x;
    const int gid = bid * THREADS + tid;

    if(tid < THREADS){
        shared[tid] = input[gid];
    }else{
        shared[tid] = 0;
    }
    __syncthreads();

    for(int s = 1; s < THREADS; s <<= 1){
        if(tid % (2*s) == 0) shared[tid] += shared[tid + s];
        __syncthreads();
    }

    if(tid == 0) output[bid] = shared[0];
}

#include "reduce_launcher.h"