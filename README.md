The Cambridge Service for Data Driven Discovery by [Research Computing Services](https://www.csd3.cam.ac.uk/) ([Documentation](https://docs.hpc.cam.ac.uk/hpc/)).

All information about procedures and access requests can be found here: W:\Administration\CSD3 Data Users.

### login

Automatic login via ssh/sftp can be enabled with
```bash
ssh-copy-id login.hpc.cam.ac.uk`
```
from a Bash console after one login. If this has not set up, follow these steps,
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

### Directories

Goto **CSD3 portal**: [https://selfservice.uis.cam.ac.uk/account/](https://selfservice.uis.cam.ac.uk/account/) and accept the terms and conditions. An `rds/` directory should then be created with symbolic links as follows,
```
hpc-work -> /rds/user/$USER/hpc-work/
rds-jmmh2-genetics_resources -> /rds/project/jmmh2/rds-jmmh2-genetics_resources/
rds-jmmh2-legacy_projects -> /rds/project/jmmh2/rds-jmmh2-legacy_projects/
rds-jmmh2-pre_qc_data -> /rds/project/jmmh2/rds-jmmh2-pre_qc_data/
rds-jmmh2-projects -> /rds/project/jmmh2/rds-jmmh2-projects/
rds-jmmh2-public_databases -> /rds/project/jmmh2/rds-jmmh2-public_databases/
rds-jmmh2-results -> /rds/project/jmmh2/rds-jmmh2-results
```
Short shorter (without rds-jmmh2- prefix) names as on Cardio can be created equivalently with
```bash
mkdir /home/$USER/rds
ln -sf /rds/user/$USER/hpc-work /home/$USER/rds/hpc-work
export rt=/rds/project/jmmh2
for d in $(ls $rt | xargs -l basename | sed 's/rds-jmmh2-//g'); do ln -sf $rt/rds-jmmh2-$d /home/$USER/rds/$d; done
```
 Note to list the directories you need postfix them with '/'.

### SLURM

Accout details can be seen with
```bash
mybalance
```
For an interacive job, we could for instance start with
```bash
srun -N1 -n1 -c4 -p skylake-himem -t 12:0:0 --pty bash -i
```
or `sintr` then check with `squeue -u $USER`, `qstat -u $USER` and `sacct`. The directory `/usr/local/software/slurm/current/bin/` contains all the executables while sample scripts are in `/usr/local/Cluster-Docs/SLURM`, e.g., [template for Skylake](files/slurm_submit.peta4-skylake).

Here is an example to convert a large number of PDF files (INTERVAL.*.manhattn.pdf) to PNG with smaller file sizes. To start, we build a file list,and pipe into ``parallel`.
```bash
ls *pdf | \
sed 's/INTERVAL.//g;s/.manhattan.pdf//g' | \
parallel -C' ' '
  echo {}
  pdftopng -r 300 INTERVAL.{}.manhattan.pdf
  mv {}-000001.png INTERVAL.{}.png
'
```
which is equivalent to 
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

### Software

A software wish list in a [Google spreadsheet](https://docs.google.com/spreadsheets/d/15KYXH-B0xJg7GEHjPpFOH1VRDc-Nj5rrejEoyLoMuU4/edit?usp=sharing)
can be amended. Additional information can be made available, e.g., [usage.md](usage.md).

---

## Information on Cardio

Cardio is the HPC facility at the [Cardiovascular Epidemiology Unit (CEU)](https://www.phpc.cam.ac.uk/ceu/).

### login

Automatic login can be enabled with `ssh-copy-id cardio-login.hpc.cam.ac.uk`.

### Migration

It is possible to fetch `my-file-on-Cardio` with
```bash
scp cardio-login.hpc.cam.ac.uk:/home/$USER/my-file-on-Cardio .
```
as with `sftp`. More generally, it is preferable to use `rsync`, [https://rsync.samba.org/](https://rsync.samba.org/).

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

Note **/scratch** at Cardio is now **/DO-NOT-MODIFY-SCRATCH** -- an example is [jp.sh](files/jp.sh).

### R

Official website: [https://www.r-project.org/](https://www.r-project.org/) and also [https://bioconductor.org/](https://bioconductor.org/).

Under HPC, the default version is 3.3.3 with /usr/bin/R; alternatively choose the desired version of R from
```bash
module avail r
# if you would also like to use RStudio
module avail rstudio
```
e.g., `module load r-3.6.0-gcc-5.4.0-bzuuksv rstudio/1.1.383`.

Package redeployment is illustrated with R below for building R package list from ***/home/$USER/R*** at Cardio to be resintalled to ***/rds/user/$USER/hpc-work/R*** at CSD3.

One can use `rsync` to transfer the installed packages directly to the CSD3 location and then reinstall them as follows.
```r
user <- Sys.getenv("USER")
location <- paste0("/rds/user/",user,"/hpc-work/R")
pkgs <- unname(installed.packages(lib.loc = location)[, "Package"])
install.packages(pkgs, lib=location, repos="https://cran.r-project.org")
```
Alternatively, we can use screen copy of package list from Cardio since users do not have write permission.

**On Cardio**
```r
  home <- Sys.getenv("HOME")
  from <- paste0(home,"/R")
  pkgs <- unname(installed.packages(lib.loc = from)[, "Package"])
  edit(pkgs)
```
**On CSD3**
```r
  pkgs <- "mark and copy the list as given in c() above with Shift+Ins"
  user <- Sys.getenv("USER")
  to <- paste0("/rds/user/",user,"/hpc-work/R")
  install.packages(pkgs, lib=to, repos="https://cran.r-project.org")
```
A version by Scott Ritchie (<sr827@medschl.cam.ac.uk>), [reinstall_r_pkgs.R](reinstall_r_pkgs.R), also touches upon Bioconductor,
whose package installations and updates are described at [https://bioconductor.org/install/](https://bioconductor.org/install/). 

The following code installs package for weighted correlation network analysis ([WGCNA](https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/)).
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

A good alternative is to use `devtools` package, e.g.,
```r
devtools::install_bioc("snpStats")
```

### Training

* **First training**: Wednesday, 10th July from 10am – 12pm.
* **Second training**: Wednesday, 31st July from 9:30am – 4pm.
* **Venue**: Thomas and Dorothy Seminar Room.
* **Handouts**: [https://www.hpc.cam.ac.uk/files/introduction_to_hpc-jun2019-handout_0.pdf](https://www.hpc.cam.ac.uk/files/introduction_to_hpc-jun2019-handout_0.pdf)
* **Presentation**: [Google document](https://tinyurl.com/y3l6jssg) by Praveen Surendran (<ps629@medschl.cam.ac.uk>).

### Contacts

* **CSD3 account**: [https://www.hpc.cam.ac.uk/rcs-application](https://www.hpc.cam.ac.uk/rcs-application) as in [Applications for Access to Research Computing Services](https://www.hpc.cam.ac.uk/applications-access-research-computing-services). 
* **HPC support**: <support@hpc.cam.ac.uk> with the title “cardio migration".
* **CEU contacts**: Ank Michielsen (<am2710@medschl.cam.ac.uk>) and Niko Ovenden (<nao26@medschl.cam.ac.uk>).
* **Request for software**: Savita Karthikeyan (<sk752@medschl.cam.ac.uk>).
* **Contacts for data access**. CSD3datamanager@medschl.cam.ac.uk.
