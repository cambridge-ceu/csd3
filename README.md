This repository contains information on software at CSD3 for the Cardiovascular Epidemiology Unit (CEU).

## software wish list

[HPC-software-list.tsv](HPC-software-list.tsv); based on this [Google spreadsheet](https://docs.google.com/spreadsheets/d/15KYXH-B0xJg7GEHjPpFOH1VRDc-Nj5rrejEoyLoMuU4/edit?usp=sharing).

Additional informationi will be made available in due course.

## CSD3 training slides

https://www.hpc.cam.ac.uk/files/introduction_to_hpc-jun2019-handout_0.pdf

## R

A version of R package reinstallation by Scott, [reinstall_r_pkgs.R](reinstall_r_pkgs.R).

Conceptually,

```bash
R --no-save <<END
# 
  user <- Sys.getenv("USER")
  location <- paste0(user,"/R")
  pkgs <- unname(installed.packages(lib.loc = location)[, "Package"])
# save the list and upload it to hpc
# save(pkgs, file="pkgs.rda")
# load("pkgs.rda"))
# screen copy this and paste into an R object when written permission is disabled
  pkgs
  install.packages(pkgs, lib=location, repos="https://cran.r-project.org")
END
```

## Training sessions

Wednesday, 10th July from 10am – 12pm at the Thomas and Dorothy Seminar Room, there will be a user training for CEU CSD3 users.

## Contact information

Joanna Howson <jmmh2@medschl.cam.ac.uk> and Ank Michielsen <am2710@medschl.cam.ac.uk>.

support@hpc.cam.ac.uk
