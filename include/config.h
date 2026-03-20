#include <math.h>

#ifndef CONFIG_H
#define CONFIG_H

constexpr int N = 16777216;
extern int THREADS;  // Runtime configurable, defined in main.cu
constexpr int MAX_THREADS = 1024;  // Compile-time max for dynamic shared memory

// Note: BLOCKS computed at runtime in solve()
constexpr int elemsPerThread = 8;

#endif // CONFIG_H