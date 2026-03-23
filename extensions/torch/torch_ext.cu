#include <torch/extension.h>
#include <ATen/cuda/CUDAContext.h>
#include <cuda_runtime.h>

// Define runtime-configurable symbols expected by the kernels.
// `config.h` declares `extern int THREADS;` and some kernels rely on it.
// Define it here so the included kernel and launcher see a concrete value.
int THREADS = 256;

// Include the kernel implementation directly to avoid device-linking issues
// when compiling multiple separate .cu translation units. This keeps the
// `atomic_global_step` symbol in this translation unit so the triple-chevron
// launch resolves correctly.
#include "../../kernels/atomic_global.cu"

// Simple launcher for the atomic_global kernel. Minimal checks performed.
at::Tensor launch_atomic_global(at::Tensor input) {
    TORCH_CHECK(input.is_cuda(), "input must be a CUDA tensor");
    TORCH_CHECK(input.scalar_type() == at::kInt, "input must be int32");
    auto N = input.numel();

    const int threads = 256;
    const int blocks = (int)((N + threads - 1) / threads);

    auto options = torch::TensorOptions().dtype(torch::kInt32).device(input.device());
    at::Tensor output = at::zeros({blocks}, options);

    const int* input_ptr = input.data_ptr<int>();
    int* output_ptr = output.data_ptr<int>();

    // Shared memory per block: allocate threads * sizeof(int)
    size_t shared_mem_bytes = threads * sizeof(int);

    cudaStream_t stream = at::cuda::getCurrentCUDAStream();

    // Launch kernel (nvcc compiles this file so <<<>>> is valid)
    atomic_global_step<<<blocks, threads, shared_mem_bytes, stream>>>(input_ptr, output_ptr, (int)N);

    // check for kernel launch errors
    cudaError_t err = cudaGetLastError();
    TORCH_CHECK(err == cudaSuccess, "atomic_global kernel launch failed: ", cudaGetErrorString(err));

    return output;
}

PYBIND11_MODULE(TORCH_EXTENSION_NAME, m) {
    m.def("launch_atomic_global", &launch_atomic_global, "Launch atomic_global kernel (returns per-block sums)");
}
