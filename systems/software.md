---
sort: 6
---

# Software

The CEU software repository is here, /usr/local/Cluster-Apps/ceuadmin/. As of June 2021, the list is

```
bgenix/                       JAGS/                        plink_linux_x86_64_beta2a/    raremetal_4.14.0/                   snptest_2.5.4_beta3/
biobank/                      LDstore/                     plink_linux_x86_64_beta3.32/  raremetal_4.14.1/                   snptest_new/
boltlmm/                      locuszoom/                   plinkseq-0.08-x86_64/         raremetal_BPGen/                    source/
boltlmm_2.2/                  magma/                       plinkseq-0.10/                Raremetal_linux_executables/        stata/
crossmap/                     MAGMA_Celltyping/            qctool_v1.4-linux-x86_64/     Raremetal_linux_executables.tgz     tabix/
exomeplus/                    metabolomics/                R/                            raremetal.log                       temp/
gcta/                         metal/                       raremetal_4.13/               regenie/                            vcftools/
gtool_v0.7.5_x86_64/          metal_updated/               raremetal_4.13.3/             samtools-1.10.tar.bz2               vcftools_ps629/
hpg/                          plink/                       raremetal_4.13.4/             samtools_1.2/
htslib/                       plink_1.90_beta/             raremetal_4.13.5/             shapeit.v2.r790.RHELS_5.4.dynamic/
impute_v2.3.2_x86_64_static/  plink_bgi_Dev/               raremetal_4.13.7/             snptest/
interval/                     plink-bgi_linux_x86_64_may/  raremetal_4.13.8/             snptest_2.5.2/
```

These can be loaded with `module load ceuadmin/<module name>`.

#### gcc

It is one of the critical software to use, e.g.,

```bash
module avail gcc
gcc --version
```

#### gfortran

```bash
gfortran --version
```

#### git

To have the latest git, e.g.,

```bash
wget -qO- https://github.com/git/git/archive/v2.30.0.tar.gz | tar xfz -
cd git-2.30.0
make NO_GETTEXT=YesPlease install
```

and the executables will be put to ~/bin.

#### JAVA

```bash
module avail openjdk
java -version
```

#### libraOffice

The executables (`oocalc`, `ooffice`, `ooimpress`, `oomath`, `ooviewdoc`, `oowriter`) are in the `/usr/bin` directory and can be conveniently called from the console, e.g.,

```bash
oowriter README.docx
```

to load the Word document.

#### matlab

