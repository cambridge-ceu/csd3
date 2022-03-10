---
sort: 12
---

# R/protolite

When we issued `update.packages(ask=FALSE, checkBuilt=TRUE)`, we saw the following error message

```
Error: package or namespace load failed for ‘protolite’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/rds/user/jhz22/hpc-work/R/00LOCK-protolite/00new/protolite/libs/protolite.so':
  /rds/user/jhz22/hpc-work/R/00LOCK-protolite/00new/protolite/libs/protolite.so: undefined symbol: _ZNK6google8protobuf11MessageLite25InitializationErrorStringB5cxx11Ev
Error: loading failed
Execution halted
ERROR: loading failed
* removing ‘/rds/user/jhz22/hpc-work/R/protolite’
* restoring previous ‘/rds/user/jhz22/hpc-work/R/protolite’
```

We can get away with this,

```bash
module load  protobuf-3.4.0-gcc-5.4.0-zkpendv
Rscript -e "install.packages('protolite')"
```
