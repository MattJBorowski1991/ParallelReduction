#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"

#define REDUCE_KERNEL unroll_last_warp_step

__device__ void warpReduce(int* shared, int tid){
    if(tid < 32) shared[tid] += shared[tid + 32]; __syncwarp(); //ensure writes from participating threads are visible to all 32 threads
    if(tid < 16) shared[tid] += shared[tid + 16]; __syncwarp();
    if(tid < 8) shared[tid] += shared[tid + 8]; __syncwarp();
    if(tid < 4) shared[tid] += shared[tid + 4]; __syncwarp();
    if(tid < 2) shared[tid] += shared[tid + 2]; __syncwarp();
    if(tid < 1) shared[tid] += shared[tid + 1]; __syncwarp();
}


__global__ void unroll_last_warp_step(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
){
    const int tid = threadIdx.x;
    const int bid = blockIdx.x;
    const int gid = bid * blockDim.x + tid;

    extern __shared__ int s[];

    if(gid < N){
        s[tid] = input[gid];
    }else{
        s[tid] = 0;
    }
    __syncthreads();

    for(int off = blockDim.x >> 1; off > 32; off >>= 1){
        if(tid < off) s[tid] += s[tid + off];
        __syncthreads();
    }  

    warpReduce(s, tid);

    if(tid == 0) output[bid] = s[0];
}

#include "reduce_launcher.h"