Official website: [https://www.mathworks.com/products/matlab.html](https://www.mathworks.com/products/matlab.html).

```
module avail matlab
module load matlab/r2019b
```

followed by `matlab`.

#### MySQL

One could access databases elsewhere, e.g., at UCSC -- see examples on VEP.

> There isn't any MySQL cluster running as a general service on CSD3. Do you believe your group has something running on a VM hosted on our network possibly? If you need a database for your work, running it in your own department and then allowing access to it from CSD3. Databases are not suitable candidates to run on a HPC cluster, the resource requirements are different and by definition they need to be running continuously whilst access is required, so wouldn't be run via slurm for example.

#### Python

Official website: [https://www.python.org/](https://www.python.org/).

This can be invoked from a CSD3 console via `python` and `python3`. Libraries can be installed via `pip` and `pip3` (or equivalently `python -m pip install` and `python3 -m pip install`), e.g., the script

```bash
pip install mygene --user
pip install tensorflow --user
pip install keras --user
pip install jupyter --user
```

installs libraries at `$HOME/.local`.

It is advised to use virual environments, i.e.,

```bash
# inherit system-wide packages as well
module load python/3.5
virtualenv --system-site-packages py35
source py35/bin/activate
# pip new packages
deactivate
```

Note that when this is set up, one only needs to restart from the `source` command. The `pip` is appropriate for installing small number of package; otherwise Anaconda ([https://www.anaconda.com/](https://www.anaconda.com/)) and Jupyter notebook ([https://jupyter.org/](https://jupyter.org/)) are useful.

We first load Anaconda and create virtual environments,

```bash
module avail miniconda
module load miniconda/2
conda create -n py27 python=2.7 ipykernel
source activate py27
```

for Python 2.7 at `/home/$USER/.conda/envs/py27`, where envs could be replaced with the `--prefix` option. These are only required once.

We can also load Anaconda and activate Python 3.5,

```bash
module load miniconda/3
conda create -n py35 python=3.5 ipykernel
source activate py35
```

and follow [Autoencoder in Keras tutorial](https://www.datacamp.com/community/tutorials/autoencoder-keras-tutorial) on
data from [http://yann.lecun.com/exdb/mnist/](http://yann.lecun.com/exdb/mnist/)

The Jupyter notebook can be started as follows,

```bash
hostname
$HOME/.local/bin/jupyter notebook --ip=127.0.0.1 --no-browser --port 8081
```

If it fails to assign the port number, let the system choose (by dropping the `--port` option). The process which use the port can be shown with `lsof -i:8081` or stopped by `lsof -ti:8081 | xargs kill -9`. The command `hostname` gives the name of the node. Once the port number is assigned, it is
used by another ssh session _elsewhere_ and the URL generated openable from a browser, e.g.,

```bash
ssh -4 -L 8081:127.0.0.1:8081 -fN <hostname>.hpc.cam.ac.uk
firefox <URL> &
```

paying attention to the port number as it may change.

An `hello world` example is [hello.ipynb](files/hello.ipynb) from which [hello.html](files/hello.html) and [hello.pdf](files/hello.pdf) were generated with `jupyter nbconvert --to html|pdf hello.ipynb`.

See also https://docs.hpc.cam.ac.uk/hpc/software-tools/python.html#using-anaconda-python and https://docs.hpc.cam.ac.uk/hpc/software-packages/jupyter.html.

See [HPC docuementation](https://docs.hpc.cam.ac.uk/hpc/) for additional information on PyTorch, Tensorflow and GPU.

#### R

Official website: [https://www.r-project.org/](https://www.r-project.org/) and also [https://bioconductor.org/](https://bioconductor.org/).

Under HPC, the default version is 3.3.3 with /usr/bin/R; alternatively choose the desired version of R from

```bash
module avail R
module avail r
# if you would also like to use RStudio
module avail rstudio
```

e.g., `module load r-3.6.0-gcc-5.4.0-bzuuksv rstudio/1.1.383`.

For information about Bioconductor installation, see [https://bioconductor.org/install/](https://bioconductor.org/install/).

The following code installs package for weighted correlation network analysis ([WGCNA](https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/)).

```r
# from CRAN
dependencies <- c("matrixStats", "Hmisc", "splines", "foreach", "doParallel",
                  "fastcluster", "dynamicTreeCut", "survival")
install.packages(dependencies)
# from Bioconductor
biocPackages <- c("GO.db", "preprocessCore", "impute", "AnnotationDbi")
# R < 3.5.0
source("http://bioconductor.org/biocLite.R")
biocLite(biocPackages)
# R >= 3.5.0
install.packages("BiocManager")
BiocManager::install(biocPackages)
install.packages("WGCNA")
```

A good alternative is to use `remotes` or `devtools` package, e.g.,

```r
remotes::install_bioc("snpStats")
```

A separate example is from r-forge, e.g.,

```r
rforge <- "http://r-forge.r-project.org"
install.packages("estimate", repos=rforge, dependencies=TRUE)
```

In case of difficulty it is still useful to install directly, e.g.,

```bash
wget http://master.bioconductor.org/packages//2.10/bioc/src/contrib/ontoCAT_1.8.0.tar.gz
R CMD INSTALL ontoCAT_1.8.0.tar.gz
# Alternatively,
R -e "install.packages('ontoCAT_1.8.0.tar.gz',repos=NULL)"
```

The package installation directory can be spefied explicitly with R_LIBS, i.e.,

```bash
export R_LIBS=/rds/user/$USER/hpc-work/R:/rds/user/$USER/hpc-work/R-3.6.1/library
```

#### SLURM

Official website: [https://slurm.schedmd.com/](https://slurm.schedmd.com/).

Location at csd3: `/usr/local/Cluster-Docs/SLURM/`.

##### Account details

```bash
mybalance
```

##### Partition

```bash
scontrol show partition
```

##### An interacive job

```bash
sintr -A MYPROJECT -p skylake -N2 -n2 -t 1:0:0 --qos=INTR
```

and also

```bash
srun -N1 -n1 -c4 -p skylake-himem -t 12:0:0 --pty bash -i
```

then check with `squeue -u $USER`, `qstat -u $USER` and `sacct`. The directory `/usr/local/software/slurm/current/bin/` contains all the executables while sample scripts are in `/usr/local/Cluster-Docs/SLURM`, e.g., [template for Skylake](files/slurm_submit.peta4-skylake).

**NOTE** the skylakes are approaching end of life, see [https://docs.hpc.cam.ac.uk/hpc/user-guide/cclake.html](https://docs.hpc.cam.ac.uk/hpc/user-guide/cclake.html) and [https://docs.hpc.cam.ac.uk/hpc/user-guide/icelake.html](https://docs.hpc.cam.ac.uk/hpc/user-guide/icelake.html). For Ampere GPG, see [https://docs.hpc.cam.ac.uk/hpc/user-guide/a100.html](https://docs.hpc.cam.ac.uk/hpc/user-guide/a100.html).

##### Use of modules

The following is part of a real implementation.

```bash
. /etc/profile.d/modules.sh
module purge
module load rhel7/default-peta4
module load gcc/6
module load aria2-1.33.1-gcc-5.4.0-r36jubs
```

##### An example

To convert a large number of PDF files (INTERVAL.\*.manhattn.pdf) to PNG with smaller file sizes. To start, we build a file list, and pipe into ``parallel`.

```bash
ls *pdf | \
sed 's/INTERVAL.//g;s/.manhattan.pdf//g' | \
parallel -j8 -C' ' '
  echo {}
  pdftopng -r 300 INTERVAL.{}.manhattan.pdf
  mv {}-000001.png INTERVAL.{}.png
'
```

which is equivalent to SLURM implementation using array jobs (https://slurm.schedmd.com/job_array.html).

```bash
#!/usr/bin/bash

#SBATCH --ntasks=1
#SBATCH --job-name=pdftopng
#SBATCH --time=6:00:00
#SBATCH --cpus-per-task=8
#SBATCH --partition=skylake
#SBATCH --array=1-50%10
#SBATCH --output=pdftopng_%A_%a.out
#SBATCH --error=pdftopng_%A_%a.err
#SBATCH --export ALL

export p=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]' INTERVAL.list)
export TMPDIR=/rds/user/$USER/hpc-work/

echo ${p}
pdftopng -r 300 INTERVAL.${p}.manhattan.pdf ${p}
mv ${p}-000001.png INTERVAL.${p}.png
```

invoked by `sbatch`. As with Cardio, it is helpful to set a temporary directory, i.e.,

```bash
export TMPDIR=/rds/user/$USER/hpc-work/
```

##### Neither `parallel` nor SLURM

```bash
export url=https://zenodo.org/record/2615265/files/
if [ ! -d ~/rds/results/public/proteomics/scallop-cvd1 ]; then mkdir ~/rds/results/public/proteomics/scallop-cvd1; fi
cat cvd1.txt | xargs -I {} bash -c "wget ${url}/{}.txt.gz -O ~/rds/results/public/proteomics/scallop-cvd1/{}.txt.gz"
#  ln -s ~/rds/results/public/proteomics/scallop-cvd1
```

which downloads the SCALLOP-cvd1 sumstats for proteins listed in `cvd1.txt`.

##### Trouble shooting

With error message

```
squeue: error: _parse_next_key: Parsing error at unrecognized key:
InteractiveStepOptions
squeue: error: Parse error in file
/usr/local/software/slurm/slurm-20.11.4/etc/slurm.conf line 22:
"InteractiveStepOptions="--pty --preserve-env --mpi=none $SHELL""
squeue: fatal: Unable to process configuration file
```

then either log out and login again, or

```bash
unset SLURM_CONF
```

#### Stata

Official website: [https://www.stata.com/](https://www.stata.com/).

As a CEU member the following is possible,

```
module load ceuadmin/stata/14
```

as with `ceuadmin/stata/15`. The meta-analysis (metan) and Mendelian Randomisation (mrrobust) packages can be installed as follows,

```stata
ssc install metan
net install mrrobust, from("https://raw.github.com/remlapmot/mrrobust/master/") replace
```