---
sort: 6
---

# bcftools

Web: [http://www.htslib.org/download/](http://www.htslib.org/download/)

## 1.20

Several plugins are now available, see <https://github.com/freeseek/score>.

```bash
if [ ! -d $CEUADMIN/bcftools/1.20 ]; then mkdir -p $CEUADMIN/bcftools/1.20; fi
cd $CEUADMIN/bcftools/1.20
wget -qO- https://github.com/samtools/htslib/archive/refs/tags/1.20.tar.gz | \
tar xfz -
export PERL5LIB=
cd htslib-1.20/
autoreconf -i
configure --prefix=$CEUADMIN/bcftools/1.20
make
make install
cd -
wget https://github.com/samtools/bcftools/releases/download/1.20/bcftools-1.20.tar.bz2 | \
tar xjf -
cd bcftools-1.20/
configure --prefix=$CEUADMIN/bcftools/1.20
make
make install
cd -
wget -P bin https://raw.githubusercontent.com/freeseek/score/master/assoc_plot.R
chmod a+x bin/assoc_plot.R
mkdir score && cd score
wget https://software.broadinstitute.org/software/score/score_1.20-20240505.zip
```

The setup of `bcftools +liftover` is detailed here,

```bash
module load bwa
module load ceuadmin/samtools
export public_databases=/rds/project/rds-4o5vpvAowP0
export TMPDIR=/rds/user/jhz22/work

# GRCh37 human genome reference, cytoband and chain file
cd $public_databases/GRCh37_reference_fasta
wget https://hgdownload.cse.ucsc.edu/goldenPath/hs1/bigZips/hs1.fa.gz
gunzip hs1.fa.gz
cd $public_databases/dbsnp
wget -O- ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz | \
gzip -d > human_g1k_v37.fasta
samtools faidx human_g1k_v37.fasta
bwa index human_g1k_v37.fasta
wget -P hg19 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/cytoBand.txt.gz
wget http://hgdownload.cse.ucsc.edu/goldenpath/hg18/liftOver/hg18ToHg19.over.chain.gz

# GRCh38 human genome reference, cytoband and chain files
export url=ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids
wget -O- $url/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz | \
gzip -d > GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
samtools faidx GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
bwa index GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
wget -P hg38 http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/cytoBand.txt.gz
wget http://hgdownload.cse.ucsc.edu/goldenpath/hg18/liftOver/hg18ToHg38.over.chain.gz
wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/liftOver/hg19ToHg38.over.chain.gz
wget http://ftp.ensembl.org/pub/assembly_mapping/homo_sapiens/GRCh37_to_GRCh38.chain.gz
wget https://hgdownload.cse.ucsc.edu/gbdb/hg38/liftOver/hg38ToHs1.over.chain.gz
wget https://hgdownload.cse.ucsc.edu/goldenPath/hs1/liftOver/hs1ToHg38.over.chain.gz

module load ceuadmin/bcftools/1.20
bcftools plugin --list
bcftools --version
bcftools +score
bcftools +munge
bcftools +liftover
bcftools +pgs
bcftools +blup
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5c.20130502.sites.vcf.gz
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5c.20130502.sites.vcf.gz.tbi
bcftools +liftover --no-version \
 -Ou $public_databases/dbsnp/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5c.20130502.sites.vcf.gz -- \
  -s $public_databases/GRCh37_reference_fasta//human_g1k_v37.fasta \
  -f $public_databases/dbsnp/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna \
  -c $public_databases/dbsnp/hg18ToHg38.over.chain.gz \
  --reject ALL.wgs.phase3_shapeit2_mvncall_integrated_v5c.20130502.sites.reject.bcf \
  --reject-type b \
  --write-src | \
bcftools sort -o ALL.wgs.phase3_shapeit2_mvncall_integrated_v5c.20130502.sites.hg38.bcf -Ob --write-index
cd -
```

The `bwa` will be killed from an interactive session, so needs to be replaced,

```bash
#!/bin/bash

#SBATCH --job-name=_bwa
#SBATCH --account=PETERS-SL3-CPU
#SBATCH --partition=icelake-himem
#SBATCH --mem=28800
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=4
#SBATCH --output=bwa.o
#SBATCH --error=bwa.e

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl

export TMPDIR=${HPC_WORK}/work

module load bwa
bwa index human_g1k_v37.fasta
bwa index GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
```

in a named file such as `bwa.sb` and executed with `sbatch bwa.sb`.

### An example

This is according to `ensembl-vep/examples`,

```bash
#!/usr/bin/bash

module load ceuadmin/bcftools/1.20

export public_databases=/rds/project/rds-4o5vpvAowP0
cp -p $public_databases/ensembl-vep/examples/homo_sapiens_GRCh3?.vcf .

# GRCh37
sed  -i '1!s/^21/chr21/' homo_sapiens_GRCh37.vcf
sed  -i '1!s/^22/chr22/' homo_sapiens_GRCh37.vcf
bgzip homo_sapiens_GRCh37.vcf
tabix -S1 -s1 -b2 -e2 homo_sapiens_GRCh37.vcf.gz
# GRCh38
sed  -i '1!s/^21/chr21/' homo_sapiens_GRCh38.vcf
sed  -i '1!s/^22/chr22/' homo_sapiens_GRCh38.vcf
bgzip homo_sapiens_GRCh38.vcf
tabix -S1 -s1 -b2 -e2 homo_sapiens_GRCh38.vcf.gz

bcftools norm --no-version -Ou -m+ homo_sapiens_GRCh37.vcf.gz | \
bcftools +liftover --no-version -Ou -- \
  -s $public_databases/dbsnp/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna \
  -f $public_databases/GRCh37_reference_fasta/hs1.fa \
  -c $public_databases/dbsnp/hg19ToHg38.over.chain.gz | \
bcftools sort -o homo_sapiens_GRCh38.hs1.bcf -Ob --write-index
sdiff -s <(bcftools query --format "%CHROM\t%POS\n" homo_sapiens_GRCh38.hs1.bcf -r chr21) \
         <(bcftools query --format "%CHROM\t%POS\n" homo_sapiens_GRCh38.vcf.gz -r chr21)
```

where there are two notable aspects:

- We first change chromosome names from 21. 22 to chr21, chr22. The bcftools liftover plugin generates a .bcf file which is used to contrast with the provided example; since the two files all have the same coordinates we don't see any output.
- `bcftools norm -m+` would rebuild indels should they be split into SNVs, which could also be done again to split into bi-allelic variants.

Finally, some notes on coupling are kept here (for compiling from source but not used here),

```bash
wget -P bcftools-1.20 https://raw.githubusercontent.com/DrTimothyAldenDavis/SuiteSparse/stable/{SuiteSparse_config/SuiteSparse_config,CHOLMOD/Include/cholmod}.h
/bin/rm -f plugins/{score.{c,h},{munge,liftover,metal,blup}.c,pgs.{c,mk}}
wget -P plugins https://raw.githubusercontent.com/freeseek/score/master/{score.{c,h},{munge,liftover,metal,blup}.c,pgs.{c,mk}}
make
# /bin/cp bcftools plugins/{munge,liftover,score,metal,pgs,blup}.so ../bin
```

## 1.12

On CSD3, `module avail bcftools` gives a list of versions but none can query data from the web.

However, the installation is straightforward.

```bash
wget -qO- https://github.com/samtools/bcftools/releases/download/1.12/bcftools-1.12.tar.bz2 | \
tar xjf -
cd bcftools-1.12/
./configure --prefix=${HPC_WORK}
make
make install
bcftools --version
```

According to documentation, the configuration could slightly be more complicated with

```bash
export BCFTOOLS_PLUGINS=${HPC_WORK}/bcftools-1.12/plugins
autoheader && autoconf && ./configure --enable-libgsl --enable-perl-filters --prefix=/usr/local/Cluster-Apps/ceuadmin/bcftools/1.12
make
make install
```

The data query example as in `tabix` is quoted here.

```bash
bcftools query -f '%ID\t%ALT\t%REF\t%AF\t[%ES]\t[%SE]\t[%LP]\t[%SS]\t%CHROM\t%POS\n' -r 1:1-1000000 \
               https://gwas.mrcieu.ac.uk/files/ebi-a-GCST010776/ebi-a-GCST010776.vcf.gz
```

A number of other options can be used together with -r or -R.

We can also obtain data with the header (-H)

```bash
export f=ebi-a-GCST010776
bcftools query -f '%ID\t%ALT\t%REF\t%AF\t[%ES]\t[%SE]\t[%LP]\t[%SS]\t%CHROM\t%POS\n' \
               -H \
               -r 1:1-1000000 \
               https://gwas.mrcieu.ac.uk/files/${f}/${f}.vcf.gz | \
               sed "s/\[[0-9]*\]//g;s/^[\#] //;s/${f}://g" > chr1:1-1000000.dat
```
