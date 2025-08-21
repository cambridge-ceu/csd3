---
sort: 13
---

# snakemake

[GitHub](https://github.com/snakemake/snakemake) ([documentation](https://snakemake.github.io/), ([stable documentation](https://snakemake.readthedocs.io/en/stable/)))

It is a python-based workflow management system.

:star: **[https://github.com/troycomi/snakemake-training](https://github.com/troycomi/snakemake-training)**

## 9.9.0

(20/8/2025)

Owing to many issues with Miniconda3 currently, we resort to Anaconda3 by the following steps,

```bash
#!/bin/bash
set -e

# 1. Load the system-wide Anaconda module
module load ceuadmin/Anaconda3/2024.10-1

# 2. Initialize conda for shell
export CONDA_PREFIX=$CEUADMIN/Anaconda3/2024.10-1
source "${CONDA_PREFIX}/etc/profile.d/conda.sh"
conda activate base

# 3. Configure channels with strict priority
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
conda config --set channel_priority strict

# 4. Create isolated snakemake env with mamba included
PREFIX="/usr/local/Cluster-Apps/ceuadmin/snakemake/9.9.0"
conda create --yes --prefix "$PREFIX" -c conda-forge -c bioconda snakemake mamba

# 5. Verify version to confirm successful installation
source "${CONDA_PREFIX}/etc/profile.d/conda.sh"
conda activate "$PREFIX"
conda install --yes fastqc
conda list | grep -e snakemake -e mamba -e fastqc
#
# To activate this environment, use
#
#     $ conda activate /usr/local/Cluster-Apps/ceuadmin/snakemake/5.26.1
#
# To deactivate an active environment, use
#
#     $ conda deactivate
# packages in environment at /usr/local/Cluster-Apps/ceuadmin/snakemake/9.9.0:
fastqc                    0.12.1               hdfd78af_0    bioconda
libmamba                  2.3.1                hae34dd5_1    conda-forge
mamba                     2.3.1                hf857f84_1    conda-forge
snakemake                 9.9.0                hdfd78af_0    bioconda
snakemake-interface-common 1.21.0             pyhdfd78af_0    bioconda
snakemake-interface-executor-plugins 9.3.9              pyhdfd78af_0    bioconda
snakemake-interface-logger-plugins 1.2.4              pyhdfd78af_0    bioconda
snakemake-interface-report-plugins 1.2.0              pyhdfd78af_0    bioconda
snakemake-interface-storage-plugins 4.2.2              pyhdfd78af_0    bioconda
snakemake-minimal         9.9.0              pyhdfd78af_0    bioconda
```

## 7.19.1

### Installation

We illustrate installation through `fastqc` and `mamba` at designated location.

```bash
module load miniconda3/4.5.1
export mypath=${HOME}/COVID-19/miniconda37
conda create --prefix ${mypath} python=3.7 ipykernel
conda init bash
source ~/.bashrc
source activate ${mypath}
conda install -c conda-forge mamba
mamba install -c bioconda snakemake-minimal
conda install -c bioconda snakemake
conda install -c bioconda fastqc
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

### CSD3 module

This is available with

```bash
module load ceuadmin/snakemake/7.19.1
snakemake --help
```

Alternatively,

```bash
module load miniconda3/4.5.1
source activate /usr/local/Cluster-Apps/ceuadmin/snakemake/7.19.1
snakemake --help
source deactivate
```

### slurm

The `--cluster-config` specification has been extended several ways, e.g., [https://github.com/Snakemake-Profiles/slurm](https://github.com/Snakemake-Profiles/slurm).

### Python functions

The mysterious `expand()` function can be explicitly exploited,

```
python3
>>> from snakemake.io import expand, glob_wildcards
>>> expand("{a}-{b}.tst",a=['a', 'b', 'c'],b=[1, 2, 3])
['a-1.tst', 'a-2.tst', 'a-3.tst', 'b-1.tst', 'b-2.tst', 'b-3.tst', 'c-1.tst', 'c-2.tst', 'c-3.tst']
>>> expand("{sample}_{id}.txt", zip, sample=["a", "b", "c"], id=["1", "2", "3"])
['a_1.txt', 'b_2.txt', 'c_3.txt']
>>> proteins = glob_wildcards('METAL/{metal}-chrX-1.tbl.gz').metal
>>> len(proteins)
987
```

Note the `zip` argument which prevents expanding every combinations.

## Examples

- <https://github.com/mitoNGS/MToolBox_snakemake> for use on CSD3.
- MitoImpute, <https://github.com/sjfandrews/MitoImpute>. We start with `CONDA_SOLVER=classic snakemake -j3 --use-conda`.

Other variety is as follows.

### 1. hello world

```bash
wget -qO- https://github.com/snakemake/snakemake/archive/refs/tags/v7.12.0.tar.gz | \
tar xvfz -
cd snakemake-7.12.0/examples/c/src
snakemake -j4
hello
```

> Hello makefiles!

as others from the GitHub/examples directory.

### 2. [MRpipeline](https://github.com/marcoralab/MRPipeline) ([MRcovid](https://github.com/marcoralab/MRcovid))

### 3. [CVD1-HF analysis](https://github.com/alhenry/cvd1-hf)

### 4. [DrugTargetMethodComparison](https://github.com/masadler/DrugTargetMethodComparison)

### 5. [gwas-sumstats-harmoniser](https://github.com/EBISPOT/gwas-sumstats-harmoniser) (Nextflow)

## References

Köster J, Rahmann S: Snakemake--a scalable bioinformatics workflow engine. _Bioinformatics_. 2012, 28 (19): 2520-2; 2018, 34 (20): 3600

Molder F, et al. Sustainable data analysis with Snakemake [version 2; peer review: 2 approved]. _F1000Research_ 2021, 10:33 (<https://doi.org/10.12688/f1000research.29032.2>)

Edwards D. Plant Bioinformatics-Methods and Protocols, 3e. Springer 2022. <https://link.springer.com/book/10.1007/978-1-0716-2067-0>. [Chapter 9](https://link.springer.com/protocol/10.1007/978-1-0716-2067-0_9); [Chapter 11](https://link.springer.com/protocol/10.1007/978-1-0716-2067-0_11).
