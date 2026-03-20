#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"

#define REDUCE_KERNEL atomic_per_block_step

__global__ void atomic_per_block_step(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
){
    const int tid = threadIdx.x;
    const int bid = blockIdx.x;
    const int gid = bid * blockDim.x + tid;

    __shared__ int temp_output;

    if(tid == 0) temp_output = 0;
    __syncthreads();

    extern __shared__ int s[];

    if(gid < N){
        s[tid] = input[gid];
    }else{
        s[tid] = 0;
    }
    __syncthreads();

    atomicAdd(&temp_output, s[tid]);
    __syncthreads();

    if(tid == 0) output[bid] = temp_output;
}

#include "reduce_launcher.h"
