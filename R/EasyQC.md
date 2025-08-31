---
sort: 4
---

# EasyQC

Web: [https://www.uni-regensburg.de/medizin/epidemiologie-praeventivmedizin/genetische-epidemiologie/software/index.html](https://www.uni-regensburg.de/medizin/epidemiologie-praeventivmedizin/genetische-epidemiologie/software/index.html)

## Setup

```bash
Rscript -e "install.packages('https://homepages.uni-regensburg.de/~wit59712/easyqc/EasyQC_23.8.tar.gz', repos = NULL, type = 'source')"
```

## Documentation example

With installation at `${HPC_WORK}` (`/rds/user/$USER/hpc-work/R/EasyQC`) we could modify the example script

```bash
sed -i "s|EASY_INSTALL_DIR|/rds/user/$USER/hpc-work/R/EasyQC/extdata/|" /rds/user/$USER/hpc-work/R/EasyQC/extdata/example_qc.ecf
Rscript -e "library(EasyQC);installDir=system.file('extdata', package='EasyQC');ecfFileQc=file.path(installDir,'example_qc.ecf');EasyQC(ecfFileQc)"
```

and we have these output available from the current directory:

```
CLEANED.studyX_file1.txt
CLEANED.studyX_file1.txt.10rows
CLEANED.studyX_file2.txt
CLEANED.studyX_file2.txt.10rows
example_qc.rep
```

One can carry on with downloading reference data from the website above as well.
