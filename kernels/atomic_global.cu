#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"

#define REDUCE_KERNEL atomic_global_step

__global__ void atomic_global_step(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
){
    const int tid = threadIdx.x;
    const int bid = blockIdx.x;
    const int gid = bid * blockDim.x + tid;

    extern __shared__ int s[];
    
    if(tid == 0) s[0] = 0;
    __syncthreads();
    
    int value = 0;
    if(gid < N) value = input[gid];

    atomicAdd(&s[0], value);
    __syncthreads();

    if(tid == 0) output[bid] = s[0];
}

#include "reduce_launcher.h"
