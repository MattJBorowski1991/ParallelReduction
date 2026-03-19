#include <cuda_runtime.h>
#include "../include/config.h"

#define REDUCE_KERNEL sequential_addressing

__global__ void sequential_addressing(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
){

    const int tid = threadIdx.x;
    const int bid = blockIdx.x;
    const int gid = bid * THREADS + tid;
    __shared__ int s[THREADS];

    if(gid < N){
        s[tid] = input[gid];
    }else{
        s[tid] = 0;
    }
    __syncthreads();

    for(int off = THREADS >> 1; off > 0; off >>= 1){
        if(tid < off) s[tid] += s[tid + off];
        __syncthreads();
    }

    if(tid == 0) output[bid] = s[0];
}

#include "reduce_launcher.h"