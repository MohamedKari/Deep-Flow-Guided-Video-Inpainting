#!/usr/bin/env bash
TORCH=$(python3 -c "import os; import torch; print(os.path.dirname(torch.__file__))")

cd src

echo "Compiling correlation kernels by nvcc..."

rm -f correlation_cuda_kernel.o
rm -r ../_ext

# Look up your Compute Compatibility Version for GPU under https://en.wikipedia.org/wiki/CUDA#GPUs_supported
# Removing the dot between major and minor version yields the SM (System Management) value for the arch flag

tesla_k80=37
tesla_p4=61

nvcc -c -o correlation_cuda_kernel.o correlation_cuda_kernel.cu -x cu -Xcompiler -fPIC -arch=sm_${tesla_k80}

cd ../
python3 build.py
