# Data

The quantum-mechanical reference data are the public **MD17 aspirin** dataset
(DFT energies and forces, PBE/def2-SVP, 500 K; 211,762 configurations),
available from <http://quantum-machine.org/datasets/>.

Reproducible split (seed 42): run `python ../scripts/make_split.py` to generate
`train_idx.npy`, `val_idx.npy`, `test_idx.npy`, then slice the MD17 archive and
write `aspirin_train.xyz`, `aspirin_val.xyz`, `aspirin_test.xyz`
(ASE extended-XYZ, energies in eV, forces in eV/Angstrom).

The trained model checkpoint is archived with the Zenodo release (see the main
README) because of its size.
