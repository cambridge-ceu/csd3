---
sort: 29
---

# R/SPACox

GitHub page: [https://github.com/WenjianBI/SPACox](https://github.com/WenjianBI/SPACox).

## Installation

This is quite straightforward,

```bash
Rscript -e 'remotes::install_github("WenjianBi/SPACox")'
```

## Example

This is extracted from the documentation,

```R
options(width=200)
# Simulation phenotype and genotype
N = 10000
nSNP = 1000
MAF = 0.1
Phen.mtx = data.frame(ID = paste0("IID-",1:N),
                      event=rbinom(N,1,0.5),
                      time=runif(N),
                      Cov1=rnorm(N),
                      Cov2=rbinom(N,1,0.5))
Geno.mtx = matrix(rbinom(N*nSNP,2,MAF),N,nSNP)

# NOTE: The row and column names of genotype matrix are required.
rownames(Geno.mtx) = paste0("IID-",1:N)
colnames(Geno.mtx) = paste0("SNP-",1:nSNP)
Geno.mtx[1:10,1]=NA   # please use NA for missing genotype

library(survival)
obj.null = SPACox_Null_Model(Surv(time,event)~Cov1+Cov2, data=Phen.mtx,
                             pIDs=Phen.mtx$ID, gIDs=rownames(Geno.mtx))
SPACox.res = SPACox(obj.null, Geno.mtx)

## missing data in response/indicator variables is also supported. Please do not remove pIDs of subjects with missing data, the program will do it.
Phen.mtx$event[2] = NA
Phen.mtx$Cov1[5] = NA
obj.null = SPACox_Null_Model(Surv(time,event)~Cov1+Cov2, data=Phen.mtx,
                             pIDs=Phen.mtx$ID, gIDs=rownames(Geno.mtx))
SPACox.res = SPACox(obj.null, Geno.mtx)

# The below is an example code to use survival package
coxph(Surv(time,event)~Cov1+Cov2+Geno.mtx[,1], data=Phen.mtx)
```

e.g.,

```
> head(SPACox.res)
             MAF missing.rate p.value.spa p.value.norm        Stat      Var           z
SNP-1 0.09894895        0.001  0.07643336   0.07643336  53.5831703 914.6268  1.77176631
SNP-2 0.09830000        0.000  0.16184624   0.16184624  42.1840634 909.3483  1.39888912
SNP-3 0.09825000        0.000  0.61840306   0.61840306  15.1450977 924.4535  0.49811490
SNP-4 0.09930000        0.000  0.98944869   0.98944869   0.4026137 926.8704  0.01322449
SNP-5 0.10160000        0.000  0.96049396   0.96049396  -1.5120055 931.7613 -0.04953373
SNP-6 0.09940000        0.000  0.15452904   0.15452904 -42.7052469 899.7388 -1.42371482
```

with the revised results when setting missing values,

```
> head(SPACox.res)
             MAF missing.rate p.value.spa p.value.norm       Stat      Var           z
SNP-1 0.09894895        0.001  0.07646501   0.07646501  53.582796 914.8108  1.77157573
SNP-2 0.09830000        0.000  0.16339246   0.16339246  42.032466 909.4915  1.39375216
SNP-3 0.09825000        0.000  0.62175334   0.62175334  15.001924 924.5998  0.49336693
SNP-4 0.09930000        0.000  0.96771374   0.96771374   1.231271 925.3686  0.04047588
SNP-5 0.10160000        0.000  0.95640239   0.95640239  -1.668880 931.9064 -0.05466872
SNP-6 0.09940000        0.000  0.15302839   0.15302839 -42.864602 899.8792 -1.42891595
```

## Related software

See also [SurvivalGWAS_SV](https://cambridge-ceu.github.io/csd3/applications/SurvivalGWAS_SV.html) and [snpnet](https://cambridge-ceu.github.io/csd3/R/snpnet.html).

## Reference

Bi, W., Fritsche, L.G., Mukherjee, B., Kim, S. & Lee, S. A Fast and Accurate Method for Genome-Wide Time-to-Event Data Analysis and Its Application to UK Biobank. The American Journal of Human Genetics 107, 222-233 (2020).

RESOURCES at the Lee lab (accessed on 11/3/2022), [https://www.leelabsg.org/resources](https://www.leelabsg.org/resources).
