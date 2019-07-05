This repository contains information on software at CSD3 for the Cardiovascular Epidemiology Unit (CEU).

## software wish list

[HPC-software-list.tsv](HPC-software-list.tsv); based on this [Google spreadsheet](https://docs.google.com/spreadsheets/d/15KYXH-B0xJg7GEHjPpFOH1VRDc-Nj5rrejEoyLoMuU4/edit?usp=sharing).

Additional informationi will be made available in due course.

## CSD3 training slides

[https://www.hpc.cam.ac.uk/files/introduction_to_hpc-jun2019-handout_0.pdf](https://www.hpc.cam.ac.uk/files/introduction_to_hpc-jun2019-handout_0.pdf)

## rsync

Old version number on cardio : rsync 3.0.6 gives errors,

```bash
rsync -av --partial mydir/ bp406@login-cpu.hpc.cam.ac.uk:/rds/user/bp406/hpc-work/mydir

Errors after successfully sending a number of files : 
rsync: writefd_unbuffered failed to write 4 bytes to socket [sender]: Broken pipe (32)
rsync: connection unexpectedly closed (604 bytes received so far) [sender]
rsync error: error in rsync protocol data stream (code 12) at io.c(600) [sender=3.0.6]
```

Latest version of rsync (3.1.3) that doesn’t give this error :

/scratch/bp406/apps/software/data_manipulation/rsync-3.1.3/rsync

## R package reinstallation

A version of R package reinstallation by Scott, [reinstall_r_pkgs.R](reinstall_r_pkgs.R).

Conceptually,

```r
# obtain R package list from Cardio /home/$USER/R and resintall to /rds/user/$USER/hpc-work/R at CSD3
  home <- Sys.getenv("HOME")
  from <- paste0(user,"/R")
  pkgs <- unname(installed.packages(lib.loc = from)[, "Package"])
# save the list and upload it to CSD3
# save(pkgs, file="pkgs.rda")
# load("pkgs.rda"))
# screen copy this and paste into an R object when written permission is disabled
  pkgs
  user <- Sys.getenv("USER")
  to <- paste0("/rds/user/",user,"/hpc-work/R")
  install.packages(pkgs, lib=to, repos="https://cran.r-project.org")
```

## Training sessions

Wednesday, 10th July from 10am – 12pm at the Thomas and Dorothy Seminar Room, there will be a user training for CEU CSD3 users.

## Contact information

Joanna Howson <jmmh2@medschl.cam.ac.uk> and Ank Michielsen <am2710@medschl.cam.ac.uk>.

HPC support <support@hpc.cam.ac.uk>
