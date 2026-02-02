---
sort: 31
---

# GCTA

Three components will be covered: direct download of the executable file, compiling it from source and running the documentation example.

## Executable

Web: [https://yanglab.westlake.edu.cn/software/gcta](https://yanglab.westlake.edu.cn/software/gcta)

The setup is quite straitforward.

```bash
cd ${HPC_WORK}
wget https://yanglab.westlake.edu.cn/software/gcta/bin/gcta_1.93.3beta2.zip
unzip gcta_1.93.3beta2.zip
cd gcta_1.93.3beta2/
ln -sf ${HPC_WORK}/gcta_1.93.3beta2/gcta64 ${HPC_WORK}/bin/gcta-1.9
```

For the recommended version 1.94.1, we have

```bash
wget https://yanglab.westlake.edu.cn/software/gcta/bin/gcta-1.94.1-linux-kernel-3-x86_64.zip
unzip  gcta-1.94.1-linux-kernel-3-x86_64.zip
cd gcta-1.94.1-linux-kernel-3-x86_64/
ln -sf ${PWD}/gcta-1.94.1 ${HPC_WORK}/bin/gcta-1.9
```

## Source

Distribution with the paper: [https://zenodo.org/record/5226943/files/jianyangqt/gcta-v1.93.3beta2.zip](https://zenodo.org/record/5226943/files/jianyangqt/gcta-v1.93.3beta2.zip).

GitHub: [https://github.com/jianyangqt/gcta](https://github.com/jianyangqt/gcta).

Note that they work with a specific version of plink-ng from [https://github.com/zhilizheng/plink-ng](https://github.com/zhilizheng/plink-ng). With GitHub, we could track any change(s) we made with `git diff`.

### v1.93.3beta2

We proceed as follows,

```bash
module load eigen/3.3.7
module load intel/mkl/2017.8
module load spectra/0.8.1
export EIGEN3_INCLUDE_DIR=/usr/local/software/master/eigen/latest/include
export BOOST_LIB=/usr/local/Cluster-Apps/boost/1.65.1/python3.5.1-gcc5.3.0/
export SPECTRA_LIB=/usr/local/Cluster-Apps/spectra/0.8.1
git clone https://github.com/jianyangqt/gcta
cd gcta
cd submods
git clone https://github.com/zhilizheng/plink-ng
cd ..
mkdir build && cd build
cmake ..
make
```

It requires specifications of `/usr/local/Cluster-Apps/spectra/0.8.1/include/Spectra/` in `FastFAM.cpp` and `zstd.h` in `Geno.cpp`. We also get complaints about -lzstd and but could get around with adding -L${HPC_WORK}/lib to `CMakeFiles//gcta64.dir/link.txt` and then `bash CMakeFiles//gcta64.dir/link.txt` which gives the much-desired `gcta64`.

The `libgsl.so.25` is provided with `gsl-2.6` which can be set up as follows,

```bash
wget -qO- https://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz | tar xfz -
cd gsl-2.6/
configure --prefix=$HPC_WORK
make
make install
```

### v1.94.1

Ahead of the `make` command, check with `git submodule update --init`.

There is still complaint about "zstd.h" in `Geno.cpp` and change it to \<zstd.h\> and precede with `module load zstd-1.3.0-intel-17.0.4-eyn6gaw`. Again there are complaints about Spectra/ and we replace

```cpp
#include <Spectra/SymEigsSolver.h>
#include <Spectra/MatOp/SparseSymMatProd.h>
```

with

```cpp
//#include <Spectra/SymEigsSolver.h>
//#include <Spectra/MatOp/SparseSymMatProd.h>
#include "/usr/local/Cluster-Apps/spectra/0.8.1/include/Spectra/SymEigsSolver.h"
#include "/usr/local/Cluster-Apps/spectra/0.8.1/include/Spectra/MatOp/SparseSymMatProd.h"
```

in `FastFAM.cpp`.

now we are able to build `gcta64` whose size is substantially smaller (~13MB) than the distributed file.

## Documentation example

We use the documentation example to illutrate a linear mixed model (LMM).

```bash
gcta-1.9 --bfile test --make-grm --out test
gcta-1.9 --grm test --reml --pheno test.phen --out test
```

Where the first statement generates the genomic relationship matrix (GRM) followed by the second statement for the LMM via restricted maximum likelihood (REML). The screen outputs are given here as well,

```
*******************************************************************
* Genome-wide Complex Trait Analysis (GCTA)
* version v1.94.1 Linux
* Built at Aug  3 2022 04:46:31, by GCC 8.5
* (C) 2010-present, Yang Lab, Westlake University
* Please report bugs to Jian Yang <jian.yang@westlake.edu.cn>
*******************************************************************
Analysis started at 11:26:53 BST on Wed Aug 03 2022.
Hostname: login-e-16

Options:

--bfile test
--make-grm
--out test

The program will be running with up to 1 threads.
Note: GRM is computed using the SNPs on the autosomes.
Reading PLINK FAM file from [test.fam]...
3925 individuals to be included from FAM file.
3925 individuals to be included. 1643 males, 2282 females, 0 unknown.
Reading PLINK BIM file from [test.bim]...
1000 SNPs to be included from BIM file(s).
Computing the genetic relationship matrix (GRM) v2 ...
Subset 1/1, no. subject 1-3925
  3925 samples, 1000 markers, 7704775 GRM elements
IDs for the GRM file have been saved in the file [test.grm.id]
Computing GRM...
  100% finished in 0.5 sec
1000 SNPs have been processed.
  Used 1000 valid SNPs.
The GRM computation is completed.
Saving GRM...
GRM has been saved in the file [test.grm.bin]
Number of SNPs in each pair of individuals has been saved in the file [test.grm.N.bin]

Analysis finished at 11:26:54 BST on Wed Aug 03 2022
Overall computational time: 1.21 sec.
(base) 11:26 jhz22@login-e-16 ~/hpc-work/gcta-1.94.1-linux-kernel-3-x86_64 $ gcta-1.9 --grm test --reml --pheno test.phen --out test
*******************************************************************
* Genome-wide Complex Trait Analysis (GCTA)
* version v1.94.1 Linux
* Built at Aug  3 2022 04:46:31, by GCC 8.5
* (C) 2010-present, Yang Lab, Westlake University
* Please report bugs to Jian Yang <jian.yang@westlake.edu.cn>
*******************************************************************
Analysis started at 11:26:54 BST on Wed Aug 03 2022.
Hostname: login-e-16

Accepted options:
--grm test
--reml
--pheno test.phen
--out test

Note: This is a multi-thread program. You could specify the number of threads by the --thread-num option to speed up the computation if there are multiple processors in your machine.

Reading IDs of the GRM from [test.grm.id].
3925 IDs are read from [test.grm.id].
Reading the GRM from [test.grm.bin].
GRM for 3925 individuals are included from [test.grm.bin].
Reading phenotypes from [test.phen].
Non-missing phenotypes of 3925 individuals are included from [test.phen].

3925 individuals are in common in these files.

Performing  REML analysis ... (Note: may take hours depending on sample size).
3925 observations, 1 fixed effect(s), and 2 variance component(s)(including residual variance).
Calculating prior values of variance components by EM-REML ...
Updated prior values: 0.462455 0.889944
logL: -2529.14
Running AI-REML algorithm ...
Iter.   logL    V(G)    V(e)
1       -2074.82        0.02389 0.91928
2       -1945.84        0.02343 0.93419
3       -1944.49        0.02309 0.94480
4       -1943.84        0.02283 0.95228
5       -1943.53        0.02223 0.96878
6       -1943.25        0.02216 0.96911
7       -1943.24        0.02215 0.96912
8       -1943.24        0.02215 0.96912
Log-likelihood ratio converged.

Calculating the logLikelihood for the reduced model ...
(variance component 1 is dropped from the model)
Calculating prior values of variance components by EM-REML ...
Updated prior values: 0.99065
logL: -1947.71500
Running AI-REML algorithm ...
Iter.   logL    V(e)
1       -1947.71        0.99065
Log-likelihood ratio converged.

Summary result of REML analysis:
Source  Variance        SE
V(G)    0.022152        0.008751
V(e)    0.969117        0.022896
Vp      0.991269        0.022467
V(G)/Vp 0.022347        0.008769

Sampling variance/covariance of the estimates of variance components:
7.657779e-05    -4.800941e-05
-4.800941e-05   5.242193e-04

Summary result of REML analysis has been saved in the file [test.hsq].

Analysis finished at 11:27:12 BST on Wed Aug 03 2022
Overall computational time: 17.87 sec.
```

Therefore the documentation example provides a heritability estimate of 0.0223 (0.00877). The version compiled from source takes 19.86 sec for the heritability analysis (slower).

It offers alternative to regenie on this site according to the associate paper below.

## References

Li, A. et al. mBAT-combo: a more powerful test to detect gene-trait associations from GWAS data. _bioRxiv_, 2022.06.27.497850 (2022).

Jiang, L., Zheng, Z., Fang, H. & Yang, J. A generalized linear mixed model association tool for biobank-scale data. _Nat Genet_ 53, 1616-1621 (2021).
