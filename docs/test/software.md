### ceuadmin

The CEU software repository is here, /usr/local/Cluster-Apps/ceuadmin/. As of December 2019, the list is
```
bgenix/                       LDstore/                     plink_linux_x86_64_beta3.32/  raremetal_4.14.0/                   snptest_new/
biobank/                      magma/                       plinkseq-0.08-x86_64/         raremetal_4.14.1/                   source/
boltlmm/                      MAGMA_Celltyping/            plinkseq-0.10/                raremetal_BPGen/                    stata/
boltlmm_2.2/                  metabolomics/                qctool_v1.4-linux-x86_64/     Raremetal_linux_executables/        tabix/
exomeplus/                    metal/                       R/                            Raremetal_linux_executables.tgz     temp/
gcta/                         metal_updated/               raremetal_4.13/               raremetal.log                       vcftools/
gtool_v0.7.5_x86_64/          plink/                       raremetal_4.13.3/             samtools_1.2/                       vcftools_ps629/
hpg/                          plink_1.90_beta/             raremetal_4.13.4/             shapeit.v2.r790.RHELS_5.4.dynamic/
impute_v2.3.2_x86_64_static/  plink_bgi_Dev/               raremetal_4.13.5/             snptest/
interval/                     plink-bgi_linux_x86_64_may/  raremetal_4.13.7/             snptest_2.5.2/
JAGS/                         plink_linux_x86_64_beta2a/   raremetal_4.13.8/             snptest_2.5.4_beta3/
```
These can be loaded with `module load ceuadmin/<module name>`.

#### git

To have the latest git, e.g.,
```bash
wget -qO- https://github.com/git/git/archive/v2.30.0.tar.gz | tar xfz -
cd git-2.30.0
make NO_GETTEXT=YesPlease install
```
and the executables will be put to ~/bin.

#### matlab

Official website: [https://www.mathworks.com/products/matlab.html](https://www.mathworks.com/products/matlab.html).

```
module avail matlab
module load matlab/r2019b
```
followed by `matlab`.

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
module load miniconda2-4.3.14-gcc-5.4.0-xjtq53h
conda create -n py27 python=2.7 ipykernel
```
for Python 2.7 at `/home/$USER/.conda/envs/py27`, where envs could be replaced with the `--prefix` option. These are only required once.

We can then load Anaconda and activate Python 3.5,
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
If it fails to assign the port number, let the system choose (by dropping the `--port` option). The process which use the port can be shown with `lsof 
-i:8081` or stopped by `lsof -ti:8081 | xargs kill -9`. The command `hostname` gives the name of the node. Once the port number is assigned, it is 
used by another ssh session *elsewhere* and the URL generated openable from a browser, e.g.,
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

The following code installs package for weighted correlation network analysis ([WGCNA](https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/)).
```r
# from CRAN
dependencies <- c("matrixStats", "Hmisc", "splines", "foreach", "doParallel",
                  "fastcluster", "dynamicTreeCut", "survival")
install.packages(dependencies)
# from Bioconductor
source("http://bioconductor.org/biocLite.R")
biocLite(c("GO.db", "preprocessCore", "impute"))
# R >= 3.5.0
install.packages("BiocManager")
BiocManager::install("WGCNA")
```
A good alternative is to use `remotes` or `devtools` package, e.g.,
```r
remotes::install_bioc("snpStats")
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

Account details can be seen with
```bash
mybalance
```
Partition is shown with
```bash
scontrol show partition
```
For an interacive job, we could for instance start with 
```bash
sintr -A MYPROJECT -p skylake -N2 -n2 -t 1:0:0 --qos=INTR
```
and also
```bash
srun -N1 -n1 -c4 -p skylake-himem -t 12:0:0 --pty bash -i
```
or `sintr` then check with `squeue -u $USER`, `qstat -u $USER` and `sacct`. The directory `/usr/local/software/slurm/current/bin/` contains all the executables while sample scripts are in `/usr/local/Cluster-Docs/SLURM`, e.g., [template for Skylake](files/slurm_submit.peta4-skylake).

Here is an example to convert a large number of PDF files (INTERVAL.*.manhattn.pdf) to PNG with smaller file sizes. To start, we build a file list,and pipe into ``parallel`.
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
It is possible to avoid both `parallel` and SLURM, e.g.,
```bash
export url=https://zenodo.org/record/2615265/files/
if [ ! -d ~/rds/results/public/proteomics/scallop-cvd1 ]; then mkdir ~/rds/results/public/proteomics/scallop-cvd1; fi
cat cvd1.txt | xargs -I {} bash -c "wget ${url}/{}.txt.gz -O ~/rds/results/public/proteomics/scallop-cvd1/{}.txt.gz"
#  ln -s ~/rds/results/public/proteomics/scallop-cvd1
```
which downloads the SCALLOP-cvd1 sumstats for proteins listed in `cvd1.txt`.

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
