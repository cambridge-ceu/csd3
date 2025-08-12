---
sort: 3
---

# GWAS Catalog

Web: <https://www.ebi.ac.uk/gwas/deposition> ([doc](https://www.ebi.ac.uk/gwas/docs/submission), [email](mailto:gwas-subs@ebi.ac.uk), [format](https://www.ebi.ac.uk/gwas/docs/summary-statistics-format))

European Life Science Research Infrastructure Login, Contact: <support@aai.lifescience-ri.eu>, Homepage: <https://lifescience-ri.eu/ls-login/>

Like the entry for DNAnexus which is associated with a range of tools for UKBiobank analysis and uses available setup, the collection of software relate to data submission to the GWAS Catalog and involve `ceuadmin/snakemake`

```bash
module load ceuadmin/snakemake
```

to save space.

## I. gwas-sumstats-tools

GitHub: <https://github.com/EBISPOT/gwas-sumstats-tools>

### Installation

```bash
pip3 install gwas-sumstats-tools
```

where we borrow the setup for `snakemake` associated with Python 3.11.0 that satisfies the requirement (>=3.9.0).

### Usage

This is described pragmatically as follows.

```bash
gwas-ssf --help
```

## II. Globus

Web: <https://www.globus.org/globus-connect-personal> ([CLI](https://docs.globus.org/cli/))

```bash
wget -qO- https://downloads.globus.org/globus-connect-personal/linux/stable/globusconnectpersonal-latest.tgz | \
tar xvfz -
cd globusconnectpersonal-3.2.2
# ./globusconnectpersonal
./globusconnectpersonal -setup --no-gui
# CLI
pip3 install globus-cli
globus list-commands
globus login
globus whoami
globus session show
globus transfer --help
globus logout

```

where we again use the setup for `snakemake`.

We carry on building a module so it is enabled with `module load ceuadmin/globusconnectpersonal/3.2.2` and could simply run `globusconnect` as well as `globus`.

It is desirable to use a web browser, whose close counterpart on CSD3 is from the `ceuadmin/Cytoscape/3.9.1` module.

## III. Application: SCALLOP-INF sumstats submission

Web: <https://jinghuazhao.github.io/INF/>

### Reformatting and indexing

The documented example[^reference] is shown here,

chromosome|base_pair_location|effect_allele|other_allele|beta|standard_error|effect_allele_frequency|p_value|variant_id|rsid
1|869388|A|G|-0.016619|0.00806496|0.997221|0.1|1_869388_A_G|NA
1|205811055|C|T|-0.0089589|0.00331941|0.983589|9.7E-03|1_205811055_C_T|rs74143854
2|70478797|T|TG|0.0187528|0.00167685|0.934121|3.5E-30|2_70478797_T_TG|rs142640435
2|27875036|TAAA|T|-0.0184003|0.00101051|0.78451|5.7E-76|2_27875036_TAAA_T|rs774624803
23|24145170|A|G|0.00387762|0.08757958|0.627178|2.3E-08|23_24145170_A_G|rs5949232

We have a SLURM script,

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
  echo chromosome base_pair_location effect_allele other_allele beta standard_error effect_allele_frequency p_value variant_id rsid n
  zcat ${src}/${protein}-1.tbl.gz | \
  sed '1d' | \
  cut -f1-6,10-12,18 | \
  sort -k3,3 | \
  join - -13 -21 ${INF}/work/INTERVAL.rsid | \
  awk '
    {
      $4=toupper($4)
      $5=toupper($5)
      $1=$2"_"$3"_"$4"_"$5
      if(substr($11,1,2)!="rs") $11="NA"
      print $2,$3,$4,$5,$7,$8,$6,10^$9,$1,$11,int($10)
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
gwas-ssf validate -e ${dst}/${protein}.tsv.gz

# gunzip -c  $src/4E.BP1-1.tbl.gz  | head -1 | tr '\t' '\n' | awk '{print "#"NR, $1}'
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
# head -2 ~/INF/work/INTERVAL.rsid
# chr10:100000051_A_G rs141059932
# chr10:100000056_C_G 10:100000056_C_G
```

A number of proteins including CCL25, CD6, CXCL6, FGF.5, IL.12B, IL.18R1 and TNFB have p_value=0 so their specifical handling with R is introduced as a generic solution.
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
  gunzip -c {}.tsv.gz | sed "1d" | cut -f11 | sort -k1,1nr | head -1
' | \
sort -k1,1 > meta.tsv
cd -
```

which include protein name, number of variants, md5, file name and sample size.

A post-hoc remapping of protein target names to gene symbols can be achieved as follows,

```bash
Rscript -e '
  suppressMessages(library(dplyr))
  ids <- pQTLdata::inf1 %>%
         filter(gene!="BDNF") %>%
         select(prot,target.short,gene)
  write.table(ids,col.names=FALSE,row.names=FALSE,quote=FALSE,sep="\t")
' | \
sort -k1,1 | \
join -t$'\t' <(ls ${dst} | grep -v tbi | sed 's/.tsv.gz//' | sort -k1,1) - > prot_target_gene.tsv
```

We are ready to proceed from <https://www.ebi.ac.uk/gwas/deposition> with globus running and a LS RI profile
(e.g., [globus file manager](https://app.globus.org/file-manager?origin_id=c5ed8ca7-45e2-4628-9393-b9349203d759&origin_path=%2F), [LS RI profile](https://profile.aai.lifescience-ri.eu/profile/identities)). The submission page shows these steps,

> 1. Upload summary statistics file(s) to **_your Globus submission folder_**
> 2. Download submission form
> 3. Fill in submission form (see [**_here_**](https://www.ebi.ac.uk/gwas/docs/submission-summary-statistics-plus-metadata) for help)
> 4. Wait to receive an email confirmation from Globus that all summary statistics files have successfully been transferred
> 5. Submit submission form

> To remove the current submission form, click "Reset". Use "Review submission" to download the current submission form.

Upon successes, email notifications are given along with study accessions. It is possible to revisit the page via <https://www.ebi.ac.uk/gwas/deposition/login>.

[^reference]: Hayhurst, J. et al. A community driven GWAS summary statistics standard. bioRxiv, 2022.2007.2015.500230 (2022).
