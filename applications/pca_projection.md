---
sort: 49
---

# PCA projection

Official page: [https://github.com/covid19-hg/pca_projection](https://github.com/covid19-hg/pca_projection).

```bash
git clone https://github.com/covid19-hg/pca_projection
cd pca_projection
```

## setup

The required steps according to the documentation can be summarised as follows,

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
  --bgen [path to all-chromosome bgen] [REF/ALT mode] \
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
  dosage=[dosage field name] \
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

## Implementation

Our first application was for the Host Genetics Initiative contribution, which involved SNPid such as chr:pos:ref:alt.

This is detailed below by section.

```bash
#!/usr/bin/bash

export TMPDIR=${HPC_WORK}/work
# genotype
export autosomes=~/rds/post_qc_data/interval/imputed/uk10k_1000g_b37/
# location of PCs
export ref=~/rds/post_qc_data/interval/reference_files/genetic/reference_files_genotyped_imputed/
# HGI working directory
export prefix=~/rds/rds-asb38-ceu-restricted/projects/covid/HGI
export dir=20201201-ANA_C2_V2

export PCA_projection=pca_projection
export PCA_loadings=hgdp_tgp_pca_covid19hgi_snps_loadings.GRCh37.plink.tsv
export PCA_af=hgdp_tgp_pca_covid19hgi_snps_loadings.GRCh37.plink.afreq
export sscore=hgdp_tgp_pca_covid19hgi_snps_scores.txt.gz

module load plink/2.00-alpha ceuadmin/stata

function extract_data()
{
  cut -f1 ${PCA_projection}/${PCA_loadings} | tail -n +2 > variants.extract
  (
    cat variants.extract
    awk '{split($1,a,":");print "chr"a[1]":"a[2]"_"a[4]"_"a[3]}' variants.extract
  ) > variants.extract2

  cp ${prefix}/${dir}/output/INTERVAL-*.bgen.bgi ${TMPDIR}
  seq 22 | \
  parallel -C' ' --env prefix --env dir '
    ln -sf ${prefix}/${dir}/output/INTERVAL-{}.bgen ${TMPDIR}/INTERVAL-{}.bgen
    python update_bgi.py --bgi ${TMPDIR}/INTERVAL-{}.bgen.bgi
    bgenix -g ${TMPDIR}/INTERVAL-{}.bgen -incl-rsids variants.extract2 > ${prefix}/work/INTERVAL-{}.bgen
  '
}

function twist()
{
  cat-bgen -g $(echo ${prefix}/work/INTERVAL-{1..22}.bgen) -og INTERVAL.bgen -clobber
  bgenix -g INTERVAL.bgen -index -clobber
  export csvfile=INTERVAL.csv
  python update_bgi.py --bgi INTERVAL.bgen.bgi
  plink2 --bgen INTERVAL.bgen ref-first --make-pfile --out INTERVAL
  cp INTERVAL.p??? ${prefix}/work
  (
    head -1 INTERVAL.pvar
    paste <(sed '1d' INTERVAL.pvar | cut -f1,2) \
          <(sed '1d' INTERVAL.csv | cut -d, -f3) | \
    paste - <(sed '1d' INTERVAL.pvar | cut -f4,5)
  ) > ${prefix}/work/INTERVAL.pvar
}

function project_pc()
{
#!/bin/bash

  set -eu
################################################################################
# Please fill in the below variables
################################################################################
# Metadata
  STUDY_NAME="INTERVAL"
  ANALYST_LAST_NAME="ZHAO"
  DATE="$(date +'%Y%m%d')"
  OUTNAME="${prefix}/work/${STUDY_NAME}.${ANALYST_LAST_NAME}.${DATE}"
################################################################################
# Location of downloaded input files
  PCA_LOADINGS="${PCA_projection}/${PCA_loadings}"
  PCA_AF="${PCA_projection}/${PCA_af}"
################################################################################
# Location of imputed genotype files
# [Recommended]
# PLINK 2 binary format: a prefix (with directories) of .pgen/.pvar/.psam files
  PFILE="${prefix}/work/INTERVAL"
# [Acceptable]
# PLINK 1 binary format: a prefix of .bed/.bim/.fam files
  BFILE=""
################################################################################

  function error_exit() {
    echo "${1:-"Unknown Error"}" 1>&2
    exit 1
  }

# Input checks
  if [[ -z "${STUDY_NAME}" ]]; then
    error_exit "Please specify \$STUDY_NAME."
  fi

  if [[ -z "${ANALYST_LAST_NAME}" ]]; then
    error_exit "Please specify \$ANALYST_LAST_NAME."
  fi

  if [[ -z "${PCA_LOADINGS}" ]]; then
    error_exit "Please specify \$PCA_LOADINGS."
  fi

  if [[ -z "${PCA_AF}" ]]; then
    error_exit "Please specify \$PCA_AF."
  fi

  if [[ -n "${PFILE}" ]]; then
    input_command="--pfile ${PFILE}"
  elif [[ -n "${BFILE}" ]]; then
    input_command="--bfile ${BFILE}"
  else
    error_exit "Either \$PFILE or \$BFILE should be specified"
  fi

# Run plink2 --score
  plink2 \
    ${input_command} \
    --score ${PCA_LOADINGS} \
            variance-standardize \
            cols=-scoreavgs,+scoresums \
            list-variants \
            header-read \
    --score-col-nums 3-12 \
    --read-freq ${PCA_AF} \
    --out ${OUTNAME}

# The score file does not have FID (=0)
  awk '
  {
    if (NR==1) $1="#FID IID"
    else $1=0" "$1
    print
  }' ${OUTNAME}.sscore > ${prefix}/work/snpid.sscore
  ln -sf ${OUTNAME}.sscore.vars ${prefix}/work/snpid.sscore.vars

# Our PCs are PC_# rather than PC#
# The phenotype and covariate file missed FID (=0) column
  awk '
  {
    if (NR==1)
    {
      $1="FID I"$1
      gsub(/PC_/,"PC",$0)
    }
    else $1=0" " $1
  };1' ${dir}/work/INTERVAL-covid.txt | \
  tr ' ' '\t' > ${prefix}/work/snpid.txt
  cut -f1-3 ${prefix}/work/snpid.txt > ${prefix}/work/snpid.pheno
  cut -f3 --complement ${prefix}/work/snpid.txt > ${prefix}/work/snpid.covars

  stata -b do ethnic.do

  Rscript ${PCA_projection}/plot_projected_pc.R \
        --sscore ${prefix}/work/snpid.sscore \
        --phenotype-file ${prefix}/work/snpid.pheno \
        --phenotype-col SARS_CoV \
        --covariate-file ${prefix}/work/snpid.covars \
        --pc-prefix PC \
        --pc-num 20 \
        --ancestry-file ethnic.txt \
        --ancestry-col ethnic \
        --study ${STUDY_NAME} \
        --out ${OUTNAME}
}

extract_data;twist;project_pc
```

### update_bgi.py

The magic `update_bgi.py` is as follows

```python
import argparse
import os
import pandas as pd
import sqlite3

# mapping chromosome string (incluing 01-09, 23, and X) and correct string
CHROM_MAPPING_STR = dict([(str(i), str(i)) for i in range(1, 23)] + [('0' + str(i), str(i)) for i in range(1, 10)] +
                         [('X', 'X')])
csvfile=os.environ['csvfile']

def main(args):
    conn = sqlite3.connect(args.bgi)
    c = conn.cursor()
    df = pd.read_sql("select * from Variant", conn)
    print(df,flush=True)
    df.rsid = df.apply(lambda x: "{}:{}:{}:{}".format(CHROM_MAPPING_STR[x[0]], x[1], x[4], x[5]), axis=1)
    print(df,flush=True)
    df.to_sql("Variant", conn, if_exists="replace", index=False)
    if csvfile != '':
       df.to_csv(csvfile,index=False)
    conn.close()

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--bgi', type=str, required=True)
    args = parser.parse_args()
    main(args)
```

### bgi.sql

One may wonder the information regarding `.bgen.bgi` at all, which can be viewed as follows,

```bash
sqlite3 INTERVAL.bgen.bgi < bgi.sql
```

while `bgi.sql` has the following lines

```sqlite3
.tables
.separator "\t"
.header on
.output metadata.txt
select * from metadata;
.output Variant.txt
select * from Variant;
```

### ethnic.do

The Stata program generates files containing FID, IID and ethnicity

```stata
gzuse work/INTERVAL-omics-covid.dta.gz
sort identifier
gzsave INTERVAL-omics-covid, replace
insheet using 20201201/INTERVALdata_01DEC2020.csv, case clear
sort identifier
gzmerge identifier using INTERVAL-omics-covid.dta.gz
tabulate ethnicPulse SARS_CoV, all
gen str20 ethnic=ethnicPulse
replace ethnic="EUR" if inlist(ethnicPulse,"Eng/W/Scot/NI/Brit","White Irish")==1
replace ethnic="EAS" if inlist(ethnicPulse,"Asian- Bangladeshi","Asian- Indian","Asian- Pakistani","Chinese")==1
replace ethnic="MID" if ethnicPulse=="Arab"
gen ethnic_NA=ethnic
replace ethnic_NA="NA" if inlist(ethnic,"EUR","EAS","MID")==0
tab ethnic SARS_CoV, all
tab ethnic_NA SARS_CoV, all
gen FID=0
rename ID IID
outsheet FID IID ethnic using ethnic.txt if IID!=., noquote replace
outsheet FID IID ethnic_NA using ethnic_NA.txt if IID!=., noquote replace
rm INTERVAL-omics-covid.dta.gz
```

Our second application was the Caprion pilot analysis, which was simplified through use of RSid.

```bash
#!/usr/bin/bash

export autosomes=~/rds/post_qc_data/interval/imputed/uk10k_1000g_b37/
export ref=~/rds/post_qc_data/interval/reference_files/genetic/reference_files_genotyped_imputed/
export caprion=${HOME}/Caprion/pilot
export TMPDIR=${HPC_WORK}/work
export work=${caprion}/work
export HGI=~/COVID-19/HGI
export PCA_projection=${HGI}/pca_projection
export PCA_loadings=${PCA_projection}/hgdp_tgp_pca_covid19hgi_snps_loadings.rsid.plink.tsv
export PCA_af=${PCA_projection}/hgdp_tgp_pca_covid19hgi_snps_loadings.rsid.plink.afreq
export sscore=${PCA_projection}/hgdp_tgp_pca_covid19hgi_snps_scores.txt.gz

module load plink/2.00-alpha ceuadmin/stata

cut -f1 ${PCA_loadings} | tail -n +2 > ${work}/variants.extract

function pca_project()
# PCA projection
{
export dir=${1}
export phase=${2}
bgenix -g ${caprion}/${dir}/caprion.01.bgen -incl-rsids ${work}/variants.extract > ${work}/${phase}.bgen
bgenix -g ${work}/${phase}.bgen -index -clobber

sqlite3 ${work}/${phase}.bgen.bgi <<END
.tables
.separator "\t"
.header on
.output ${work}/metadata.txt
select * from metadata;
.output ${work}/Variant.txt
select * from Variant;
END

plink2 --bgen ${work}/${phase}.bgen ref-first --make-pfile --out ${work}/${phase}

set -eu

plink2 \
    --pfile ${work}/${phase} \
    --score ${PCA_loadings} \
            variance-standardize \
            cols=-scoreavgs,+scoresums \
            list-variants \
            header-read \
    --score-col-nums 3-12 \
    --read-freq ${PCA_af} \
    --out ${work}/${phase}

awk '
  {
    if (NR==1) $1="#FID IID"
    else $1=0" "$1
    print
  }' ${work}/${phase}.sscore > ${work}/${phase}-rsid.sscore
ln -sf ${work}/${phase}.sscore.vars ${work}/${phase}-rsid.sscore.vars

cat <(echo FID IID dummy | tr ' ' '\t') \
    <(sed '1d' ${work}/${phase}.psam | awk -v OFS='\t' '{print 0,$1,0}') > ${work}/${phase}-rsid.pheno

export ethnic_file=${HGI}/ethnic.txt
cat <(head -1  ${ethnic_file}) \
    <(cut -f1 ${work}/${phase}.psam | grep -f - ${ethnic_file}) > ${work}/${phase}-ethnic.txt
export covar_file=${HGI}/work/snpid.covars
cat <(head -1  ${covar_file}) \
    <(cut -f1 ${work}/${phase}.psam | grep -f - ${covar_file}) > ${work}/${phase}-covars.txt

Rscript ${PCA_projection}/plot_projected_pc.R \
        --sscore ${work}/${phase}-rsid.sscore \
        --phenotype-file ${work}/${phase}-rsid.pheno \
        --phenotype-col dummy \
        --covariate-file ${work}/${phase}-covars.txt \
        --pc-prefix PC \
        --pc-num 20 \
        --ancestry-file ${work}/${phase}-ethnic.txt \
        --ancestry-col ethnic \
        --study phase1 \
        --out ${work}/${phase}
}

pca_project data phase1
pca_project data2 phase2
pca_project data3 phase3
```
