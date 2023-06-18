---
sort: 2
---

# GWAS Catalog

Web: <https://www.ebi.ac.uk/gwas/deposition> ([doc](https://www.ebi.ac.uk/gwas/docs/submission), [email](gwas-subs@ebi.ac.uk), [GitHub](https://github.com/EBISPOT/gwas-sumstats-tools), [submission form](https://www.ebi.ac.uk/gwas/docs/submission-summary-statistics-plus-metadata))

European Life Science Research Infrastructure Login, Contact: <support@aai.lifescience-ri.eu>, Homepage: <https://lifescience-ri.eu/ls-login/>

Like the entry for DNAnexus here, we documented a collection of software related to data submission to the GWAS Catalog.

## gwas-sumstats-tools

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

## Globus

Web: <https://www.globus.org/globus-connect-personal> ([CLI](https://docs.globus.org/cli/))

```bash
wget -qO- https://downloads.globus.org/globus-connect-personal/linux/stable/globusconnectpersonal-latest.tgz | \
tar xvfz -
cd globusconnectpersonal-3.2.2
# ./globusconnectpersonal
./globusconnectpersonal -setup --no-gui
# CLI
module load ceuadmin/snakemake
pip3 install globus-cli
globus list-commands
globus login
globus whoami
globus session show
globus transfer --help
globus logout

```

We carry on building a module so it is enabled with `module load ceuadmin/globusconnectpersonal/3.2.2` and could simply run `globusconnect` as well as  `globus`.

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
Rscript -e '
  suppressMessages(library(dplyr))
  pgwas <- read.delim("stdin") %>%
           mutate(p_value=gap::pvalue(beta/standard_error))
  write.table(pgwas,quote=FALSE,row.names=FALSE,sep="\t")
' | \
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

Note that to comply with the (somewhat unreasonable) requirement, indels are dropped. Moreover, a number of proteins including CCL25, CD6, CXCL6, FGF.5,  IL.12B, IL.18R1 and TNFB have p_value=0 so their specifical handling with R is introduced as a generic solution.
We could obtain the meta-data as required in the submission form,

```bash
cd ${dst}
md5sum *gz* > MD5
ls *gz | sed 's/.tsv.gz//' | \
parallel -j10 -C' ' '
  cat <(echo {}) \
      <(gunzip -c {}.tsv.gz | wc -l | cut -d" " -f1) \
      <(grep -w {}.tsv.gz$ MD5 | sed "s/  /\t/") | \
  tr "\n" "\t"
  gunzip -c {}.tsv.gz | sed "1d" | cut -f10 | sort -k1,1nr | head -1
' | \
sort -k1,1 > meta.tsv
cd -
```

which include protein name, number of variants, md5, file name and sample size.

The login information is visible from <https://www.ebi.ac.uk/gwas/deposition/login> for the following steps,

> 1. Upload summary statistics file(s) to ***your Globus submission folder***
> 2. Download submission form
> 3. Fill in submission form (see ***here*** for help)
> 4. Wait to receive an email confirmation from Globus that all summary statistics files have successfully been transferred
> 5. Submit submission form

> To remove the current submission form, click "Reset". Use "Review submission" to download the current submission form.
