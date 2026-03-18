#ifndef DATA_H
#define DATA_H

#include <vector>

void initialize_host_data(std::vector<int>& h_input, int N);

void initialize_host_reference_data(std::vector<int>& h_input, std::vector<int>& h_output, int N);

void allocate_and_copy_to_device(const std::vector<int>& h_input, int*& d_input, int*& d_output, int N);

void cleanup_device_data(int* d_input, int* d_output);

bool save_inputs(const std::vector<int>& h_input, const char* filename, int N);

bool load_inputs(std::vector<int>& h_input, const char* filename, int N);

bool save_reference(const std::vector<int>& h_input, const std::vector<int>& ref_output, const char* filename, int N);

bool load_reference(std::vector<int>& h_input, std::vector<int>& ref_output, const char* filename, int N);

bool verify_results(const std::vector<int>& h_output, const std::vector<int>& ref_output, int N);

#endif //DATA_H