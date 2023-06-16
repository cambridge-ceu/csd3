---
sort: 2
---

# gwas-sumstats-tools

Web: <https://www.ebi.ac.uk/gwas/deposition> ([doc](https://www.ebi.ac.uk/gwas/docs/submission), [email](gwas-subs@ebi.ac.uk), [GitHub](https://github.com/EBISPOT/gwas-sumstats-tools))

Life Science Login, Contact: <support@aai.lifescience-ri.eu>, Homepage: https://lifescience-ri.eu/ls-login/

## Installation

```bash
module load ceuadmin/snakemake
pip3 install gwas-sumstats-tools
```

where to save space we borrow the setup for snakemake, whose Python 3.11.0 also satisfies the requirement of at least 3.9.0.

## Usage

This is described pragmatically as follows.

```bash
gwas-ssf --help
```

## Application: SCALLOP-INF sumstats submission

Web: <https://jinghuazhao.github.io/INF/>

### Reformatting and indexing

```bash
#!/usr/bin/bash

#SBATCH --job-name=_gwas_catalog
#SBATCH --mem=28800
#SBATCH --time=12:00:00

#SBATCH --account CARDIO-SL0-CPU
#SBATCH --partition cardio
#SBATCH --qos=cardio

#SBATCH --export ALL
#SBATCH --array=1-91
#SBATCH --output=_%A_%a.o
#SBATCH --error=_%A_%a.e

. /etc/profile.d/modules.sh
module purge
module load rhel7/default-peta4
module load ceuadmin/snakemake

export src=/rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/INF/METAL
export dst=~/rds/results/public/proteomics/scallop-inf1

if [ ! -f "${dst}/proteins.lst" ]; then
   ls ${src}/*gz | grep -v BDNF | xargs -l -I {} basename {} -1.tbl.gz | sed 's/-/\t/'| cut -f1 > ${dst}/proteins.lst
fi

export protein=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]' ${dst}/proteins.lst)

(
  echo chromosome base_pair_location effect_allele other_allele beta standard_error effect_allele_frequency p_value variant_id n
  zcat ${src}/${protein}-1.tbl.gz | \
  awk '
    {
      gsub(/chr/,"",$3)
      gsub(/:/,"_",$3)
      $4=toupper($4)
      $5=toupper($5)
      if (NR>1 && length($4)==1 && length($5)==1) print $1,$2,$4,$5,$10,$11,$6,10^$12,$3,int($18)
    }' | \
  sort -k1,1n -k2,2n
) | \
tr ' ' '\t' | \
bgzip -f > ${dst}/${protein}.tsv.gz
tabix -S1 -s1 -b2 -e2 -f ${dst}/${protein}.tsv.gz
gwas-ssf read ${dst}/${protein}.tsv.gz
gwas-ssf validate ${dst}/${protein}.tsv.gz

# export src=~/rds/results/private/proteomics/scallop-inf1
#1 Chromosome
#2 Position
#3 MarkerName
#4 Allele1
#5 Allele2
#6 Freq1
#7 FreqSE
#8 MinFreq
#9 MaxFreq
#10 Effect
#11 StdErr
#12 log(P)
#13 Direction
#14 HetISq
#15 HetChiSq
#16 HetDf
#17 logHetP
#18 N
```

These are followed by `md5sum ${dst}/*gz* > ${dst}/MD5`. Note that to comply with the (somewhat unreasonable) requirement, indels are dropped.

## Globus Connect Personal

Web: <https://www.globus.org/globus-connect-personal>

```bash
wget -qO- https://downloads.globus.org/globus-connect-personal/linux/stable/globusconnectpersonal-latest.tgz | \
tar xvfz -
cd globusconnectpersonal-3.2.2
# ./globusconnectpersonal
./globusconnectpersonal -setup --no-gui
```

We carry on building a module so it is enabled with `module load ceuadmin/globusconnectpersonal/3.2.2`.
