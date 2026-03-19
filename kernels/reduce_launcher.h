#ifndef REDUCE_LAUNCHER_H
#define REDUCE_LAUNCHER_H

// Forward declaration of the kernel launcher (implemented in reduce_launcher.cu)
extern "C" void solve(const int* input, int* output, int N, int* buf);

// Forward declaration of the kernel-specific reduce_step (defined in each kernel's .cu file)
__global__ void reduce_step(const int* __restrict__ input, int* __restrict__ output, int N);

#endif // REDUCE_LAUNCHER_H
