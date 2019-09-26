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

The installation can be made and documentation example run as follows, 
```bash
install.packages("devtools")
library(devtools)
install_github("phenoscanner/phenoscanner")
library(phenoscanner)
example(phenoscanner)
```

## SAIGE 0.35.8.2

```bash
module load boost-1.58.0-gcc-5.4.0-onpiqcr
module load gcc-5.4.0-gcc-4.8.5-fis24gg
```
then one can use `library(SAIGE)` inside R.
