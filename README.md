<a href="https://www.top500.org/"><img src="https://www.top500.org/static//images/Top500_logo.png" align="right"></a>

## Contents

***

* [System](https://github.com/cambridge-ceu/csd3#system)
  * [Login](https://github.com/cambridge-ceu/csd3#login)
  * [Directories](https://github.com/cambridge-ceu/csd3#directories)
  * [Policies](https://github.com/cambridge-ceu/csd3#policies)
* [Software](https://github.com/cambridge-ceu/csd3#software)
  * [ceuadmin](https://github.com/cambridge-ceu/csd3#ceuadmin)
  * [modules](https://github.com/cambridge-ceu/csd3#modules)
  * [SLURM](https://github.com/cambridge-ceu/csd3#slurm)
  * [Python](https://github.com/cambridge-ceu/csd3#python)
  * [R](https://github.com/cambridge-ceu/csd3#r)
  * [matlab](https://github.com/cambridge-ceu/csd3#matlab)
  * [Stata](https://github.com/cambridge-ceu/csd3#stata)
  * [Usage notes](usage.md)
  * [To-do list](https://docs.google.com/spreadsheets/d/15KYXH-B0xJg7GEHjPpFOH1VRDc-Nj5rrejEoyLoMuU4/edit?usp=sharing)
* [Training](https://github.com/cambridge-ceu/csd3#training)
* [Contacts](https://github.com/cambridge-ceu/csd3#contacts)
* [*Cardio*](cardio.md)
* [Acknowledgements](https://github.com/cambridge-ceu/csd3#acknowledgements)

***

### System

CSD3 stands for the Cambridge Service for Data Driven Discovery by [Research Computing Services](https://www.csd3.cam.ac.uk/), which provies an excellent [documentation](https://docs.hpc.cam.ac.uk/hpc/) besides [other services](https://www.hpc.cam.ac.uk/).
Here some aspects are highlighted from the perspectives of the [Cardiovascular Epidemiology Unit](https://www.phpc.cam.ac.uk/ceu/) (CEU), where all information about procedures and access requests can be found from **W:\Administration\CSD3 Data Users**.

Basic information is available from a CSD3 console
```bash
# system bit
getconf LONG_BIT
# system information
uname -a
# -s kernel name
# -n node name
# -r kernel release
# -v kernel version
# -p processor
# -o operating system
# Linux Standard Base (lsb) and distribution information
lsb_release -a
# CPU information
lscpu
watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""
```
where breakdown of `uname -a` are also given and for instance `lsb_release -a` gives
```
Distributor ID: Scientific
Description:    Scientific Linux release 7.7 (Nitrogen)
Release:        7.7
Codename:       Nitrogen
```
so the system is Scientific Linux 7 (SL7), see [http://www.scientificlinux.org/](http://www.scientificlinux.org/), also /usr/share/doc/HTML/en-US/index.html,

### Login

Possible login nodes on csd3 are: login.hpc, login-cpu.hpc, login-gpu.hpc, login-gfx.hpc, login-e-N.hpc.

To reset Raven password, follow https://password.csx.cam.ac.uk/.

To establish host keys one resort to `ssh-keygen`; the easiest is to accept the default.

The CSD3 hostkeys are described here, https://docs.hpc.cam.ac.uk/hpc/user-guide/hostkeys.html. From 1st February 2020, the following script needs to be run
from a local machine,
```bash
cp ~/.ssh/known_hosts ~/.ssh/known_hosts.`date +%F`
sed -i -e '/128\.232\.224/d' -e '/.*\.hpc\.cam\.ac\.uk/d' ~/.ssh/known_hosts
```
Automatic login via ssh/sftp can be enabled with
```bash
ssh-copy-id login.hpc.cam.ac.uk
```
from a Bash console after one login. If this is not set up, follow these steps,
```bash
ssh-keygen
# Enter file in which to save the key (/home/$USER/.ssh/id_rsa): mykey
# Enter passphrase (empty for no passphrase): 
# Enter same passphrase again: 
# Your identification has been saved in mykey.
# Your public key has been saved in mykey.pub.
The key fingerprint is:
ssh-copy-id -i ~/.ssh/mykey login.hpc.cam.ac.uk
```
as in [https://www.ssh.com/ssh/copy-id](https://www.ssh.com/ssh/copy-id).

Environmental variables can be set inside `~/.bashrc`.

### Directories

This [section](https://docs.hpc.cam.ac.uk/hpc/user-guide/io_management.html#summary-of-available-filesystems) gives a summary of the file system. 

Goto **CSD3 portal**: [https://selfservice.uis.cam.ac.uk/account/](https://selfservice.uis.cam.ac.uk/account/) and accept the terms and conditions. An `rds/` directory should then be created with symbolic links as follows,
```
hpc-work -> /rds/user/$USER/hpc-work/
genetics_resources -> /rds/project/jmmh2/rds-jmmh2-genetics_resources/
legacy_projects -> /rds/project/jmmh2/rds-jmmh2-legacy_projects/
pre_qc_data -> /rds/project/jmmh2/rds-jmmh2-pre_qc_data/
projects -> /rds/project/jmmh2/rds-jmmh2-projects/
public_databases -> /rds/project/jmmh2/rds-jmmh2-public_databases/
results -> /rds/project/jmmh2/rds-jmmh2-results
```
Short shorter (without rds-jmmh2- prefix) names as on Cardio can be created equivalently with
```bash
if [ ! -d /home/$USER/rds ]; then mkdir /home/$USER/rds; fi
ln -sf /rds/user/$USER/hpc-work /home/$USER/rds/hpc-work
export rt=/rds/project/jmmh2
for d in $(ls $rt | xargs -l basename | sed 's/rds-jmmh2-//g'); do ln -sf $rt/rds-jmmh2-$d /home/$USER/rds/$d; done
```
 Note to list the directories you need postfix them with '/'.

### Policies

See [https://docs.hpc.cam.ac.uk/hpc/user-guide/policies.html#acknowledging-csd3](https://docs.hpc.cam.ac.uk/hpc/user-guide/policies.html#acknowledging-csd3).

### Software

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

#### modules

CSD3 uses modules, e.g., with `qctool` v2.0.5,
```bash
module load qctool/v2.0.5
```
followed by `qctool -help`.

When advanced versions of GNU C-related libraries are required, e.g., from R
```
library(plotly)
/usr/lib64/libstdc++.so.6: version `GLIBCXX_3.4.20' not found

library(UniProt.ws)
Error: package or namespace load failed for ‘UniProt.ws’ in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]):
 namespace ‘rlang’ 0.4.2 is already loaded, but >= 0.4.3 is required
```
which would go away should we issue `module load gcc/5` ahead of R. In case of failure after `srun` (see below), enforce lookup by
```bash
export LD_LIBRARY_PATH=/usr/local/software/master/gcc/5/lib64:/usr/local/software/master/gcc/5/lib:$LD_LIBRARY_PATH
```

#### SLURM

Official website: [https://slurm.schedmd.com/](https://slurm.schedmd.com/).

Partition is shown with
```bash
scontrol show partition
```
Account details can be seen with
```bash
mybalance
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
Anaconda ([https://www.anaconda.com/](https://www.anaconda.com/)) and Jupyter notebook ([https://jupyter.org/](https://jupyter.org/)) are useful tools. 

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
A good alternative is to use `devtools` package, e.g.,
```r
devtools::install_bioc("snpStats")
```
In case of difficulty it is still useful to install directly, e.g.,
```bash
wget http://master.bioconductor.org/packages//2.10/bioc/src/contrib/ontoCAT_1.8.0.tar.gz
R CMD INSTALL ontoCAT_1.8.0.tar.gz
```
The package installation directory can be spefied explicitly with R_LIBS, i.e.,
```bash
export R_LIBS=/rds/user/$USER/hpc-work/R:/rds/user/$USER/hpc-work/R-3.6.1/library
```

#### matlab

Official website: [https://www.mathworks.com/products/matlab.html](https://www.mathworks.com/products/matlab.html).

```
module avail matlab
module load matlab/r2019b
```
followed by `matlab`.

#### Stata

Official website: [https://www.stata.com/](https://www.stata.com/).

As a CEU member the following is possible,
```
module load ceuadmin/stata/14
```
as with `ceuadmin/stata/15`.

### Training

* **First training**: Wednesday, 10th July from 10am – 12pm.
* **Second training**: Wednesday, 31st July from 9:30am – 4pm.
* **UCS**: [https://training.cam.ac.uk/ucs/](https://training.cam.ac.uk/ucs/).
* **Handouts**: [June](https://www.hpc.cam.ac.uk/files/introduction_to_hpc-jun2019-handout_0.pdf) and [November](https://www.hpc.cam.ac.uk/files/introduction_to_hpc-nov2019.pdf), 2019.
* **Presentation**: [Google document](https://tinyurl.com/y3l6jssg) by Praveen Surendran (<ps629@medschl.cam.ac.uk>).

### Contacts

* **CSD3 account**: [https://www.hpc.cam.ac.uk/rcs-application](https://www.hpc.cam.ac.uk/rcs-application) as in [Applications for Access to Research Computing Services](https://www.hpc.cam.ac.uk/applications-access-research-computing-services). 
* **HPC support**: <support@hpc.cam.ac.uk> with the title “cardio migration".
* **CEU contacts**: Ank Michielsen (<am2710@medschl.cam.ac.uk>) and Niko Ovenden (<nao26@medschl.cam.ac.uk>).
* **Request for software**: Savita Karthikeyan (<sk752@medschl.cam.ac.uk>).
* **Contacts for data access**. CSD3datamanager@medschl.cam.ac.uk.

### Acknowledgements

The repository was created as a result of the cambridge-ceu organisation; information regarding system login, Jupyter, polyphen, Stata and VEP received inputs from HPC supporint team.
