---
sort: 22
---

# R/xlsx

When there is message,

```
Error: .onLoad failed in loadNamespace() for 'rJava', details:
  call: dyn.load(file, DLLpath = DLLpath, ...)
  error: unable to load shared object '/rds/user/jhz22/hpc-work/R/rJava/libs/rJava.so':
  libjvm.so: cannot open shared object file: No such file or directory
Execution halted
ERROR: lazy loading failed for package ‘xlsx’
* removing ‘/rds/user/jhz22/hpc-work/R/xlsx’
* restoring previous ‘/rds/user/jhz22/hpc-work/R/xlsx’

```

then see description on `rJava` earlier.
