#include "data.h"
#include "../tools/check_cuda.h"
#include <vector>
#include <fstream>
#include <cstring>
#include <algorithm>
#include <random>
#include <iostream>

void initialize_host_reference_data(std::vector<int>& h_input, std::vector<int>& h_output, int N){
    h_input.resize(N);
    h_output.resize(1);
    
    // Try to load cached input
    std::string cache_file = ".cache/input_N" + std::to_string(N) + ".bin";
    std::printf("Attempting to load cached input from %s...\n", cache_file.c_str());
    
    if(load_inputs(h_input, cache_file.c_str(), N)){
        std::printf("✓ Cache loaded successfully!\n");
        h_output[0] = N;
        return;
    }
    
    // Generate input of all 1s
    std::printf("\n✗ Cache not found. Generating input on-host...\n");
    
    const int progress_interval = std::max(1, N / 100);  // Update every 1% of progress
    for(int i = 0; i < N; ++i){
        h_input[i] = 1;
        
        // Simple progress output
        if((i + 1) % progress_interval == 0){
            int percent = (((long long)(i + 1) * 100) / N);
            std::printf("\rGeneration progress: %d%% (%d/%d)", percent, (i + 1), N);
            std::fflush(stdout);
        }
    }
    std::printf("\n");
    
    // Save to cache for next run
    save_inputs(h_input, cache_file.c_str(), N);
    std::printf("✓ Input generation complete and cached!\n\n");
    
    h_output[0] = N;  // Sum of all 1s is N
}


void allocate_and_copy_to_device(const std::vector<int>& h_input, int*& d_input, int*& d_output, int*& d_buf, int N){
    d_input = nullptr;
    d_output = nullptr;
    d_buf = nullptr;

    size_t input_bytes = static_cast<size_t>(N) * sizeof(int);
    size_t output_bytes = sizeof(int);
    size_t buf_bytes = static_cast<size_t>(N) * sizeof(int);
    CHECK_CUDA(cudaMalloc((void**)&d_input, input_bytes));
    CHECK_CUDA(cudaMalloc((void**)&d_output, output_bytes));
    CHECK_CUDA(cudaMalloc((void**)&d_buf, buf_bytes));
    CHECK_CUDA(cudaMemcpy(d_input, h_input.data(), input_bytes, cudaMemcpyHostToDevice));
    CHECK_CUDA(cudaMemset(d_output, 0, output_bytes));
}

void cleanup_device_data(int* d_input, int* d_output, int* d_buf){
    if(d_input) CHECK_CUDA(cudaFree(d_input));
    if(d_output) CHECK_CUDA(cudaFree(d_output));
    if(d_buf) CHECK_CUDA(cudaFree(d_buf));
}

bool save_inputs(const std::vector<int>&h_input, const char* filename, int N){
    std::ofstream file(filename, std::ios::binary);
    if(!file){
        std::fprintf(stderr, "Failed to open %s for writing \n", filename);
        return false;
    }

    file.write(reinterpret_cast<const char*>(&N), sizeof(N));
    file.write(reinterpret_cast<const char*>(h_input.data()), (size_t)N * sizeof(int));
    
    file.close();
    std::printf("Saved input to %s \n", filename);
    return true;
}

bool load_inputs(std::vector<int>& h_input, const char* filename, int N){
    std::ifstream file(filename, std::ios::binary);
    if(!file) return false;

    int saved_N;
    file.read(reinterpret_cast<char*>(&saved_N), sizeof(N));
    if(saved_N != N){
        std::fprintf(stderr, "Input cache mismatch: expected N=%d but got N=%d \n", N, saved_N);
        file.close();
        return false;
    }

    file.read(reinterpret_cast<char*>(h_input.data()), N * sizeof(int));

    std::printf("Loaded input array from %s \n", filename);
    return true;
}

bool verify_results(const std::vector<int>& h_output, const std::vector<int>& ref_output, int N){
    if(h_output.size() < 1 || ref_output.size() < 1){
        std::cerr << "Size mismatch\n";
        return false;
    }
    if(h_output[0] != ref_output[0]){
        std::cerr << "Mismatch: got " << h_output[0] << " expected " << ref_output[0] << std::endl;
        return false;
    }
    return true;
}

bool save_reference(const std::vector<int>& h_input, const std::vector<int>& ref_output, const char* filename, int N){
    std::ofstream file(filename, std::ios::binary);
    if(!file){
        std::fprintf(stderr, "Failed to open %s for writing\n", filename);
        return false;
    }

    file.write(reinterpret_cast<const char*>(&N), sizeof(N));
    file.write(reinterpret_cast<const char*>(h_input.data()), (size_t)N * sizeof(int));
    int result = ref_output[0];
    file.write(reinterpret_cast<const char*>(&result), sizeof(int));
    file.close();
    return true;
}

bool load_reference(std::vector<int>& h_input, std::vector<int>& ref_output, const char* filename, int N){
    std::ifstream file(filename, std::ios::binary);
    if(!file) return false;

    int saved_N;
    file.read(reinterpret_cast<char*>(&saved_N), sizeof(N));
    if(saved_N != N){
        file.close();
        return false;
    }

    h_input.resize(N);
    ref_output.resize(1);
    file.read(reinterpret_cast<char*>(h_input.data()), N * sizeof(int));
    file.read(reinterpret_cast<char*>(ref_output.data()), sizeof(int));
    file.close();
    return true;
}
