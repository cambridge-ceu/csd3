---
sort: 22
---

# R/sojo

GitHub page: [https://github.com/zhenin/sojo](https://github.com/zhenin/sojo).

```r
install.packages("sojo", repos = "http://R-Forge.R-project.org")
# Swedish twin registry
download.file("https://www.dropbox.com/s/ty1udfhx5ohauh8/LD_chr22.rda?raw=1",
destfile = paste0(find.package('sojo'), "/LD_chr22.rda"))
load(file = paste0(find.package('sojo'), "/LD_chr22.rda"))
# 1000Genomes
download.file("https://data.broadinstitute.org/alkesgroup/LDSCORE/1000G_Phase3_plinkfiles.tgz",
destfile = paste0(find.package('sojo'), "/1000G_Phase3_plinkfiles.tgz"))
untar(paste0(find.package('sojo'), "/1000G_Phase3_plinkfiles.tgz"),exdir=find.package('sojo'))
require(sojo)
data(sum.stat.discovery)
hpc_work <- Sys.getenv("HPC_WORK")
path.plink <- paste0(hpc_work,"/bin/plink")
path.1kG <- paste0(find.package('sojo'),"/1000G_EUR_Phase3_plink")
snps <- sum.stat.discovery$SNP
write.table(snps, file = paste0(snps[1],"_snp_list.txt"), quote = F, row.names = F, col.names = F)
chr <- 22
system(paste0(path.plink," -bfile ", path.1kG,"/1000G.EUR.QC.",chr," --r square --extract ", snps[1], "_snp_list.txt --out ", snps[1], " --noweb"))
system(paste0(path.plink," -bfile ", path.1kG,"/1000G.EUR.QC.",chr," --freq --extract ", snps[1], "_snp_list.txt --out ", snps[1], " --noweb"))
LD_1kG <- as.matrix(read.table(paste0(snps[1], ".ld")))
maf_1kG <- read.table(paste0(snps[1], ".frq"), header = T)
snp_ref_1kG <- maf_1kG[,"A2"]
names(snp_ref_1kG) <- maf_1kG[,"SNP"]
colnames(LD_1kG) <- rownames(LD_1kG) <- maf_1kG$SNP
res <- sojo(sum.stat.discovery, LD_ref = LD_mat, snp_ref = snp_ref, nvar = 20)
matplot(log(res$lambda.v), t(as.matrix(res$beta.mat)), lty = 1, type = "l",
    xlab = expression(paste(log, " ", lambda)), ylab = "Coefficients", main = "Summary-level LASSO")
data(sum.stat.validation)
res.valid <- sojo(sum.stat.discovery, sum.stat.validation, LD_ref = LD_mat, snp_ref = snp_ref, nvar = 20)
```
