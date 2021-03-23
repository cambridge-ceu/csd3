---
sort: 19
---

# PCA projection

Official page: [https://github.com/covid19-hg/pca_projection](https://github.com/covid19-hg/pca_projection).

```bash
git clone https://github.com/covid19-hg/pca_projection
cd pca_projection
```

The setup can be summarised as follows,

```bash
# Pre-computed PCA loadings, reference allele frequencies and scores
wget https://storage.googleapis.com/covid19-hg-public/pca_projection/hgdp_tgp_pca_covid19hgi_snps_loadings.GRCh37.plink.tsv
wget https://storage.googleapis.com/covid19-hg-public/pca_projection/hgdp_tgp_pca_covid19hgi_snps_loadings.GRCh37.plink.afreq
wget https://storage.googleapis.com/covid19-hg-public/pca_projection/hgdp_tgp_pca_covid19hgi_snps_loadings.GRCh38.plink.tsv
wget https://storage.googleapis.com/covid19-hg-public/pca_projection/hgdp_tgp_pca_covid19hgi_snps_loadings.GRCh38.plink.afreq
wget https://storage.googleapis.com/covid19-hg-public/pca_projection/hgdp_tgp_pca_covid19hgi_snps_loadings.rsid.plink.tsv
wget https://storage.googleapis.com/covid19-hg-public/pca_projection/hgdp_tgp_pca_covid19hgi_snps_loadings.rsid.plink.afreq
wget https://storage.googleapis.com/covid19-hg-public/pca_projection/hgdp_tgp_pca_covid19hgi_snps_scores.txt.gz

# imputed PLINK2 dosage files

cut -f1 [path to the pre-computed loadings file] | tail -n +2 > variants.extract

## .pgen/.pvar/.psam
plink2 \
  --pfile [path to your per-chromosome pfile] \
  --extract variants.extract \
  --make-pfile \
  --out [per-chromosome output name]
ls [the previous per-chromosome output prefix].*.pgen | sed -e ‘s/.pgen//’ > merge-list.txt
plink2 --pmerge-list merge-list.txt --out [all-chromosome output name]

## .bed/.bim/.fam

plink \
  --bfile [path to your per-chromosome pfile] \
  --extract variants.extract \
  --make-bed \
  --out [per-chromosome output name]
ls [outname].*.bed | sed -e ‘s/.bed//’ > merge-list.txt
plink --merge-list merge-list.txt --out [all-chromosome output name]

## .bgen/.sample (in doubt)

bgenix \
  -g [path to your per-chromosome bgen] \
  -incl-rsids variant.extract \
  > [per-chromosome output name].bgen
cat-bgen \
-g [path to your per-chromosome bgen 1] \
   [path to your per-chromosome bgen 2] \
...
   [path to your per-chromosome bgen 22] \
-og [all-chromosome outname]
plink2 \
  --bgen [path to all-chromosome bgen] [REF/ALT mode: see below] \
  --make-pfile \
  --out [output pfile name]

## .vcf

bcftools view -Oz \
  -i “ID = @variants.extract” \
  [path to your per-chromosome vcf file] \
  > [per-chromosome outname>.vcf.gz]
bcftools concat -Oz [per-chromosome vcf files] > [all-chromosome outname].vcf.gz
plink2 \
  --vcf [all-chromosome outname].vcf.gz \
  dosage=[dosage field name: see below] \
  --make-pfile \
  --out [outname]

# project and plot PC

plink2 \
  ${input_command} \
  --score ${PCA_LOADINGS} \
  center \
  cols=-scoreavgs,+scoresums \
  list-variants \
  header-read \
  --score-col-nums 3-22 \
  --read-freq ${PCA_AF} \
  --out ${OUTNAME}

Rscript -e "install.packages(c("data.table", "hexbin", "optparse", "patchwork", "R.utils", "tidyverse"))"
Rscript plot_projected_pc.R \
  --sscore [path to .sscore output] \
  --phenotype-file [path to phenotype file] \
  --phenotype-col [phenotype column name]
  --covariate-file [path to covariate file] \
  --pc-prefix [prefix of PC columns] \
  --pc-num [number of PCs used in GWAS] \
  --ancestry [ancestry code: AFR, AMR, EAS, EUR, MID, or SAS] \
  --study [your study name] \
  --out [output name prefix]

# --ancestry-file [path to ancestry file] \
# --ancestry-col [ancestry column name]
# --reference-score-file
```
