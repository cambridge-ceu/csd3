---
sort: 43
---

# R/sf

A number of packages use it as dependency and there might be error such as this,

```
Error in dyn.load(file, DLLpath = DLLpath, ...) :
  unable to load shared object '/rds/user/jhz22/hpc-work/R/sf/libs/sf.so':
  /rds/user/jhz22/hpc-work/R/sf/libs/sf.so: undefined symbol: GEOSSTRtree_nearest_generic_r
Calls: <Anonymous> ... asNamespace -> loadNamespace -> library.dynam -> dyn.load
Execution halted
```

We can get away with this,

```bash
module load geos-3.6.2-gcc-5.4.0-vejexvy
module load gcc/6
Rscript -e "install.packages('sf')"
```
