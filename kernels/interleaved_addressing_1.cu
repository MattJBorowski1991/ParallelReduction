
#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"

__global__ void reduce_step(
    const int* __restrict__ input,
    int* __restrict__ output,
    int N
){
    __shared__ int shared[THREADS];

    const int tid = threadIdx.x;
    const int bid = blockIdx.x;
    const int gid = bid * THREADS + tid;

    shared[tid] = input[gid];
    __syncthreads();

    for(int s = 1; s < THREADS; s <<= 1){
        if(tid % (2*s) == 0) shared[tid] += shared[tid + s];
        __syncthreads();
    }

    if(tid == 0) output[bid] = shared[0];


}

extern "C" void solve(
    const int* input,
    int* output,
    int N
){
    int* buf = nullptr;
    CHECK_CUDA(cudaMalloc(&buf, N * sizeof(int)));

    reduce_step<<<BLOCKS, THREADS>>>(input, buf, N);
    CHECK_CUDA(cudaGetLastError());
    CHECK_CUDA(cudaDeviceSynchronize());

    int* src = buf;
    int* dst = output;

    int curr_size = BLOCKS;

    while(curr_size > 1){
        int curr_blocks = (curr_size + THREADS - 1) / THREADS;
        reduce_step<<<curr_blocks, THREADS>>>(src, dst, curr_size);
        CHECK_CUDA(cudaGetLastError());
        CHECK_CUDA(cudaDeviceSynchronize());
        int* tmp = dst; dst = src; src = tmp;
        curr_size = curr_blocks;
    }

    if(src != output){
        CHECK_CUDA(cudaMemcpy(output, src, sizeof(int), cudaMemcpyDeviceToDevice));
    }

    CHECK_CUDA(cudaFree(buf));
}