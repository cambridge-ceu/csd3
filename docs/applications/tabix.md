---
sort: 53
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

See specific section on bcftools for additional information.

`bcftools query` works similarly on a local VCF file nevertheless the option `-r` is necessary.

```bash
bcftools query -f '%ID\t%ALT\t%REF\t%AF\t[%ES]\t[%SE]\t[%LP]\t[%SS]\t%CHROM\t%POS\n' -r 1:1-1000000 \
               https://gwas.mrcieu.ac.uk/files/ebi-a-GCST010776/ebi-a-GCST010776.vcf.gz
```

The rather perplexing syntax (cut and paste from here in which case) gains its appeal for an output in a well-defined format.
