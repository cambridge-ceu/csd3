---
sort: 31
---

# R/protolite

We may see this message,

```
Error: package or namespace load failed for ‘protolite’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/rds/user/jhz22/hpc-work/R/00LOCK-protolite/00new/protolite/libs/protolite.so':
  /rds/user/jhz22/hpc-work/R/00LOCK-protolite/00new/protolite/libs/protolite.so: undefined symbol: _ZNK6google8protobuf11MessageLite25InitializationErrorStringB5cxx11Ev
Error: loading failed
Execution halted
ERROR: loading failed
```

This can be furnished with

```bash
module load protobuf-3.4.0-gcc-5.4.0-zkpendv
```

and try again.
