#include <math.h>

#ifndef CONFIG_H
#define CONFIG_H

constexpr int N = 8388608;
constexpr int THREADS = 512;
constexpr int BLOCKS = (N + THREADS - 1) / THREADS;


#endif // CONFIG_H