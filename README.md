# MACE Interatomic Potential for Aspirin

A reproducible [MACE](https://github.com/ACEsuit/mace) equivariant graph-neural-network
interatomic potential for **aspirin** (C₉H₈O₄), trained on the MD17 dataset and deployed
for molecular dynamics through the [Atomic Simulation Environment (ASE)](https://wiki.fysik.dtu.dk/ase/).
This repository accompanies the paper:

> M. Omoniyi, *A Reproducible MACE Graph-Neural-Network Interatomic Potential for Aspirin:
> Accuracy, Reliability, and Deployment on Accessible Cloud Infrastructure* (2026).

The potential reaches a test-set force RMSE of **15.30 meV/Å** over 210,762 configurations,
conserves energy to within 0.000025 % in NVE dynamics, and evaluates a configuration
**≈23,500× faster than DFT**, entirely on freely available cloud infrastructure.

## Repository contents

| Path | Description |
|------|-------------|
| `train_aspirin.sh` | Exact MACE training command (hyperparameters from the paper). |
| `scripts/make_split.py` | Regenerates the reproducible train/val/test split (seed 42). |
| `data/README.md` | MD17 source and data-preparation instructions. |
| `requirements.txt` | Pinned software environment. |
| `docs/Supplementary_Material.pdf` | Full configuration tables and numerical results. |
| `CITATION.cff` | Citation metadata. |

## Reproducing the results

```bash
# 1. Environment (Python 3.10)
pip install -r requirements.txt

# 2. Download MD17 aspirin from http://quantum-machine.org/datasets/
#    and build the split (seed 42):
python scripts/make_split.py          # -> train_idx.npy / val_idx.npy / test_idx.npy
#    then write aspirin_{train,val,test}.xyz into data/ (see data/README.md)

# 3. Train (single GPU; ~NVIDIA T4):
bash train_aspirin.sh

# 4. Evaluate: MACE writes energy/force RMSE and MAE for the test set;
#    reliability analysis (energy–error correlation, per-atom map, cumulative
#    bounds) follows the definitions in the Supplementary Material.
```

## Model configuration (summary)

| Setting | Value |
|---------|-------|
| Interaction layers | 2 |
| Feature channels | 128 |
| Max angular momentum L | 1 |
| Radial cutoff | 5.0 Å |
| Correlation order (body order) | 3 (4) |
| Optimizer | AMSGrad, lr 0.01, weight decay 5×10⁻⁷ |
| EMA decay / batch size | 0.99 / 10 |
| Force : energy loss weight | 10 : 1 |
| Epochs (best checkpoint) | 500 (493) |
| Seed | 42 |

Full tables are in `docs/Supplementary_Material.pdf`.

## Data and model archive

The MD17 reference data are public (quantum-machine.org). The trained checkpoint and the
archived split-index arrays are deposited on Zenodo:

**Zenodo DOI:** _to be added after the first release_

## Citing

Please cite the paper above and this repository (see `CITATION.cff`). Underlying methods and
data: MACE (Batatia et al., 2022), the atomic cluster expansion (Drautz, 2019), ASE (Larsen
et al., 2017), and the MD17 dataset (Chmiela et al., 2017).

## License

Code is released under the [MIT License](LICENSE). The MD17 data are distributed by their
original authors under their own terms.
