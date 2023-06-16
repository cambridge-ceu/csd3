---
sort: 2
---

# gwas-sumstats-tools

Web: <https://www.ebi.ac.uk/gwas/deposition> ([email](gwas-subs@ebi.ac.uk),[GitHub](https://github.com/EBISPOT/gwas-sumstats-tools))

## Command-line tool

### Installation

```bash
module load ceuadmin/snakemake
pip3 install gwas-sumstats-tools
```

where to save space we borrow the setup for snakemake, whose Python 3.11.0 also satisfies the requirement of at least 3.9.0.

### Usage

This is described pragmatically as follows.

```bash
gwas-ssf --help
```

## Application to SCALLOP-INF sumstats submission

* Project page, <https://jinghuazhao.github.io/INF/>

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

export src=~/rds/results/private/proteomics/scallop-inf1
export dst=~/rds/results/public/proteomics/scallop-inf1

if [ ! -f "${dst}/files.lst" ]; then
   ls ${src}/*gz | xargs -l -I {} basename {} -1.tbl.gz | sed 's/-/\t/'| cut -f1 > ${dst}/files.lst
fi

export protein=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]' "${dst}/files.lst")

(
  echo chromosome base_pair_location effect_allele other_allele beta standard_error effect_allele_frequency p_value variant_id n
  zcat ${src}/${protein}-1.tbl.gz | \
  awk -v chr=${chr} '
    NR>1 && $1==chr
    {
      gsub(/chr/,"",$3)
      print $1,$2,$4,$5,$10,$11,-$12,$6,$3,$18
    }' | \
  sort -k1,1n -k2,2n
) | \
tr ' ' '\t' | \
bgzip -f > "${dst}/${protein}.gz"
tabix -S1 -s1 -b2 -e2 -f "${dst}/${protein}.gz"
```

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

md5sum ${dst}/* > ${dst} >> ${dst}/README.md
