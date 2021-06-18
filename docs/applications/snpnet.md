---
sort: 50
---

# R/snpnet

GitHub page: [https://github.com/rivas-lab/snpnet](https://github.com/rivas-lab/snpnet).

A number of software needs to be set up with the current version.

```bash
module load lz4-1.8.1.2-intel-17.0.4-celw56p
wget https://github.com/facebook/zstd/releases/download/v1.4.4/zstd-1.4.4.tar.gz
tar xfz zstd-1.4.4.tar.gz
cd zstd-1.4.4
make
make install prefix=$HPC_WORK
# gcc/6 is required for pgenlibr
module load gcc/6
```

File `dotCall64/Makevars` needs to be modified, but can be difficult (e.g., reinstallation of gettext, https://ftp.gnu.org/gnu/gettext/gettext-0.20.tar.gz), then

```
PKG_CFLAGS = $(SHLIB_OPENMP_CFLAGS) -I../inst/include/ -DDOTCAL64_PRIVATE -I$HPC_WORK/include
PKG_LIBS = $(SHLIB_OPENMP_CFLAGS) -L$HPC_WORK/lib -lintl
```

Finally, we can proceed

```r
devtools::install_github("junyangq/glmnetPlus")
devtools::install_github("chrchang/plink-ng", subdir="/2.0/cindex")
devtools::install_github("chrchang/plink-ng", subdir="/2.0/pgenlibr")
devtools::install_github("rivas-lab/snpnet")
```
