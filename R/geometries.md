---
sort: 5
---

# geometries

The error message for 0.2.2 is similar to several others,

```
update.packages(ask=F)
trying URL 'https://cran.r-project.org/src/contrib/geometries_0.2.2.tar.gz'

# Content type 'application/x-gzip' length 53599 bytes (52 KB)

downloaded 52 KB

installing _source_ package ‘geometries’ ...
** package ‘geometries’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
Error: C++17 standard requested but CXX17 is not defined
removing ‘/rds/user/jhz22/hpc-work/R/geometries’
restoring previous ‘/rds/user/jhz22/hpc-work/R/geometries’
```

To proceed, we modify ~/.R/Makevars with the following line

```
CXX17 = g++ -std=gnu++17 -fPIC
```

We can get away with this,

```bash
module load gcc/6
Rscript -e "install.packages('geometries')"
```
