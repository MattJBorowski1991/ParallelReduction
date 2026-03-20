#include <cuda_runtime.h>
#include <cuda_profiler_api.h>
#include "../tools/check_cuda.h"
#include "../include/config.h"
#include "../inputs/data.h"
#include <vector>
#include <stdio.h>
#include <string>
#include <cstring>
#include <cstdlib>
#include <sys/stat.h>

// Define the runtime-configurable THREADS variable
int THREADS = 512;

// Forward declaration of the kernel-specific solve function
extern "C" void solve(const int* input, int* output, int N, int* buf);

// helper to construct cache filename
std::string get_cache_filename(int N){
    char buffer[256];
    snprintf(buffer, sizeof(buffer), ".cache/ref_N%d.bin", N);
    return std::string(buffer);
}

//helper to ensure .cache directory exists
bool ensure_cache_dir(){
    const char* dir = ".cache";
    struct stat st = {};
    if (stat(dir, &st) == 0 && S_ISDIR(st.st_mode)){
        return true;
    }
#ifdef _WIN32
    return mkdir(dir) == 0;
#else
    return mkdir(dir, 0755) == 0;
#endif
}


int main(int argc, char** argv){
    std::string kernel = "interleaved_addressing_1";
    int warmups = 3;
    int runs = 15;
    
    //argument parsing loop
    for(int i = 1; i < argc; ++i){
        if(std::strncmp(argv[i], "--kernel=", 9) == 0) kernel = std::string(argv[i] + 9);
        else if(std::strncmp(argv[i], "--warmups=", 10) == 0) warmups = std::atoi(argv[i] + 10);
        else if(std::strncmp(argv[i], "--runs=", 7) == 0) runs = std::atoi(argv[i]+7);
        else if(std::strcmp(argv[i], "--help") == 0){
            std::printf("Usage: %s [--kernel=KERNEL] [--warmups=N] [--runs=M] [--random]\n", argv[0]);
            std::printf("  KERNEL options: interleaved_addressing_1, ...\n");
            return 0;
        }
    }

    //allocate host vectors
    std::vector<int> h_input(N);
    std::vector<int> h_output(1);

    //device pointers
    int *d_input = nullptr, *d_output = nullptr, *d_buf = nullptr;
    



    std::vector<int> ref_output(1);

    //try to load cache reference, compute if not found
    ensure_cache_dir();
    std::string ref_cache_file = get_cache_filename(N);
    if(!load_reference(h_input, ref_output, ref_cache_file.c_str(), N)){
        std::printf("Computing CPU reference ...\n");
        initialize_host_reference_data(h_input, ref_output, N);
        save_reference(h_input, ref_output, ref_cache_file.c_str(), N);
    }


    std::printf("Allocating and copying data to device... \n");
    allocate_and_copy_to_device(h_input, d_input, d_output, d_buf, N);

    std::printf("Running correctness check... \n");
    solve(d_input, d_output, N, d_buf);
    CHECK_CUDA(cudaDeviceSynchronize());
    CHECK_CUDA(cudaMemcpy(h_output.data(), d_output, sizeof(int), cudaMemcpyDeviceToHost));

    if(!verify_results(h_output, ref_output, N)){
        std::fprintf(stderr, "Correctness check FAILED.\n");
        cleanup_device_data(d_input, d_output, d_buf);
        return 1;
    }
    std::printf("Correctness check PASSED.\n");

    std::printf("Running %d warmup runs...\n", warmups);
    for(int i = 0; i < warmups; ++i){
        solve(d_input, d_output, N, d_buf);
        CHECK_CUDA(cudaGetLastError());
        CHECK_CUDA(cudaDeviceSynchronize());
    }

    std::printf("Running %d profiling runs...\n", runs);

    CHECK_CUDA(cudaProfilerStart());

    for(int i = 0; i < runs; ++i){
        solve(d_input, d_output, N, d_buf);
        CHECK_CUDA(cudaGetLastError());
        CHECK_CUDA(cudaDeviceSynchronize());
    }

    CHECK_CUDA(cudaProfilerStop());

    CHECK_CUDA(cudaMemcpy(h_output.data(), d_output, sizeof(int), cudaMemcpyDeviceToHost));

    cleanup_device_data(d_input, d_output, d_buf);

    std::printf("Profiling complete.\n");
    return 0;
}

