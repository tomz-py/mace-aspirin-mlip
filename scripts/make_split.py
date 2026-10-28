#!/usr/bin/env python3
"""Regenerate the reproducible MD17-aspirin data split used in the paper.

Protocol (seed 42): 950 training / 50 validation / remainder test, over the
211,762 MD17 aspirin configurations. Index arrays are archived so the exact
partition can be recovered.
"""
import numpy as np

N = 211762                      # MD17 aspirin configurations
rng = np.random.default_rng(42)
perm = rng.permutation(N)

train_idx = perm[:950]
val_idx   = perm[950:1000]
test_idx  = perm[1000:]

np.save("train_idx.npy", train_idx)
np.save("val_idx.npy",   val_idx)
np.save("test_idx.npy",  test_idx)
print(f"train={train_idx.size}  val={val_idx.size}  test={test_idx.size}")
