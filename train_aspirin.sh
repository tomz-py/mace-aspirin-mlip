#!/usr/bin/env bash
# Train the MACE interatomic potential for aspirin on the MD17 split (seed 42).
# Reproduces the configuration reported in the paper and Supplementary Material.
set -euo pipefail

mace_run_train \
  --name aspirin_mace \
  --train_file data/aspirin_train.xyz \
  --valid_file data/aspirin_val.xyz \
  --test_file  data/aspirin_test.xyz \
  --energy_key energy --forces_key forces \
  --model MACE --num_interactions 2 \
  --hidden_irreps '128x0e+128x1e' \
  --max_ell 1 --r_max 5.0 --correlation 3 \
  --batch_size 10 --max_num_epochs 500 \
  --amsgrad --lr 0.01 --weight_decay 5e-7 \
  --ema --ema_decay 0.99 \
  --energy_weight 1.0 --forces_weight 10.0 \
  --seed 42 --device cuda
