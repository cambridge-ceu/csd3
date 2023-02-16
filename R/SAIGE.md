---
sort: 23
---

# R/SAIGE

## 0.36.6 and 0.39.2

Full name: Scalable and Accurate Implementation of GEneralized mixed model (SAIGE)

GitHub page: [https://github.com/weizhouUMICH/SAIGE](https://github.com/weizhouUMICH/SAIGE).

The following is based on source from GitHub (so with the possibility to git pull),

```bash
module load cmake/3.9 gcc/5
module load python/2.7
virtualenv py27
source py27/bin/activate
pip install cget
git clone https://github.com/weizhouUMICH/SAIGE
R CMD INSTALL SAIGE
```

Now we see `.../SAIGE.so: undefined symbol: sgecon_`. One can get away with it by renaming `configure` to `configure.sav` (so avoid repeated downloads) and amend the last `g++ ... -o SAIGE.so` with `-L$HPC_WORK/lib64 -llapack` and then rerun `R CMD INSTALL SAIGE`. After successful installation, we can try `cd SAIGE/extdata; bash cmd.sh`.

One of the third party software is `bgenix` (BE careful with a buggy `cat-bgen`!), whose `wscript` uses Python 2 syntax so it is necessary to stick to python/2.7 explicitly since gcc/5 automatically loads python 3.

```
cd SAIGE
cd thirdParty
cd bgen
./waf configure --prefix=$HPC_WORK
./waf
./waf install
build/test/unit/test_bgen
build/apps/bgenix -g example/example.16bits.bgen -list
cd ../../..
```

See [https://github.com/weizhouUMICH/SAIGE/issues/98](https://github.com/weizhouUMICH/SAIGE/issues/98).

For the latest version 0.39.2 which deals with the chromosome X ploidy, the following steps are necessary

```bash
R -e "devtools::install_github('leeshawn/MetaSKAT')"
R -e "devtools::install_github('leeshawn/SPAtest')"
git clone --depth 1 -b 0.39.2 https://github.com/weizhouUMICH/SAIGE
R CMD INSTALL SAIGE
```

which first installs MetaSKAT 0.80 also at CRAN but SPAtest 3.1.2 instead of 3.0.2 from CRAN.

## 1.x.x

GitHub: [https://github.com/saigegit/SAIGE](https://github.com/saigegit/SAIGE) (documentation, [https://saigegit.github.io/SAIGE-doc/](https://saigegit.github.io/SAIGE-doc/))

As before it requires Python to be functional; by default this is bundled to anaconda. However, it is possible with a plain Python virtual environment under Python 3.x.

```bash
module load gcc/6
git clone https://github.com/saigegit/SAIGE
R CMD INSTALL SAIGE
```

Note that I have already used R 4.2.0 and libreadline 6.x as default; it is possible that R/4.2.0 and/or some readline module are also needed to be loaded. My call to `library(help=SAIGE)` gives,

```
                Information on package ‘SAIGE’

Description:

Package:              SAIGE
Type:                 Package
Title:                Efficiently controlling for case-control
                      imbalance and sample relatedness in
                      single-variant assoc tests (SAIGE) and
                      controlling for sample relatedness in
                      region-based assoc tests in large cohorts and
                      biobanks (SAIGE-GENE+)
Version:              1.0.8
Date:                 2022-05-13
Author:               Wei Zhou, Zhangchen Zhao, Wenjian Bi, Seunggeun
                      Lee, Cristen Willer
Maintainer:           SAIGE team <saige.genetics@gmail.com>
Description:          an R package that implements the Scalable and
                      Accurate Implementation of Generalized mixed
                      model that uses the saddlepoint approximation
                      (SPA)(mhof, J. P. , 1961; Kuonen, D. 1999; Dey,
                      R. et.al 2017) and large scale optimization
                      techniques to calibrate case-control ratios in
                      logistic mixed model score tests (Chen, H. et al.
                      2016) in large PheWAS. It conducts both
                      single-variant association tests and set-based
                      tests for rare variants.
License:              GPL (>= 2)
Imports:              Rcpp (>= 1.0.7), RcppParallel, Matrix,
                      data.table, RcppArmadillo (>= 0.10.7.5)
LinkingTo:            Rcpp, RcppArmadillo (>= 0.10.7.5), RcppParallel,
                      data.table, SPAtest (== 3.1.2), RcppEigen,
                      Matrix, methods, BH, optparse, SKAT, MetaSKAT,
                      qlcMatrix, RhpcBLASctl, RSQLite, dplyr
Depends:              R (>= 3.5.0)
SystemRequirements:   GNU make
RoxygenNote:          7.1.2
NeedsCompilation:     yes
Encoding:             UTF-8
Packaged:             2021-05-13 EST
Built:                R 4.2.0; x86_64-pc-linux-gnu; 2022-05-16 14:45:22
                      UTC; unix

Index:

SAIGE-package           Efficiently controlling for unbalanced
                        case-control ratios and sample relatedness for
                        binary traits in PheWAS by large cohorts
SPAGMMATtest            Run single variant score tests with SPA based
                        on the logistic mixed model.
fitNULLGLMM             Fit the null logistic mixed model and estimate
                        the variance ratio by a set of randomly
                        selected variants
hello                   A simple function doing little
rcpparma_hello_world    Set of functions in example RcppArmadillo
                        package
```
