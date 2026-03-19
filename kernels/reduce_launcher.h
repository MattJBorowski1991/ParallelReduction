#pragma once
#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"
#include <cstdio>

// Each kernel file must #define REDUCE_KERNEL before including this
// e.g. #define REDUCE_KERNEL interleaved_addressing_1_step


extern "C" void solve(
    const int* input,
    int* output,
    int N,
    int* buf
){
    int* src = buf;
    int* dst = output;

    REDUCE_KERNEL<<<BLOCKS, THREADS>>>(input, src, N);
    CHECK_CUDA(cudaGetLastError());
    CHECK_CUDA(cudaDeviceSynchronize());
    
    int curr_size = BLOCKS;

    cudaEvent_t start, stop;
    CHECK_CUDA(cudaEventCreate(&start));
    CHECK_CUDA(cudaEventCreate(&stop));

    CHECK_CUDA(cudaEventRecord(start));
    while(curr_size > 1){
        int curr_blocks = (curr_size + THREADS - 1) / THREADS;
        REDUCE_KERNEL<<<curr_blocks, THREADS>>>(src, dst, curr_size);
        CHECK_CUDA(cudaGetLastError());
        CHECK_CUDA(cudaDeviceSynchronize());
        int* tmp = dst; dst = src; src = tmp;
        curr_size = curr_blocks;
    }
    CHECK_CUDA(cudaEventRecord(stop));
    CHECK_CUDA(cudaEventSynchronize(stop));

    float elapsed_ms;
    CHECK_CUDA(cudaEventElapsedTime(&elapsed_ms, start, stop));
    std::printf("Multi-pass reduction time: %.3f ms\n", elapsed_ms);

    CHECK_CUDA(cudaEventDestroy(start));
    CHECK_CUDA(cudaEventDestroy(stop));

    if(src != output){
        CHECK_CUDA(cudaMemcpy(output, src, sizeof(int), cudaMemcpyDeviceToDevice));
    }
}
