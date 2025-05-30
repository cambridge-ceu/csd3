---
sort: 8
---

# Software

Software-specific configurations can often be found from `~/.config` and `~/.local` or other `.*` locations such as `.vscode`.

## ceuadmin

See [https://cambridge-ceu.github.io/csd3/systems/ceuadmin.html](https://cambridge-ceu.github.io/csd3/systems/ceuadmin.html) for additional information.

## git

The popular git can be loaded,

```bash
git --help
git add --help
```

## libraOffice

Official website: [https://www.libreoffice.org/](https://www.libreoffice.org/)

The executables (`oocalc`, `ooffice`, `ooimpress`, `oomath`, `ooviewdoc`, `oowriter`) are in the `/usr/bin` directory and can be conveniently called from the console, e.g.,

```bash
oowriter README.docx
```

to load the Word document.

## MATLAB

Official website: [https://www.mathworks.com/products/matlab.html](https://www.mathworks.com/products/matlab.html).

```bash
module avail matlab
module load matlab/r2019b
```

followed by `matlab`.

## MySQL

One could access databases elsewhere, e.g., at UCSC -- see examples on VEP.

> There isn't any MySQL cluster running as a general service on CSD3. Do you believe your group has something running on a VM hosted on our network possibly? If you need a database for your work, running it in your own department and then allowing access to it from CSD3. Databases are not suitable candidates to run on a HPC cluster, the resource requirements are different and by definition they need to be running continuously whilst access is required, so wouldn't be run via SLURM for example.

## R

See languages section, <https://cambridge-ceu.github.io/csd3/systems/languages.html>.

## pspp

Official website: [https://www.gnu.org/software/pspp/](https://www.gnu.org/software/pspp/)

```bash
module load ceuadmin/pspp
```

with command-line tool `pspp` and a GUI counterpart `psppire`.

## singularity

Web: <https://docs.sylabs.io/> ([User Guide](https://docs.sylabs.io/guides/3.5/user-guide/index.html#))

Real applications in WES/WGS are given here, <https://jinghuazhao.github.io/SCALLOP-Seq/NOTES/>.

Similarly for MS experiment, the following is also from an ongoing project.

```bash
singularity --version
module load ceuadmin/pwiz/3_0_24163_9bfa69a-wine
export SIF=pwiz-skyline-i-agree-to-the-vendor-licenses_latest.sif
singularity pull --name ${SIF} docker://chambm/pwiz-skyline-i-agree-to-the-vendor-licenses
singularity exec --env WINEDEBUG=-all \
                  -B /rds/project/rds-MkfvQMuSUxk/interval/caprion_proteomics/spectral_library_ZWK/:/data \
                      ${SIF} \
                      wine msconvert /data/szwk901104i19901xms1.raw
```

where `pull` generates `pwiz-skyline-i-agree-to-the-vendor-licenses_latest.sif` at current directory.

See also <https://docs.sylabs.io/guides/2.6/user-guide/singularity_and_docker.html>.

An example is ready from `diann.def` for `diann/2.0.2`,

```
BootStrap: docker
From: ubuntu:22.04

%files
    diann-linux  /usr/local/bin/diann-linux
    libc10.so    /usr/lib/
    libgomp-98b21ff3.so.1  /usr/lib/
    libtimsdata.so  /usr/lib/
    libtorch_cpu.so  /usr/lib/
    libtorch.so  /usr/lib/

%post
    # Set timezone
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime

    # Update package lists and install dependencies
    apt-get update
    apt-get install -y libgomp1 libstdc++6 libc6 locales

    # Configure locales
    locale-gen en_US.UTF-8
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf

    # Clean up apt cache
    rm -rf /var/lib/apt/lists/*

    # Ensure diann-linux is executable and create a symlink
    chmod +x /usr/local/bin/diann-linux
    ln -sf /usr/local/bin/diann-linux /usr/local/bin/diann

%runscript
    exec /usr/local/bin/diann "$@"

%labels
    Author YourName
    Version 2.0.2
    Description "DiaNN container for proteomics analysis"
```

so we can proceed with

```bash
singularrity build diann.sif diann.def
singularity run diann.sif --fasta /path/to/human_proteome.fasta --dir /path/to/data/ --out output.txt
```

See <https://www.bioconductor.org/help/docker/> on bioconductor.

## SLURM

Due to increase of size, the entry is moved here, <https://cambridge-ceu.github.io/csd3/systems/ParallelComputing.html>.

## Stata

Official website: [https://www.stata.com/](https://www.stata.com/).

We issue `module avail ceuadmin/stata` to give,

```
----------------------------------------------------------------- /usr/local/Cluster-Config/modulefiles -----------------------------------------------------------------
ceuadmin/stata/14  ceuadmin/stata/15  ceuadmin/stata/16
```

e.g., as a CEU member the following is possible,

```
module load ceuadmin/stata/14
```

The meta-analysis (metan) and Mendelian Randomisation (mrrobust) packages can be installed as follows,

```stata
ssc install metan
net install mrrobust, from("https://raw.github.com/remlapmot/mrrobust/master/") replace
```

It is now also possible systemwide, with `module avail stata` giving

```
-------------------------------------------------- /usr/local/Cluster-Config/modulefiles --------------------------------------------------
stata/14 stata/17 stata/18
```

so as to use `module load stata; stata`

## Workflows

Two of them are highlighted here, i.e., `ceuadmin/snakemake/7.19.1` and `ceuadmin/nextflow/23.10.1`.
