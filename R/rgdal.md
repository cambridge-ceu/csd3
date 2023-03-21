---
sort: 18
---

# R/rgdal

We have .R/Makevars as follows,

```bash
CC=gcc
CXX=g++ -std=gnu++11
PKG_CXXFLAGS= -std=c++11
CFLAGS = -std=c99 -I/usr/include -g -O2 -Wall -pedantic -mtune=native -Wno-ignored-attributes -Wno-deprecated-declarations -Wno-parentheses -Wimplicit-function-declaration
CXXFLAGS = -std=c++11
```

the proceed with

```bash
module load gcc/5
module load geos-3.6.2-gcc-5.4.0-vejexvy
module load gdal-2.3.1-gcc-5.4.0-m7j7nw6
module load proj-5.0.1-gcc-5.4.0-cpqxtzr
Rscript -e "install.packages('sf')"
# R 3.6.3 also requires
module load json-c-0.13.1-gcc-5.4.0-ffamohj
module load libgeotiff-1.4.2-gcc-5.4.0-2emzhxh
module load libpng-1.6.29-gcc-5.4.0-3qwhidp
module load cfitsio-3.450-gcc-5.4.0-colpo6h
module load zlib/1.2.11
module load mpich-3.2-gcc-5.4.0-idlluti
Rscript -e "install.packages('rgdal')"
```

Under R 3.6.3, there are complaints about `-std=c++11` when installing `sf` but can be dealt with it first (as described in its own section).

Finally, gdal could also be installed with proj 6 available,

```bash
./configure --with-proj=$HPC_WORK --without-sqlite3 --prefix=$HPC_WORK
```

Then `proj_api.h` should have a statement

```c
#define ACCEPT_USE_OF_DEPRECATED_PROJ_API_H 1
```

## 1.6-5

We have seen errors

```
./configure: line 2526: -I/rds/user/jhz22/hpc-work/include: No such file or directory
./configure: line 2541: -I/rds/user/jhz22/hpc-work/include: No such file or directory
configure: Install failure: compilation and/or linkage problems.
configure: error: GDALAllRegister not found in libgdal.
ERROR: configuration failed for package ‘rgdal’
* removing ‘/rds/user/jhz22/hpc-work/R/rgdal’
* restoring previous ‘/rds/user/jhz22/hpc-work/R/rgdal’

The downloaded source packages are in
        ‘/rds/user/jhz22/hpc-work/work/Rtmpa8tFOu/downloaded_packages’
Warning message:
In install.packages("rgdal") :
  installation of package ‘rgdal’ had non-zero exit status
Error in qq() : could not find function "qq"
```

which goes away with C++17, namely, `~/.R/Makevars`

```bash
CXX17 = g++ -std=gnu++17 -fPIC
```
