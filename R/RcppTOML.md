---
sort: 15
---

# R/RcppTOML

It requires C++17 therefore gcc/7, and we set ~/.R/Makevars as follows,

```
CXX17FLAGS= -fPIC
CXX17=g++ -std=gnu++17
LDFLAGS=-L/usr/local/software/master/gcc/9/lib64
```

then try

```bash
module load gcc/9
Rscript -e 'install.packages("RcppTOML")'
```

which gives error message,

```
** testing if installed package can be loaded from temporary location
Error: package or namespace load failed for ‘RcppTOML’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/rds/user/jhz22/hpc-work/R/00LOCK-RcppTOML/00new/RcppTOML/libs/RcppTOML.so':
  /usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/lib64/libstdc++.so.6: version `GLIBCXX_3.4.26' not found (required by /rds/user/jhz22/hpc-work/R/00LOCK-RcppTOML/00new/RcppTOML/libs/RcppTOML.so)
Error: loading failed
Execution halted
ERROR: loading failed
```

The dilemma is possibly created by `gcc/6` used to build R, so we seek alternative that does not have this drawback.

```bash
module load R/4.2.2
Rscript -e 'install.packages("RcppTOML")'
```
