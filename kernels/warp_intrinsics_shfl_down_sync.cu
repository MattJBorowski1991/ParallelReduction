#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"

#define REDUCE_KERNEL warp_intrinsics_shfl_down_sync_step

__global__ void warp_intrinsics_shfl_down_sync_step(
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

        int v = s[tid];
        unsigned mask = 0xFFFFFFFF;
        v += __shfl_down_sync(mask, v, 16);
        v += __shfl_down_sync(mask, v, 8);
        v += __shfl_down_sync(mask, v, 4);
        v += __shfl_down_sync(mask, v, 2);
        v += __shfl_down_sync(mask, v, 1);

        if(tid == 0) output[bid] = v;
    }
}
#include "reduce_launcher.h"