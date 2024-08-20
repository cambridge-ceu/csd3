---
sort: 6
---

# bcftools

Web: [http://www.htslib.org/download/](http://www.htslib.org/download/)

## 1.20

Several plugins are now available, see <https://github.com/freeseek/score>. Information on linkage disequilibrium graphical models (LDGM) is here, <https://ldgm.readthedocs.io/en/latest/introduction.html>.

```bash
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
```

The setup of `bcftools +liftover` is detailed here,

```bash
module load bwa
module load ceuadmin/samtools
export public_databases=/rds/project/rds-4o5vpvAowP0
export TMPDIR=/rds/user/jhz22/work
cd dbsnp
wget -O- ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz | \
gzip -d > GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
samtools faidx GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
# done via SLURM shown below
bwa index GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/cytoBand.txt.gz
wget http://hgdownload.cse.ucsc.edu/goldenpath/hg18/liftOver/hg18ToHg38.over.chain.gz
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
bwa index GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
```

We are now ready for liftover -- for a normalized VCF only including bi-allelic variants, form indels using 'bcftools norm -m+' followed by liftover

```bash
module load ceuadmin/bcftools/1.20
bcftools --version
bcftools +score
bcftools +munge
bcftools +liftover
bcftools +pgs
bcftools +blup
bcftools norm --no-version -Ou -m+ 1kGP_high_coverage_Illumina.sites.vcf.gz | \
bcftools +liftover --no-version -Ou -- \
  -c $public_databases/dbsnp/hg38ToHs1.over.chain.gz \
  -f hs1.fa \
  -s $public_databases/dbsnp/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna \
bcftools sort -o 1kGP_high_coverage_Illumina.sites.hs1.bcf -Ob --write-index
```

in a named file such as `bwa.sb` and executed with `sbatch bwa.sb`.

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
