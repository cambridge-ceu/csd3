---
sort: 14
---

# METRO

Full name: Multi-ancEstry TRanscriptOme-wide analysis (METRO)

GitHub page: [https://github.com/zhengli09/METRO](https://github.com/zhengli09/METRO).

## Installation

Assuming `module load gcc/6` is issued from the shell, we start with the usual way

```r
remotes::install_github("https://github.com/zhengli09/METRO")
```

and it fails with error message,

```
Installing package into ‘/rds/user/jhz22/hpc-work/R’
(as ‘lib’ is unspecified)
* installing *source* package ‘METRO’ ...
** using staged installation
** libs
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -I"/rds-d4/user/jhz22/hpc-work/R-4.1.3/include" -DNDEBUG  -I'/rds/user/jhz22/hpc-work/R/Rcpp/include' -I'/rds/user/jhz22/hpc-work/R/RcppArmadillo/include' -I/rds-d4/user/jhz22/hpc-work/include   -fpic  -g -O2  -c METRO.cpp -o METRO.o
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -I"/rds-d4/user/jhz22/hpc-work/R-4.1.3/include" -DNDEBUG  -I'/rds/user/jhz22/hpc-work/R/Rcpp/include' -I'/rds/user/jhz22/hpc-work/R/RcppArmadillo/include' -I/rds-d4/user/jhz22/hpc-work/include   -fpic  -g -O2  -c METROCovars.cpp -o METROCovars.o
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -I"/rds-d4/user/jhz22/hpc-work/R-4.1.3/include" -DNDEBUG  -I'/rds/user/jhz22/hpc-work/R/Rcpp/include' -I'/rds/user/jhz22/hpc-work/R/RcppArmadillo/include' -I/rds-d4/user/jhz22/hpc-work/include   -fpic  -g -O2  -c METROPleio.cpp -o METROPleio.o
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -I"/rds-d4/user/jhz22/hpc-work/R-4.1.3/include" -DNDEBUG  -I'/rds/user/jhz22/hpc-work/R/Rcpp/include' -I'/rds/user/jhz22/hpc-work/R/RcppArmadillo/include' -I/rds-d4/user/jhz22/hpc-work/include   -fpic  -g -O2  -c RcppExports.cpp -o RcppExports.o
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -shared -L/rds-d4/user/jhz22/hpc-work/R-4.1.3/lib -L/rds-d4/user/jhz22/hpc-work/lib -o METRO.so METRO.o METROCovars.o METROPleio.o RcppExports.o -L/rds-d4/user/jhz22/hpc-work/R-4.1.3/lib -lR
installing to /rds/user/jhz22/hpc-work/R/00LOCK-METRO/00new/METRO/libs
** R
** data
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded from temporary location
Error: package or namespace load failed for ‘METRO’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/rds/user/jhz22/hpc-work/R/00LOCK-METRO/00new/METRO/libs/METRO.so':
  /rds/user/jhz22/hpc-work/R/00LOCK-METRO/00new/METRO/libs/METRO.so: undefined symbol: dgesvx_
Error: loading failed
Execution halted
ERROR: loading failed
* removing ‘/rds/user/jhz22/hpc-work/R/METRO’
* restoring previous ‘/rds/user/jhz22/hpc-work/R/METRO’
Warning message:
In i.p(...) :
  installation of package ‘/rds/user/jhz22/hpc-work/work/Rtmp60sQlk/file210f85b230bc4/METRO_1.0.tar.gz’ had non-zero exit status
```

and we now work on `METRO_1.0.tar.gz` from the directory indicated above,

```bash
tar xvfz /rds/user/jhz22/hpc-work/work/Rtmp60sQlk/file210f85b230bc4/METRO_1.0.tar.gz
R CMD INSTALL METRO
```

and have similar error message:

```
* installing to library ‘/rds/user/jhz22/hpc-work/R’
* installing *source* package ‘METRO’ ...
** using staged installation
** libs
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -I"/rds-d4/user/jhz22/hpc-work/R-4.1.3/include" -DNDEBUG  -I'/rds/user/jhz22/hpc-work/R/Rcpp/include' -I'/rds/user/jhz22/hpc-work/R/RcppArmadillo/include' -I/rds-d4/user/jhz22/hpc-work/include   -fpic  -g -O2  -c METRO.cpp -o METRO.o
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -I"/rds-d4/user/jhz22/hpc-work/R-4.1.3/include" -DNDEBUG  -I'/rds/user/jhz22/hpc-work/R/Rcpp/include' -I'/rds/user/jhz22/hpc-work/R/RcppArmadillo/include' -I/rds-d4/user/jhz22/hpc-work/include   -fpic  -g -O2  -c METROCovars.cpp -o METROCovars.o
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -I"/rds-d4/user/jhz22/hpc-work/R-4.1.3/include" -DNDEBUG  -I'/rds/user/jhz22/hpc-work/R/Rcpp/include' -I'/rds/user/jhz22/hpc-work/R/RcppArmadillo/include' -I/rds-d4/user/jhz22/hpc-work/include   -fpic  -g -O2  -c METROPleio.cpp -o METROPleio.o
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -I"/rds-d4/user/jhz22/hpc-work/R-4.1.3/include" -DNDEBUG  -I'/rds/user/jhz22/hpc-work/R/Rcpp/include' -I'/rds/user/jhz22/hpc-work/R/RcppArmadillo/include' -I/rds-d4/user/jhz22/hpc-work/include   -fpic  -g -O2  -c RcppExports.cpp -o RcppExports.o
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -shared -L/rds-d4/user/jhz22/hpc-work/R-4.1.3/lib -L/rds-d4/user/jhz22/hpc-work/lib -o METRO.so METRO.o METROCovars.o METROPleio.o RcppExports.o -L/rds-d4/user/jhz22/hpc-work/R-4.1.3/lib -lR
installing to /rds/user/jhz22/hpc-work/R/00LOCK-METRO/00new/METRO/libs
** R
** data
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded from temporary location
Error: package or namespace load failed for ‘METRO’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/rds/user/jhz22/hpc-work/R/00LOCK-METRO/00new/METRO/libs/METRO.so':
  /rds/user/jhz22/hpc-work/R/00LOCK-METRO/00new/METRO/libs/METRO.so: undefined symbol: dgesvx_
Error: loading failed
Execution halted
ERROR: loading failed
* removing ‘/rds/user/jhz22/hpc-work/R/METRO’
```

We then repeat the last command from `METRO/src` directory and add -L -l as follows,

```bash
cd METRO/src
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ -std=gnu++14 -shared -L/rds-d4/user/jhz22/hpc-work/R-4.1.3/lib -L/rds-d4/user/jhz22/hpc-work/lib -o METRO.so METRO.o METROCovars.o METROPleio.o RcppExports.o -L/rds-d4/user/jhz22/hpc-work/R-4.1.3/lib -L/rds-d4/user/jhz22/hpc-work/lib/liblapack -llapack  -lR
cd -
R CMD INSTALL METRO
```

Note that the technique here is similar to R/SAIGE installation.

## Testing

The output from the GitHub page is detailed here,

```
> library(METRO)
> data(PLTP_GEUVADIS)
> METRORes <- METROSumStat(eQTLGeno, eQTLExpression, GWASzscores,
+   LDMatrix, n, verbose = T)
Starting METRO...
***** info *****
  - Handling data with 124 SNPs
  - Handling data with 2 expression studies
***** Starting EM algorithm unter the null (no effects) *****
    log-likelihood: -47352
    sigma2: 1
    sigma2beta: 0.000788926 0.0015376
    sigma2m: 0.883093 0.836214
    alpha: 0 0
***** Starting EM algorithm unter the alternative (positive effects) *****
    log-likelihood: -47287.6
    sigma2: 0.999843
    sigma2beta: 0.000782837 0.00157566
    sigma2m: 0.88352 0.835781
    alpha: 0 0
***** Starting EM algorithm unter the alternative (negative effects) *****
    log-likelihood: -47118.6
    sigma2: 0.992376
    sigma2beta: 0.000132166 0.00161972
    sigma2m: 0.993455 0.835366
    alpha: -1.67004 -0.0288259
***** done *****
> METRORes$alpha # -1.70
[1] -1.69887
> METRORes$weights # c(0.98, 0.02)
          [,1]
[1,] 0.9830323
[2,] 0.0169677
> METRORes$pvalueLRT # 4.2e-102
[1] 4.234321e-102
>
```

## Reference

Li, Z. et al. METRO: Multi-ancestry transcriptome-wide association studies for powerful gene-trait association detection. The _American Journal of Human Genetics_.
