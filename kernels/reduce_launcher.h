#pragma once
#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"
#include <cstdio>

// Each kernel file must #define REDUCE_KERNEL before including this
// e.g. #define REDUCE_KERNEL interleaved_addressing_1_step
// Optional: #define BLOCKS_DIVISOR N (for multi-elem kernels, set to elemsPerThread)

#ifndef BLOCKS_DIVISOR
#define BLOCKS_DIVISOR 1
#endif

#ifndef REDUCE_LAUNCH
#define REDUCE_LAUNCH(input, output, n, blocks, threads) \
    REDUCE_KERNEL<<<(blocks), (threads), (threads) * sizeof(int)>>>(input, output, n)
#endif


extern "C" void solve(
    const int* input,
    int* output,
    int N,
    int* buf
){
    cudaEvent_t start, stop;
    CHECK_CUDA(cudaEventCreate(&start));
    CHECK_CUDA(cudaEventCreate(&stop));

    CHECK_CUDA(cudaEventRecord(start));

    int* src = buf;
    int* dst = output;
    int blocks = (N + BLOCKS_DIVISOR * THREADS - 1) / (BLOCKS_DIVISOR * THREADS);  // Compute blocks at runtime

    REDUCE_LAUNCH(input, src, N, blocks, THREADS);
    CHECK_CUDA(cudaGetLastError());
    CHECK_CUDA(cudaDeviceSynchronize());
    
    int curr_size = blocks;

    while(curr_size > 1){
        int curr_blocks = (curr_size + BLOCKS_DIVISOR * THREADS - 1) / (BLOCKS_DIVISOR * THREADS);
        REDUCE_LAUNCH(src, dst, curr_size, curr_blocks, THREADS);
        CHECK_CUDA(cudaGetLastError());
        CHECK_CUDA(cudaDeviceSynchronize());
        int* tmp = dst; dst = src; src = tmp;
        curr_size = curr_blocks;
    }


    if(src != output){
        CHECK_CUDA(cudaMemcpy(output, src, sizeof(int), cudaMemcpyDeviceToDevice));
    }

    CHECK_CUDA(cudaEventRecord(stop));
    CHECK_CUDA(cudaEventSynchronize(stop));

    float elapsed_ms;
    CHECK_CUDA(cudaEventElapsedTime(&elapsed_ms, start, stop));
    std::printf("Multi-pass reduction time: %.3f ms\n", elapsed_ms);

    CHECK_CUDA(cudaEventDestroy(start));
    CHECK_CUDA(cudaEventDestroy(stop));
}
