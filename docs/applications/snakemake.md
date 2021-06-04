---
sort: 47
---

# snakemake

Web: [https://snakemake.readthedocs.io/en/stable/index.html](https://snakemake.readthedocs.io/en/stable/index.html)

It is a python-based workflow management system.

We illustrate installation through `mamba` and designated location.

```bash
module load miniconda3/4.5.1
export mypath=${HOME}/COVID-19/miniconda37
conda create --prefix ${mypath} python=3.7 ipykernel
conda init bash
source ~/.bashrc
conda activate ${mypath}
conda install -c conda-forge mamba
mamba install -c conda-forge -c bioconda snakemake-minimal
snakemake --help
conda deactivate
```

By default, the installation path is ${HOME}/.conda/envs/miniconda37.

After installation, the call later on will be simpler,

```bash
module load miniconda3/4.5.1
export mypath=${HOME}/COVID-19/miniconda37
conda activate ${mypath}
```

## Application example

[Mendelian Randomziation](https://github.com/marcoralab/MRPipeline)
