---
sort: 34
layout: default
---

# haplogrep

Web: <https://haplogrep.i-med.ac.at/> ([haplogrep2](https://haplogrep.i-med.ac.at/haplogrep2/index.html)) & <https://haplogrep.readthedocs.io/en/latest/>

## 3.2.2

### Installation

```bash
# haplogrep3
wget https://github.com/genepi/haplogrep3/releases/download/v3.2.2/haplogrep3-3.2.2-linux.zip
unzip haplogrep3-3.2.2-linux.zip
haplogrep3 server --config haplogrep3.yaml
```

### Haplogrep trees

Web: <https://genepi.github.io/haplogrep-trees/>.

```bash
# check available trees
haplogrep3 trees
# add a tree
haplogrep install-tree phylotree-rcrs@17.2
# show macrohaplogroups
haplogrep3 cluster-haplogroups --output macro-rcrs.txt --tree phylotree-rcrs@17.2
```

#### LD between nDNA-mtDNA

LD for two specific SNPs can be done with --snp option (c.f. --extract a list from files) as follows,

```bash
#!/usr/bin/bash

export autosomes=~/rds/post_qc_data/uk_biobank/genotype/genotype/affy_ukbiobank_array/QCd_data/
export mtdna=~/rds/post_qc_data/uk_biobank/mtdna/genotyped/genotyped/

plink --bfile $autosomes/QCd_Eur --snp 1:723307_C_G --make-bed --out 1
plink --bfile $mtdna/UKBB_recaled_clean_4753out --snp Affx-79504644 --make-bed --out 2
plink --bfile 1 --bmerge 2 --make-bed --out 12
plink --bfile 12 --ld 1:723307_C_G Affx-79504644
```

### Example

#### 1. Documentation data

```bash
haplogrep3 classify --in data/examples/example-microarray.vcf --out microarray.txt --tree=phylotree-rcrs@17.0
haplogrep3 classify --in data/examples/example-wgs.vcf --out wgs.txt --tree=phylotree-rcrs@17.0
haplogrep3 classify --in trees/phylotree-rcrs/17.2/rcrs.fasta --out rcrs.txt --tree phylotree-rcrs@17.2
```

#### 2. vcf.gz

This enables handling vcf.gz via [vcf.gz.py](files/vcf.gz.py) for large samples (N=358,916 here),

```bash
module load ceuadmin/haplogrep
export UKB=~/rds/post_qc_data/uk_biobank/mtdna/imputed/imputed
haplogrep3 classify --in $UKB/UKBB_UKBL_binary.vcf.gz --out UKBL_binary --tree=phylotree-rcrs@17.2
aource ~/rds/software/py3.11/bin/activate
python vcf.gz.py UKBB_shortIDs.vcf.gz sloan15_input.txt &
sed 's/"//g' UKBB_binary | \
awk '{ gsub(/[^a-zA-Z0-9]/,"", $2); print $1 "\t" $2 }' | \
sed 's/ \+/\t/'> clean_haplogroups.txt
sloan15.pl sloan15_input.txt clean_haplogroups.txt > sloan15.tsv
 Rscript -e '
 ld <- read.delim("sloan15.tsv",check=FALSE)
 summary(ld$r2)
'
deactivate
```

#### 3. SLURM

The haplogrep3 step above is time-consuming and a SLURM job is used as follows,

```bash
#!/usr/bin/bash

#SBATCH --account PETERS-SL3-CPU
#SBATCH --partition icelake
#SBATCH --mem=28800
#SBATCH --time=12:00:00
#SBATCH --job-name=_hg
#SBATCH --output=hg.o
#SBATCH --error=hg.e

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl

export TMPDIR=${HPC_WORK}/work

module load ceuadmin/haplogrep
export UKB=~/rds/post_qc_data/uk_biobank/mtdna/imputed/imputed
haplogrep3 classify --in $UKB/UKBB_UKBL_binary.vcf.gz --out UKBL_binary --tree=phylotree-rcrs@17.2
```

We see a fine-grid haplogroupings (UKBL_binary), with lengthy sample IDs shortened according to vcf.gz with [renum.sh](files/renum.sh), are collapsed into macrohaplogroups as follows.

