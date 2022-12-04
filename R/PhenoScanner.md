---
sort: 10
---

# R/PhenoScanner

## R package setup

```bash
install.packages("devtools")
library(devtools)
install_github("phenoscanner/phenoscanner")
library(phenoscanner)
example(phenoscanner)
```

## Long query

The call is made by chunks, e.g.,

```r
options(width=500)
require(phenoscanner)
rsid <- scan("swath-ms-invn.snp",what="")
batches <- split(rsid, ceiling(seq_along(rsid)/100))
s <- t <- list()
for(i in 1:length(batches))
{
  q <- phenoscanner(snpquery=batches[[i]], catalogue="pQTL", proxies = "EUR", pvalue = 1e-07, r2= 0.6, build=37)
  s[[i]] <- with(q,snps)
  t[[i]] <- with(q,results)
}
snps <- do.call(rbind,s)
results <- do.call(rbind,t)
r <- list(snps=snps,results=results)
```

i.e., each chunk has 100 SNPs and chunks are combined manually.

## Command-line interface (CLI)

```bash
module load ceuadmin/phenoscanner
phenoscanner --help
phenoscanner --snp=rs704 -c All -x EUR -r 0.8
phenoscanner -s T -c All -x EUR -p 0.0000001 --r2 0.6 -i INF1.merge.snp -o INF1
```

Note that `module load phenoscanner` is enabled from ~/.bashrc:

```bash
export MODULEPATH=${MODULEPATH}:/usr/local/Cluster-Config/modulefiles/ceuadmin/
```

via `source ~/.bashrc` or a new login.

## R 4.x.x

Section above would fail under R 4.x.x; to get around, make a copy of phenoscanner according to

```bash
module load ceuadmin/phenoscanner
which phenoscanner
# /rds/project/jmmh2/rds-jmmh2-projects/phenoscanner/mrcatalogue/mrcatalogue/phenoscanner_v2/phenoscanner
```

and edit the header to call packages at the default R_LIBS location,

```r
#!/rds/user/jhz22/hpc-work/bin/Rscript
suppressPackageStartupMessages(library(getopt))
suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(DBI))
suppressPackageStartupMessages(library(RMySQL))
suppressPackageStartupMessages(library(reshape2))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(stringi))
```

then deposit this to a directory on the search path and invoke,

```bash
module load gcc/6
phenoscanner -h
phenoscanner -s chr5:29439275
```

and we have `chr5:29439275_PhenoScanner_SNP_Info.tsv` and `chr5:29439275_PhenoScanner_GWAS.tsv` for variant annotation and GWAS lookup, respectively; one can add `-c None` to the last command and get the SNP annotation only.

## R 4.2.2

<font color="red"><b>4/12/2022 Update</b></font>module `ceuadmin/phenoscanner/v2` <font color="blue"><b>implements changes aforementioned.</b></font>

```bash
module load ceuadmin/phenoscanner/v2
```

which also uses ceuadmin/R/4.2.2.
