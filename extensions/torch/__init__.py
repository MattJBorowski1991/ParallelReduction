"""Package wrapper for the compiled extension.

This module first tries to import a package-local compiled extension
(`extensions.torch.parallel_reduction_ext`). If that fails it falls back
to the top-level compiled module `parallel_reduction_ext` so either
installation layout works.
"""

_ext = None
try:
    from . import parallel_reduction_ext as _ext
except Exception:
    try:
        import parallel_reduction_ext as _ext
    except Exception:
        _ext = None


def launch_atomic_global(input_tensor):
    if _ext is None:
        raise ImportError(
            "parallel_reduction_ext is not built. Run 'python -m pip install -e .' to build the extension."
        )
    return _ext.launch_atomic_global(input_tensor)


__all__ = ["launch_atomic_global"]
