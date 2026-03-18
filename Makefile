NVCC = nvcc

NVCC_FLAGS = -O3 -lineinfo -Xcompiler -Wall

MAXRREGCOUNT ?=
ifeq ($(MAXRREGCOUNT),)
	NVCC_REGCOUNT = 
else
	NVCC_REGCOUNT = -maxrregcount=$(MAXRREGCOUNT)
endif

NVCC_ARCH ?= 79

NVCC_GENCODE = 	-gencode arch=compute_$(NVCC_ARCH),code=sm_$(NVCC_ARCH) \
				-gencode arch=compute_$(NVCC_ARCH),code=compute_$(NVCC_ARCH)

INCLUDE_FLAGS = -I. -I./include

DRIVERS_DIR = drivers
KERNELS_DIR = kernels
INPUTS_DIR = inputs
TOOLS_DIR = tools
BIN_DIR = bin

ifndef KERNEL
$(error KERNEL variable not set. Usage: make KERNEL=kernel_name)
endif

TARGET = $(BIN_DIR)/profile_$(KERNEL)

BASE_SRCS = $(DRIVERS_DIR)/main.cu \
			$(INPUTS_DIR)/data.cu

KERNEL_SRCS = $(KERNELS_DIR)/$(KERNEL).cu

SRCS = $(BASE_SRCS) $(KERNEL_SRCS)

.PHONY: all clean help

help:
	@echo "Usage: make KERNEL=<kernel_name> [NVCC_ARCH=<arch>] [MAXRREGCOUNT=<count>]"
	@echo ""
	@echo "Examples:"
	@echo "  make KERNEL=interleaved_addressing_1"
	@echo "  make KERNEL=interleaved_addressing_1 NVCC_ARCH=80"
	@echo "  make clean && make KERNEL=interleaved_addressing_1"

all: $(TARGET)
	@echo "Build: $(TARGET) (kernel=$(KERNEL), arch=sm_$(NVCC_ARCH))"

$(TARGET): $(SRCS)
	@mkdir -p $(BIN_DIR)
	$(NVCC) $(NVCC_FLAGS) $(NVCC_GENCODE) $(INCLUDE_FLAGS) $(NVCC_REGCOUNT) $(SRCS) -o $(TARGET)

clean:
	rm -rf $(BIN_DIR)
	rm -f $(KERNELS_DIR)/*.o $(INPUTS_DIR)/*.o $(DRIVERS_DIR)/*.o $(UTILS_DIR)/*.o

