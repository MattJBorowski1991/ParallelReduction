
#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"

#define REDUCE_KERNEL interleaved_addressing_1_step

__global__ void interleaved_addressing_1_step(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
){
    extern __shared__ int shared[];

    const int tid = threadIdx.x;
    const int bid = blockIdx.x;
    const int gid = bid * blockDim.x + tid;

    if(gid < N){
        shared[tid] = input[gid];
    }else{
        shared[tid] = 0;
    }
    __syncthreads();

    for(int s = 1; s < blockDim.x; s <<= 1){
        if(tid % (2*s) == 0) shared[tid] += shared[tid + s];
        __syncthreads();
    }

    if(tid == 0) output[bid] = shared[0];
}

#include "reduce_launcher.h"