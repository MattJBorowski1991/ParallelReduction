#!/usr/bin/env python3
"""Quick runtime smoke test for the compiled extension.

Usage: run this after building/installing the extension.
"""
import torch


def _get_launcher():
    # Prefer package wrapper which proxies to the compiled module, but
    # fall back to the top-level compiled module if present.
    try:
        import extensions.torch as pkg
        return pkg.launch_atomic_global
    except Exception:
        try:
            import parallel_reduction_ext as ext
            return ext.launch_atomic_global
        except Exception:
            raise ImportError(
                "parallel_reduction_ext not available; build and install the extension: python -m pip install -e ."
            )


def main():
    launcher = _get_launcher()
    t = torch.arange(0, 1024, dtype=torch.int32, device='cuda')
    out = launcher(t)
    print("input[:8]:", t[:8])
    print("output[:8]:", out[:8])


if __name__ == "__main__":
    main()
