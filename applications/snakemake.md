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

## Python functions

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

### 1. hello world

```bash
wget -qO- https://github.com/snakemake/snakemake/archive/refs/tags/v7.3.1.tar.gz | \
tar xvfz -
cd snakemake-7.3.1/examples/c/src
snakemake -j4
hello
```

> Hello makefiles!

as others from the GitHub/examples directory.

### 2. [MRpipeline](https://github.com/marcoralab/MRPipeline) ([MRcovid](https://github.com/marcoralab/MRcovid))

### 3. [CVD1-HF analysis](https://github.com/alhenry/cvd1-hf)

## References

Köster J, Rahmann S: Snakemake--a scalable bioinformatics workflow engine. _Bioinformatics_. 2012, 28 (19): 2520-2; 2018, 34 (20): 3600

Edwards D. Plant Bioinformatics-Methods and Protocols, 3e. Springer 2022. https://link.springer.com/book/10.1007/978-1-0716-2067-0. [Chapter 11](https://link.springer.com/protocol/10.1007/978-1-0716-2067-0_11); [Chapter 9](https://link.springer.com/protocol/10.1007/978-1-0716-2067-0_9).
