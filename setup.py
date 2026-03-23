from setuptools import setup
from torch.utils.cpp_extension import CUDAExtension, BuildExtension

setup(
    name='parallel_reduction_ext',
    ext_modules=[
        CUDAExtension(
            name='parallel_reduction_ext',
            sources=['extensions/torch/torch_ext.cu'],
            include_dirs=['include'],
        )
    ],
    cmdclass={'build_ext': BuildExtension},
)
