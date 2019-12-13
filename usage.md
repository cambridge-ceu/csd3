# Additional software

This document contains information for the following software: DosageConverter, HESS, PhenoScanner, R, rjags, rstan, SAIGE,

## DosageConverter

```bash
## assuming you use hpc-work/ with a subdirectory called bin/
cd /rds/user/$USER/hpc-work/
git clone https://github.com/Santy-8128/DosageConvertor
cd DosageConverter
pip install cget --user
module load cmake-3.8.1-gcc-4.8.5-zz55m7x
./install.sh
cd /rds/user/$USER/hpc-work/bin/
ln -s /rds/user/$USER/hpc-work/DosageConvertor/release-build/DosageConvertor
## testing
DosageConvertor  --vcfDose  test/TestDataImputedVCF.dose.vcf.gz \
                 --info     test/TestDataImputedVCF.info \
                 --prefix   test \
                 --type     mach

gunzip -c test.mach.dose.gz | wc -l

DosageConvertor  --vcfDose  test/TestDataImputedVCF.dose.vcf.gz \
                 --info     test/TestDataImputedVCF.info \
                 --prefix   test \
                 --type     plink

gunzip -c test.plink.dosage.gz | wc -l
```
so the MaCH dosage file is individual x genotype whereas PLINK dosage file is genotype x individual.

## HESS

This section is extracted from https://github.com/jinghuazhao/software-notes.

HESS (Heritability Estimation from Summary Statistics) is now available from https://github.com/huwenboshi/hess and has a web page at

https://huwenboshi.github.io/hess-0.5/#hess

To prepare for the software, one can proceeds with
```bash
python -m pip install pysnptools --user
```
Now we set up for analysis of height
```bash
#!/bin/bash

export HEIGHT=https://portals.broadinstitute.org/collaboration/giant/images/0/01/GIANT_HEIGHT_Wood_et_al_2014_publicrelease_HapMapCeuFreq.txt.gz

wget -qO- $HEIGHT | \
awk 'NR>1' | \
sort -k1,1 | \
join -13 -21 snp150.txt - | \
awk '($9!="X" && $9!="Y" && $9!="Un"){if(NR==1) print "SNP CHR BP A1 A2 Z N"; else print $1,$2,$3,$4,$5,$7/$8,$10}' > height.tsv.gz

#  SNP - rs ID of the SNP (e.g. rs62442).
#  CHR - Chromosome number of the SNP. This should be a number between 1 and 22.
#  BP - Base pair position of the SNP.
#  A1 - Effect allele of the SNP. The sign of the Z-score is with respect to this allele.
#  A2 - The other allele of the SNP.
#  Z - The Z-score of the SNP.
#  N - Sample size of the SNP.
```
where snp150.txt from UCSC is described at the SUMSTATS repository, [https://github.com/jinghuazhao/SUMSTATS](https://github.com/jinghuazhao/SUMSTATS).
```bash
for chrom in $(seq 22)
do
    python hess.py \
        --local-hsqg height \
        --chrom $chrom \
        --bfile 1kg_eur_1pct/1kg_eur_1pct_chr${chrom} \
        --partition nygcresearch-ldetect-data-ac125e47bf7f/EUR/fourier_ls-chr${chrom}.bed \
        --out step1
done
python hess.py --prefix step1 --reinflate-lambda-gc 1 --tot-hsqg 0.8 0.2 --out step2
```
It is preferable to use `miniconda` since it associates with faster libraries.
```bash
module load miniconda2-4.3.14-gcc-5.4.0-xjtq53h
conda install pandas
```

## PhenoScanner

Here are examples loading command-line interface (CLI),
```bash
module load ceuadmin/phenoscanner
phenoscanner --help
phenoscanner --snp=rs123 -c All -x EUR -r 0.8
phenoscanner -s T -c All -x EUR -p 0.0000001 --r2 0.6 -i INF1.merge.snp -o INF1
```
and R package,
```bash
install.packages("devtools")
library(devtools)
install_github("phenoscanner/phenoscanner")
library(phenoscanner)
example(phenoscanner)
```
Note that `module load phenoscanner` is enabled from ~/.bashrc:
```
export MODULEPATH=${MODULEPATH}:/usr/local/Cluster-Config/modulefiles/ceuadmin/
```
via `source ~/.bashrc` or a new login.

## R

To compile all the PDF documentations, load texlive.
```bash
module load texlive
./configure --prefix=/rds-d4/$HOME/hpc-work \
            --enable-R-shlib CPPFLAGS=-I/rds-d4/$HOME/hpc-work/include LDFLAGS=-L/rds-d4/$HOME/hpc-work/lib
```
Package reinstallation could be done with `update.packages(checkBuilt = TRUE, ask = FALSE)`.

## rjags

It is known for sometime for its difficulty to install; here is what was done
```bash

# Cardio
export PKG_CONFIG_PATH=/scratch/jhz22/lib/pkgconfig

R CMD INSTALL rjags_4-6.tar.gz --configure-args='CPPFLAGS="-fPIC" LDFLAGS="-L/scratch/jhz22/lib -ljags"
--with-jags-prefix=/scratch/jhz22
--with-jags-libdir=/scratch/jhz22/lib
--with-jags-includedir=/scratch/jhz22/include'

# csd3
export hpcwork=/rds-d4/user/jhz22/hpc-work
export PKG_CONFIG_PATH=${hpcwork}/lib/pkgconfig

wget https://cran.r-project.org/src/contrib/rjags_4-10.tar.gz
R CMD INSTALL rjags_4-10.tar.gz --configure-args='CPPFLAGS="-fPIC" LDFLAGS="-L${hpcwork}/lib -ljags"
--with-jags-prefix=${hpcwork}
--with-jags-libdir=${hpcwork}/lib
--with-jags-includedir=${hpcwork}/include'
```

## rstan

It is necessary to have `¬/.R/Makevars` the following lines,
```
CXX14 = g++ -std=c++1y -fPIC
```
to do away with the error message ``C++14 standard requested but CXX14 is not defined`.

In case `ggplot2` installed with `gcc 5.2.0` it is also necessary to preceed with `module load gcc/5`.

## SAIGE 0.35.8.2

```bash
module load boost-1.58.0-gcc-5.4.0-onpiqcr
module load gcc-5.4.0-gcc-4.8.5-fis24gg
```
then one can use `library(SAIGE)` inside R.
