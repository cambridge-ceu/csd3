---
sort: 44
---

# snakemake

[GitHub](https://github.com/snakemake/snakemake) ([documentation](https://snakemake.github.io/), ([stable documentation](https://snakemake.readthedocs.io/en/stable/)))

It is a python-based workflow management system.

## Installation

We illustrate installation through `fastqc` and `mamba` at designated location.

```bash
module load miniconda3/4.5.1
export mypath=${HOME}/COVID-19/miniconda37
conda create --prefix ${mypath} python=3.7 ipykernel
conda init bash
source ~/.bashrc
source activate ${mypath}
mamba install -c bioconda snakemake-minimal
conda install -c bioconda snakemake
conda install -c bioconda fastqc
conda install -c conda-forge mamba
snakemake --help
conda deactivate
```

By default, the installation path is ${HOME}/.conda/envs/miniconda37.

After installation, the call later on will be simpler,

```bash
module load miniconda3/4.5.1
export mypath=${HOME}/COVID-19/miniconda37
source activate ${mypath}
```

## slurm

The `--cluster-config` specification has been extended several ways, e.g., [https://github.com/Snakemake-Profiles/slurm](https://github.com/Snakemake-Profiles/slurm).

## Examples

### hello world

```bash
wget -qO- https://github.com/snakemake/snakemake/archive/refs/tags/v7.3.1.tar.gz | \
tar xvfz -
cd snakemake-7.3.1/examples/c/src
snakemake -j4
hello
```

> Hello makefiles!

as others from the GitHub/examples directory.

### [Mendelian Randomziation](https://github.com/marcoralab/MRPipeline)

### [CVD1-HF analysis](https://github.com/alhenry/cvd1-hf)

## Reference

Edwards D. Plant Bioinformatics-Methods and Protocols, 3e. Springer 2022. https://link.springer.com/book/10.1007/978-1-0716-2067-0. [Chapter 11](https://link.springer.com/protocol/10.1007/978-1-0716-2067-0_11); [Chapter 9](https://link.springer.com/protocol/10.1007/978-1-0716-2067-0_9).
