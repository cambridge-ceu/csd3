---
sort: 71
---

# tabix

Web: [https://github.com/samtools/htslib](https://github.com/samtools/htslib).

Their availability on CSD3 can be seen with

```bash
module avail tabix
module avail htslib
```

Its utility to extract data has only been realised recently

```bash
tabix ftp://ftp.ebi.ac.uk/pub/databases/spot/eQTL/csv/BLUEPRINT/ge/BLUEPRINT_ge_monocyte.all.tsv.gz 20:46120612-46120613
tabix https://gwas.mrcieu.ac.uk/files/ebi-a-GCST010776/ebi-a-GCST010776.vcf.gz 1:1-1000000
```

with earlier versions possibly giving error messages; we install the latest,

```bash
module load gcc/6
wget -qO- https://github.com/samtools/htslib/releases/download/1.12/htslib-1.12.tar.bz2 | \
tar -vxjf -
cd htslib-1.12/
autoreconf -i
./configure --enable-libcurl --prefix=${HPC_WORK}
make
make install
```

One could obtain a list of outcomes as follows,

```bash
Rscript -e "write.table(TwoSampleMR::available_outcomes(),file='ao.txt',quote=FALSE,row.names=FALSE,sep='\t')"
```

**NOTE**

It also works with VCF files, e.g.,

```bash
tabix -p vcf TSLP.vcf.gz -h 1:100-100000
```

where the `-h` option is used to preserve the header information.

See specific section on bcftools for additional information.

`bcftools query` works similarly on a local VCF file nevertheless the option `-r` is necessary.

```bash
bcftools query -f '%ID\t%ALT\t%REF\t%AF\t[%ES]\t[%SE]\t[%LP]\t[%SS]\t%CHROM\t%POS\n' -r 1:1-1000000 \
               https://gwas.mrcieu.ac.uk/files/ebi-a-GCST010776/ebi-a-GCST010776.vcf.gz
```

The rather perplexing syntax (cut and paste from here in which case) gains its appeal for an output in a well-defined format.

## Applications: Heart-KP

### Web

<http://heartkp.org/>

### Zenodo

```bash
#!/usr/bin/bash

wget https://zenodo.org/record/7239166/files/Bai82_names_ukb_v2.csv
seq 1 82 | \
parallel -j10 -C' ' '
  echo {}
  wget -qO- https://zenodo.org/record/7239166/files/ukbiobank_heart_pheno{}_may2022.zip | \
  gunzip -c | bgzip -f  > ukbiobank_heart_pheno{}_may2022.gz
  tabix -f -S1 -s1 -b3 -e3 ukbiobank_heart_pheno{}_may2022.gz
'
```

### Reference

Zhao, B., T. Li, Z. Fan, Y. Yang, J. Shu, X. Yang, X. Wang, T. Luo, J. Tang, D. Xiong, Z. Wu, B. Li, J. Chen, Y. Shan, C. Tomlinson, Z. Zhu, Y. Li, J. L. Stein and H. Zhu "Heart-brain connections: Phenotypic and genetic insights from magnetic resonance images." Science 380(6648): abn6598.
<https://doi.org/10.1126/science.abn6598>
