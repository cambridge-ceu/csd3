---
sort: 7
---

# Software

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

```bash
singularity --version
# an example for pwiz,
module load ceuadmin/pwiz/3_0_24163_9bfa69a-wine
singularity pull --name pwiz-skyline-i-agree-to-the-vendor-licenses_latest.sif \
        docker://chambm/pwiz-skyline-i-agree-to-the-vendor-licenses
singularity exec --env WINEDEBUG=-all \
                  -B /rds/project/rds-MkfvQMuSUxk/interval/caprion_proteomics/spectral_library_ZWK/:/data \
                      pwiz-skyline-i-agree-to-the-vendor-licenses_latest.sif \
                      wine msconvert /data/szwk901104i19901xms1.raw
```

where `pull` generates `pwiz-skyline-i-agree-to-the-vendor-licenses_latest.sif` at current directory.

See also <https://docs.sylabs.io/guides/2.6/user-guide/singularity_and_docker.html>.

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
