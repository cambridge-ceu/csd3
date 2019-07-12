The repository collects information for users of the HPC facility (Cardio) at the [Cardiovascular Epidemiology Unit (CEU)](https://www.phpc.cam.ac.uk/ceu/) regarding migration to the Univeristy HPC, or the
Cambridge Service for Data Driven Discovery (CSD3) hosted by [Research Computing Services](https://www.csd3.cam.ac.uk/) as documented [here](https://docs.hpc.cam.ac.uk/hpc/).

## Contents

---

* [Software](https://github.com/cambridge-ceu/csd3#software)
* [rsync](https://github.com/cambridge-ceu/csd3#rsync)
* [R](https://github.com/cambridge-ceu/csd3#r)
* [Access](https://github.com/cambridge-ceu/csd3#access)
* [Training](https://github.com/cambridge-ceu/csd3#training)
* [Contacts](https://github.com/cambridge-ceu/csd3#contacts)

---

## software

There is a software wish list in this [Google spreadsheet](https://docs.google.com/spreadsheets/d/15KYXH-B0xJg7GEHjPpFOH1VRDc-Nj5rrejEoyLoMuU4/edit?usp=sharing).

Amendment is welcome. If necessary, additional information can be made available, e.g., [usage.md](usage.md).

## rsync

Official website: [https://rsync.samba.org/](https://rsync.samba.org/).

Old version on Cardio, rsync 3.0.6, gives errors,

```bash
rsync -av --partial mydir/ login-cpu.hpc.cam.ac.uk:/rds/user/$USER/hpc-work/mydir

Errors after successfully sending a number of files : 
rsync: writefd_unbuffered failed to write 4 bytes to socket [sender]: Broken pipe (32)
rsync: connection unexpectedly closed (604 bytes received so far) [sender]
rsync error: error in rsync protocol data stream (code 12) at io.c(600) [sender=3.0.6]
```
Bram Prins (<bp406@medschl.cam.ac.uk>) has the latest version (3.1.3) that doesn’t give this error here:

/DO-NOT-MODIFY-SCRATCH/bp406/apps/software/data_manipulation/rsync-3.1.3/rsync

Note **/scratch/$USER** at Cardio is now **/DO-NOT-MODIFY-SCRATCH/$USER**.

## R

Official website: [https://www.r-project.org/](https://www.r-project.org/).

Under HPC, the default version is 3.3.3 with /usr/bin/R; alternatively choose the desired version of R from
```bash
module avail r
# if you would also like to use RStudio
module avail rstudio
```
e.g., `module load r-3.6.0-gcc-5.4.0-bzuuksv rstudio/1.1.383`.

Package redeployment is illustrated with R below for building R package list from ***/home/$USER/R*** at Cardio to be resintalled to ***/rds/user/$USER/hpc-work/R*** at CSD3.

```r
## on Cardio
  home <- Sys.getenv("HOME")
  from <- paste0(home,"/R")
  pkgs <- unname(installed.packages(lib.loc = from)[, "Package"])
# save the list and upload it to CSD3
# save(pkgs, file="pkgs.rda")
# generate screen copy of packages, mark the packages within c() and use :q! to quit the view
  edit(pkgs)
## On CSD3
# load("pkgs.rda")
# shift+ins to paste the screen copy above into an R object as written permission is disabled
  pkgs <- c(...)
  user <- Sys.getenv("USER")
  to <- paste0("/rds/user/",user,"/hpc-work/R")
  install.packages(pkgs, lib=to, repos="https://cran.r-project.org")
```
A version by Scott Ritchie (<sr827@medschl.cam.ac.uk>), [reinstall_r_pkgs.R](reinstall_r_pkgs.R), also touches upon Bioconductor,
whose package installations and updates are described at [https://bioconductor.org/install/](https://bioconductor.org/install/). 

Here is an example for WGCNA.
```r
# from CRAN
dependencies <- c("matrixStats", "Hmisc", "splines", "foreach", "doParallel",
                  "fastcluster", "dynamicTreeCut", "survival")
install.packages(dependencies)
# from Bioconductor
source("http://bioconductor.org/biocLite.R")
biocLite(c("GO.db", "preprocessCore", "impute"))
install.packages("BiocManager")
BiocManager::install("WGCNA")
```
where `BiocManager` is appropriate for R 3.5.0 or later.

## Access

Goto **CSD3 portal**: [https://selfservice.uis.cam.ac.uk/account/](https://selfservice.uis.cam.ac.uk/account/) and accept the terms and conditions.

Issue
```bash
mybalance
```
from HPC console to see your account information for SLURM jobs. For an interacive job, we could for instance start with
```bash
srun -N1 -n1 -c6 -p skylake -t 12:0:0 --pty bash -i
```
or `sintr` then check with `sacct`. The collection os SLURM commands can be seen from [/usr/local/software/slurm/current/bin/](/usr/local/software/slurm/current/bin/).

## Training

* **Date**: Wednesday, 10th July
* **Time**: 10am – 12pm
* **Venue**: Thomas and Dorothy Seminar Room.
* **Handouts**: [https://www.hpc.cam.ac.uk/files/introduction_to_hpc-jun2019-handout_0.pdf](https://www.hpc.cam.ac.uk/files/introduction_to_hpc-jun2019-handout_0.pdf)
* **Presentation**: [Google document](https://tinyurl.com/y3l6jssg) by Praveen Surendran (<ps629@medschl.cam.ac.uk>).

## Contacts

* **CSD3 account**: [https://www.hpc.cam.ac.uk/rcs-application](https://www.hpc.cam.ac.uk/rcs-application).
* **HPC support**: <support@hpc.cam.ac.uk> with the title “cardio migration".
* **CEU contacts**: Joanna Howson (<jmmh2@medschl.cam.ac.uk>) and Ank Michielsen (<am2710@medschl.cam.ac.uk>).
* **Request for software**: Savita Karthikeyan (<sk752@medschl.cam.ac.uk>).
* **Request for write access**: Savita Karthikeyan (<sk752@medschl.cam.ac.uk>) and Charlotte van Coeverden (<crv26@medschl.cam.ac.uk>).
