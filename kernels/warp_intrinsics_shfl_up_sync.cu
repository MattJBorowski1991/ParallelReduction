#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"

#define REDUCE_KERNEL warp_intrinsics_shfl_up_sync_step

__global__ void warp_intrinsics_shfl_up_sync_step(
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

    if(tid < 32){
        s[tid] += s[tid + 32];

        int value = s[tid];
        unsigned mask = 0xFFFFFFFF;
        value += __shfl_up_sync(mask, value, 16);
        value += __shfl_up_sync(mask, value, 8);
        value += __shfl_up_sync(mask, value, 4);
        value += __shfl_up_sync(mask, value, 2);
        value += __shfl_up_sync(mask, value, 1);

        if(tid == 31) output[bid] = value;
    }
}
#include "reduce_launcher.h"
