---
sort: 45
---

# MToolBox

GitHub: <https://github.com/mitoNGS/MToolBox>

## 1.2.1

### Installation

The default URLs for depenencies Anaconda2, samtools 1.3, zlib 1.2.11 require slight changes, namely

```bash
wget -qO- https://github.com/mitoNGS/MToolBox/archive/refs/tags/v1.2.1.tar.gz | tar xvfz -
cd MToolBox-1.2.1/bin
wget https://mirrors.sustech.edu.cn/anaconda/archive/Anaconda2-2.5.0-Linux-x86_64.sh
wget https://sourceforge.net/projects/samtools/files/samtools/1.3/samtools-1.3.tar.bz2/
wget https://download.videolan.org/pub/contrib/zlib/zlib-1.2.11.tar.gz
bash Anaconda2-2.5.0-Linux-x86_64.sh # install to anaconda
./install.sh
./install.sh -i gsnap_db # when interrupted, resume for chrM.fa.gz, chrRSRS.fa.gz, hg19RCRS.fa.gz, hg19RSRS.fa.gz
```

However, locations of gsnap 2015-12-31 and muscle 3.8.31_i86linux64 remain intact.

### Example

The documentation example can be furnished as follows.

```bash
module load ceuadmin/MToolBox
cd MToolBox-1.2.1/
gunzip *fa.gz
samtools faidx hg19RCRS.fa
samtools faidx hg19RSRS.fa
samtools faidx chrM.fa
samtools faidx chrRSRS.fa
MToolBox.sh -h
cd test/HG00119_example
ln -s ../../chrM.fa
ln -s ../../chrRSRS.fa
ln -s ../../hg19RCRS.fa
ln -s ../../hg19RSRS.fa
ln -s ../../chrM.fa.fai
ln -s ../../chrRSRS.fa.fai
ln -s ../../hg19RCRS.fa.fai
ln -s ../../hg19RSRS.fa.fai
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR043/SRR043366/SRR043366_1.fastq.gz -O SRR043366_R1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR043/SRR043366/SRR043366_2.fastq.gz -O SRR043366_R2.fastq.gz
zcat SRR043366_R1.fastq.gz > SRR043366.fastq # or SRR043366_R2.fastq.gz?
MToolBox.sh -c HG00119.conf &> HG00119.log &# upon minor changes on HG00119.conf
```

## MTooBox_snakemake

Web:, <https://github.com/mitoNGS/MToolBox_snakemake> & <https://mtoolbox-snakemake.readthedocs.io/en/sept_2020_doc/index.html>

### Installation

```bash
git clone https://github.com/mitoNGS/MToolBox_snakemake
cd MToolBox_snakemake
module load ceuadmin/micromamba
micromamba env create -f envs/mtoolbox.yaml -n mtoolbox
eval "$(micromamba shell hook --shell bash)"
micromamba activate mtoolbox
micromamba install sqlalchemy
micromamba install pytest
micromamba clean --all --yes
micromamba list | grep -e bcftools -e gatk -e gmap -e picard -e pyvcf -e requests -e samtools
wget -qO- https://github.com/mitoNGS/mtoolnote/archive/refs/tags/v0.2.0.tar.gz | tar xfz -
cd mtoolnote-0.2.0/
pip uninstall requests
pip install .
pip cache purge
pip list | grep -e mtoolnote -e requests -e pytest
mtoolnote --help
cd ..
micromamba deactivate
```

### Workflow

It is available from the micromamba environment as above,

```bash
module load ceuadmin/micromamba
cd mtoolnote-0.2.0/
eval "$(micromamba shell hook --shell bash)"
micromamba activate mtoolbox
snakemake -s Snakefile --reason \
 --printshellcmds \
 --keep-going \
 --cores 15 \
 --cluster-config cluster.yaml --latency-wait 60 \
 --cluster 'sbatch -A PETERS-SL3-CPU -p core -n {cluster.threads} -t 7:00:00 -o {cluster.stdout}' \
 --dryrun
micromamba deactivate
```

## mtoolnote

Web: <https://github.com/mitoNGS/mtoolnote>

### Installation

It has a conflict with the Python package requests 2.28.1. Consequently, from `micromamba list` and `pip list`, we have

```
bcftools                       1.11          h7c999a4_0              bioconda
gatk-framework                 3.6.24        hdfd78af_6              bioconda
gmap                           2020.04.08    pl526h2f06484_1         bioconda
picard                         2.23.7        0                       bioconda
pyvcf                          0.6.7         py36_0                  bioconda
requests                       2.28.1        pyhd8ed1ab_0            conda-forge
samtools                       1.11          h6270b1f_0              bioconda
```

but

```
mtoolnote                     0.2.0
pytest                        7.0.1
requests                      2.27.1
```

respectively.

### Usage

```
Usage: mtoolnote [OPTIONS] INPUT_VCF OUTPUT_VCF

  Annotate a VCF file using mtoolnote.

Options:
  --version                       Show the version and exit.
  -s, --species [human|oaries|ptroglodytes|scerevisiae|ecaballus|fcatus|cfamiliaris|pabelii|ggallus|mmulatta|rnorvegicus|btaurus|oanatinus|sscrofa|nleucogenys|chircus|mmusculus|tguttata|tnigroviridis|mgallopavo|mdomestica|drerio]
                                  Species to use for annotation  [default:
                                  human]
  -c, --csv                       Create an additional annotated CSV file
                                  [default: False]
  --crossref / --no-crossref      Add cross-reference annotations  [default:
                                  crossref]
  --predict / --no-predict        Add pathogenicity prediction annotations
                                  [default: predict]
  --variab / --no-variab          Add nucleotide variability annotations
                                  [default: variab]
  --haplos / --no-haplos          Add haplogroup-specific allele frequency
                                  annotations  [default: haplos]
  --help                          Show this message and exit.

Building DAG of jobs...
MissingInputException in line 180 of /rds/project/rds-4o5vpvAowP0/software/MToolBox_snakemake/Snakefile:
Missing input files for rule trimmomatic:
data/reads/5517_hypo_1_R2_001.fastq.gz
data/reads/5517_hypo_1_R1_001.fastq.gz
```
