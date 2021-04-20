---
sort: 24
---

# R/PKI

When installing/updating the package, the following error message appears,

```
Error: package or namespace load failed for ‘PKI’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/rds/user/jhz22/hpc-work/R/00LOCK-PKI/00new/PKI/libs/PKI.so':
  /rds/user/jhz22/hpc-work/R/00LOCK-PKI/00new/PKI/libs/PKI.so: undefined symbol: EVP_CIPHER_CTX_reset
Error: loading failed
Execution halted
ERROR: loading failed
```

and one can get around with a twist of openssl, e.g.,

```bash
Rscript -e "download.packages('PKI','.')"
tar xvfz PKI_0.1-8.tar.gz
module load openssl-1.1.0e-gcc-5.4.0-a4xxzqm
cd PKI
./configure PKG_CPPFLAGS="-I/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/openssl-1.1.0e-a4xxzqmcsb3o2o7yctmpxef3cp36qk33/include/openssl/" \
            PKG_LIBS="-L/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/openssl-1.1.0e-a4xxzqmcsb3o2o7yctmpxef3cp36qk33/lib"
# with openssl-1.1.1h installed locally
# ./configure PKG_CPPFLAGS="-I/rds-d4/user/jhz22/hpc-work/openssl-1.1.1h/include/openssl" PKG_LIBS="-L/rds-d4/user/jhz22/hpc-work/openssl-1.1.1h"
mv configure configure.sav
cd -
R CMD INSTALL PKI
```
