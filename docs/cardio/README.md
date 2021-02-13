---
sort: 2
---

# cardio

source: `{{ page.path }}`

Cardio is the HPC facility at the CEU.

## CSD3 partition

```bash
scontrol show part
# cpu-o-1 for interactive jobs with no limit on cpus per user expecting fair usage
# cpu-o-[2-5] for long jobs with maximum cpus per user set to 40 and a maximum wall time of 7 days
# cpu-o-7 for short jobs with a maximum wall time of 24 hours

# Interactive jobs

#SBATCH -A CARDIO-SL0-CPU
#SBATCH -p cardio_intr
#SBATCH --qos=cardio_intr

# Long jobs

#SBATCH -A CARDIO-SL0-CPU
#SBATCH -p cardio
#SBATCH --qos=cardio

# Short jobs

#SBATCH -A CARDIO-SL0-CPU
#SBATCH -p cardio_short
#SBATCH --qos=cardio_short
```

### login

Automatic login can be enabled with `ssh-copy-id cardio-login.hpc.cam.ac.uk`.

### Migration

It is possible to fetch `my-file-on-Cardio` with

```bash
scp cardio-login.hpc.cam.ac.uk:/home/$USER/my-file-on-Cardio .
```

as with `sftp`, noting the `-r` option for both could be very useful. More generally, it is preferable to use `rsync`, [https://rsync.samba.org/](https://rsync.samba.org/).

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

### R package reinstallations

Package redeployment is illustrated with R below for building R package list from **_/home/$USER/R_** at Cardio to be resintalled to **_/rds/user/$USER/hpc-work/R_** at CSD3.

We can use screen copy of package list from Cardio since users do not have write permission.

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

If a package list is already built one can reinstall them as follows.

```r
user <- Sys.getenv("USER")
location <- paste0("/rds/user/",user,"/hpc-work/R")
pkgs <- unname(installed.packages(lib.loc = location)[, "Package"])
install.packages(pkgs, lib=location, repos="https://cran.r-project.org")
```

A version by Scott Ritchie (<sr827@medschl.cam.ac.uk>), [reinstall_r_pkgs.R](cardio/reinstall_r_pkgs.R), also touches upon Bioconductor,
whose package installations and updates are described at [https://bioconductor.org/install/](https://bioconductor.org/install/).
