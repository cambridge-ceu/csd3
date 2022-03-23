---
sort: 40
---

# snakemake

Web: [https://snakemake.github.io/](https://snakemake.github.io/) ([documentation](https://snakemake.readthedocs.io/en/stable/), [GitHub](https://github.com/snakemake/snakemake)).

It is a python-based workflow management system.

We illustrate installation through `fastqc` and `mamba` at designated location.

```bash
module load miniconda3/4.5.1
export mypath=${HOME}/COVID-19/miniconda37
conda create --prefix ${mypath} python=3.7 ipykernel
conda init bash
source ~/.bashrc
conda activate ${mypath}
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
conda activate ${mypath}
```

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

### [Mendelian Randomziation](https://github.com/marcoralab/MRPipeline)

## Reference

Edwards D. Plant Bioinformatics-Methods and Protocols, 3e. Springer 2022. https://link.springer.com/book/10.1007/978-1-0716-2067-0. [Chapter 11](https://link.springer.com/protocol/10.1007/978-1-0716-2067-0_11); [Chapter 9](https://link.springer.com/protocol/10.1007/978-1-0716-2067-0_9).
