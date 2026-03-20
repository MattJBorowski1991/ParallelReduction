NVCC = nvcc

.DEFAULT_GOAL := all

NVCC_FLAGS = -O3 -lineinfo -Xcompiler -Wall

MAXRREGCOUNT ?=
ifeq ($(MAXRREGCOUNT),)
	NVCC_REGCOUNT = 
else
	NVCC_REGCOUNT = -maxrregcount=$(MAXRREGCOUNT)
endif

NVCC_ARCH ?= 75

NVCC_GENCODE = 	-gencode arch=compute_$(NVCC_ARCH),code=sm_$(NVCC_ARCH) \
				-gencode arch=compute_$(NVCC_ARCH),code=compute_$(NVCC_ARCH)

INCLUDE_FLAGS = -I. -I./include

DRIVERS_DIR = drivers
KERNELS_DIR = kernels
INPUTS_DIR = inputs
TOOLS_DIR = tools
BIN_DIR = bin

PROFILE_WARMUPS ?= 3
PROFILE_RUNS    ?= 15
NCU            ?= ncu
NCU_SET        ?= full
NCU_FLAGS      ?=

TARGET = $(BIN_DIR)/profile_$(KERNEL)

ALL_KERNELS = $(filter-out reduce_launcher, $(basename $(notdir $(wildcard $(KERNELS_DIR)/*.cu))))
ALL_TARGETS = $(addprefix $(BIN_DIR)/profile_, $(ALL_KERNELS))

BASE_SRCS = $(DRIVERS_DIR)/main.cu \
			$(INPUTS_DIR)/data.cu

KERNEL_SRCS = $(KERNELS_DIR)/$(KERNEL).cu

SRCS = $(BASE_SRCS) $(KERNEL_SRCS)

.PHONY: all all_kernels profile profile_ncu clean help check_kernel

help:
	@echo "Usage: make KERNEL=<kernel_name> [NVCC_ARCH=<arch>] [MAXRREGCOUNT=<count>]"
	@echo "       make all_kernels [NVCC_ARCH=<arch>] [MAXRREGCOUNT=<count>]"
	@echo "       make profile [PROFILE_WARMUPS=3] [PROFILE_RUNS=15]"
	@echo "       make profile_ncu [PROFILE_WARMUPS=3] [PROFILE_RUNS=15] [NCU_SET=full]"
	@echo ""
	@echo "Examples:"
	@echo "  make KERNEL=interleaved_addressing_1"
	@echo "  make KERNEL=interleaved_addressing_1 NVCC_ARCH=80"
	@echo "  make all_kernels"
	@echo "  make profile"
	@echo "  make profile PROFILE_WARMUPS=5 PROFILE_RUNS=20"
	@echo "  make profile_ncu"
	@echo "  make profile_ncu NCU_SET=default NCU_FLAGS='--clock-control none --cache-control none --launch-count 1'"

all: check_kernel $(TARGET)
	@echo "Build: $(TARGET) (kernel=$(KERNEL), arch=sm_$(NVCC_ARCH))"

all_kernels: $(ALL_TARGETS)
	@echo "Built all kernels: $(ALL_KERNELS)"

profile: all_kernels
	@for k in $(ALL_KERNELS); do \
		echo "Profiling $$k ..."; \
		$(BIN_DIR)/profile_$$k --warmups=$(PROFILE_WARMUPS) --runs=$(PROFILE_RUNS) 2>&1 | tee $$k.txt; \
	done

profile_ncu: all_kernels
	@for k in $(ALL_KERNELS); do \
		echo "Profiling $$k with NCU ..."; \
		$(NCU) --set $(NCU_SET) $(NCU_FLAGS) $(BIN_DIR)/profile_$$k --warmups=$(PROFILE_WARMUPS) --runs=$(PROFILE_RUNS) 2>&1 | tee $$k_ncu.txt; \
	done

$(BIN_DIR)/profile_%: $(BASE_SRCS) $(KERNELS_DIR)/%.cu
	@mkdir -p $(BIN_DIR)
	$(NVCC) $(NVCC_FLAGS) $(NVCC_GENCODE) $(INCLUDE_FLAGS) $(NVCC_REGCOUNT) $^ -o $@
	@echo "Built: $@"

check_kernel:
ifndef KERNEL
	$(error KERNEL variable not set. Usage: make KERNEL=kernel_name)
endif

clean:
	rm -rf $(BIN_DIR)
	rm -f $(KERNELS_DIR)/*.o $(INPUTS_DIR)/*.o $(DRIVERS_DIR)/*.o $(UTILS_DIR)/*.o

