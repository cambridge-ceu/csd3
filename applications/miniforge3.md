---
sort: 39
---

# miniforge3

Web: <https://conda-forge.org/>

## Installation

```bash
# Set install location (adjust if needed)
INSTALL_DIR=$CEUADMIN/miniforge3/25.3.1-0

# Download and install Miniforge (comes with conda-forge & mamba support)
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
bash Miniforge3-Linux-x86_64.sh -b -p $INSTALL_DIR

# Activate the environment
source $CEUADMIN/miniforge3/25.3.1-0/bin/activate

# Confirm new conda
conda --version
```

## Application

```bash
git clone https://github.com/sjfandrews/MitoImpute
cd MitoImpute
source $CEUADMIN/miniforge3/25.3.1-0/etc/profile.d/conda.sh
conda activate $CEUADMIN/snakemake/9.9.0-miniforge3
snakemake -j3 --use-conda
snakemake --use-conda --conda-frontend mamba -j3
conda deactivate
```

giving [.snakemake/log/2025-08-21T125037.881663.snakemake.log](../Python/files/2025-08-21T125037.881663.snakemake.log) & [.snakemake/log/2025-08-21T155619.469952.snakemake.log
](../Python/files/2025-08-21T155619.469952.snakemake.log), respectively (order effect?).