```r
library(dplyr)

macro_map <- read.delim("macro-rcrs.txt", header = TRUE, quote = "\"", stringsAsFactors = FALSE)
hg <- read.delim("clean_haplogroups.txt", stringsAsFactors = FALSE)

hg2 <- hg %>%
  left_join(macro_map, by = c("Haplogroup" = "Haplogroup")) %>%
  rename(Macro = Super.Haplogroup)

hg2$Macro[is.na(hg2$Macro)] <- "Unmapped"

print(table(hg2$Macro))
print(round((prop.table(table(hg2$Macro))*100+0.5)/100, 2))
write.table(hg2, "haplogroups_with_macro.txt", sep = "\t", row.names = FALSE)
```

whose counts and proportions are obtained,

```
> print(table(hg2$Macro))

       B        C        D        F        G        H       HV        I
       8       30       35        9        7   153014     1217    12687
       J        K       L0       L1       L2       L3       L4       L5
   41237    30550       35        1       27       18        3       22
       M        N        P        Q        R        T        U Unmapped
      47      161        7        1       85    31210    36329    36737
       V        W        X
    3005     7293     5141

> print(round((prop.table(table(hg2$Macro))*100+0.5)/100, 2))

       B        C        D        F        G        H       HV        I
    0.01     0.01     0.01     0.01     0.01     0.43     0.01     0.04
       J        K       L0       L1       L2       L3       L4       L5
    0.12     0.09     0.01     0.01     0.01     0.01     0.01     0.01
       M        N        P        Q        R        T        U Unmapped
    0.01     0.01     0.01     0.01     0.01     0.09     0.11     0.11
       V        W        X
    0.01     0.03     0.02
```

and for $r^2$ we now have

```
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's
0.000003 0.000285 0.001771 0.005593 0.007300 0.048756        7
```

#### 4. gnomAD

This section is for note-keeping only.

```bash
# gnomAD 3.1 chrM.vcf.bgz has no samples
gunzip -c gnomad.genomes.v3.1.sites.chrM.vcf.bgz > chrM.vcf
haplogrep3 classify --in chrM.vcf --out haplogrep_output.txt --tree phylotree-rcrs@17.0
# hail dense/sparse MatrixTable -- conceptual steps, too large to be tested!
module load openjdk/11.0.12_7/gcc/czpuqhmv
python <<END
gsutil -m cp -r \
gs://gcp-public-data--gnomad/release/3.1.2/mt/genomes/gnomad.genomes.v3.1.2.hgdp_1kg_subset_sparse.mt .
mt = hl.read_matrix_table("gnomad.genomes.v3.1.2.hgdp_1kg_subset_sparse.mt")
mt = mt.filter_rows(mt.locus.contig == 'chrM')
hl.export_vcf(mt, "chrM.vcf.bgz")
mt_small = mt.sample_rows(0.1)  # Keep 10% of variants
mt_small = mt_small.sample_cols(0.01)  # Keep 1% of samples
hl.export_vcf(mt_small, "chrM_subset.vcf.bgz")
END
```

## 2.4.0

### Installation

```bash
# cmd only
curl -sL haplogrep.now.sh | bash
# GitHub
wget -qO- https://github.com/seppinho/haplogrep-cmd/archive/refs/tags/v2.4.0.tar.gz | tar xfz -
cd haplogrep-cmd-2.4.0/
bash install/github-downloader.sh
# test
wget https://github.com/seppinho/haplogrep-cmd/raw/master/test-data/vcf/HG00097.vcf.gz
./haplogrep classify --in HG00097.vcf.gz --format vcf --out haplogroups.txt
```

### Example

The following examples concern about LDs on mtDNA and nDNA with mtDNA, which offer glimpse of findings from sloan, et al. (2015), <https://royalsocietypublishing.org/doi/suppl/10.1098/rspb.2015.1704> as well as a generic implementation via PLINK.

This is also the documentation example (VCF), for which we have $0.019 \ge r^2 \le 0.024$.

```bash
python3 < hgdp.py
module load ceuadmin/haplogrep/2.4.0
haplogrep classify --in data/examples/example-wgs.vcf --out hg.txt --format=vcf
# suppress double quote, asterisk and plus ("*+)
sed -i 's/"//g' hg.txt
awk '{ gsub(/[^a-zA-Z0-9]/,"", $2); print $1 "\t" $2 }' hg.txt > hg_simple_clean.txt
sloan15.pl sloan15_input.txt hg_simple_clean.txt > sloan15.tsv
Rscript -e '
 ld <- read.delim("sloan15.tsv",check=FALSE)
 summary(ld)
'
```

where [hgdp.py](files/hgdp.py) is used to reformat the data to a required format by [sloan15.pl](files/sloan15.pl).
