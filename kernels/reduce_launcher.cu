#include <cuda_runtime.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"
#include <cstdio>

// Forward declaration of the kernel-specific reduce_step (defined in each kernel's .cu file)
__global__ void reduce_step(const int* __restrict__ input, int* __restrict__ output, int N);

extern "C" void solve(
    const int* input,
    int* output,
    int N,
    int* buf
){
    int* src = buf;
    int* dst = output;

    reduce_step<<<BLOCKS, THREADS>>>(input, src, N);
    CHECK_CUDA(cudaGetLastError());
    CHECK_CUDA(cudaDeviceSynchronize());

    int curr_size = BLOCKS;

    // Create events for timing the multi-pass reduction
    cudaEvent_t start, stop;
    CHECK_CUDA(cudaEventCreate(&start));
    CHECK_CUDA(cudaEventCreate(&stop));

    CHECK_CUDA(cudaEventRecord(start));

    while(curr_size > 1){
        int curr_blocks = (curr_size + THREADS - 1) / THREADS;
        reduce_step<<<curr_blocks, THREADS>>>(src, dst, curr_size);
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
