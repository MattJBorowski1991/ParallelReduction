#include <cuda_runtime.h>
#include "../include/config.h"

#define REDUCE_KERNEL unroll_fully_step

template<int BLOCK_SIZE>
__device__ __forceinline__ void warpReduce(int* shared, int tid){
    if(BLOCK_SIZE >= 64 && tid < 32) shared[tid] += shared[tid + 32]; __syncwarp();
    if(BLOCK_SIZE >= 32 && tid < 16) shared[tid] += shared[tid + 16]; __syncwarp();
    if(BLOCK_SIZE >= 16 && tid < 8)  shared[tid] += shared[tid + 8]; __syncwarp();
    if(BLOCK_SIZE >= 8 && tid < 4) shared[tid] += shared[tid + 4]; __syncwarp();
    if(BLOCK_SIZE >= 4 && tid < 2) shared[tid] += shared[tid + 2]; __syncwarp();
    if(BLOCK_SIZE >= 2 && tid < 1) shared[tid] += shared[tid + 1]; __syncwarp();
}

template<int BLOCK_SIZE>
__global__ void unroll_fully_step_t(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
){  
    extern __shared__ int s[];

    const int tid = threadIdx.x;
    const int bid = blockIdx.x;
    const int gid = bid * BLOCK_SIZE + tid;

    if(gid < N){
        s[tid] = input[gid];
    }else{
        s[tid] = 0;
    }
    __syncthreads();

    if(BLOCK_SIZE >= 1024 && tid < 512) s[tid] += s[tid + 512];
    if(BLOCK_SIZE >= 1024) __syncthreads();
    if(BLOCK_SIZE >= 512 && tid < 256) s[tid] += s[tid + 256];
    if(BLOCK_SIZE >= 512) __syncthreads();
    if(BLOCK_SIZE >= 256 && tid < 128) s[tid] += s[tid + 128];
    if(BLOCK_SIZE >= 256) __syncthreads();
    if(BLOCK_SIZE >= 128 && tid < 64) s[tid] += s[tid + 64];
    if(BLOCK_SIZE >= 128) __syncthreads();

    if(tid < 32) warpReduce<BLOCK_SIZE>(s, tid);

    if(tid == 0) output[bid] = s[0];
}

static inline void launch_unroll_fully(
    const int* input,
    int* output,
    int N,
    int blocks,
    int threads
){
    size_t shared_bytes = threads * sizeof(int);
    switch(threads){
        case 1024: unroll_fully_step_t<1024><<<blocks, 1024, shared_bytes>>>(input, output, N); break;
        case 512:  unroll_fully_step_t<512><<<blocks, 512, shared_bytes>>>(input, output, N); break;
        case 256:  unroll_fully_step_t<256><<<blocks, 256, shared_bytes>>>(input, output, N); break;
        case 128:  unroll_fully_step_t<128><<<blocks, 128, shared_bytes>>>(input, output, N); break;
        case 64:   unroll_fully_step_t<64><<<blocks, 64, shared_bytes>>>(input, output, N); break;
        case 32:   unroll_fully_step_t<32><<<blocks, 32, shared_bytes>>>(input, output, N); break;
        default:   unroll_fully_step_t<512><<<blocks, 512, shared_bytes>>>(input, output, N); break;
    }
}

#define REDUCE_LAUNCH(input, output, n, blocks, threads) \
    launch_unroll_fully(input, output, n, blocks, threads)

#include "reduce_launcher.h"