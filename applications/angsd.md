---
sort: 4
---

# angsd

Web, <https://www.popgen.dk/angsd/index.php/ANGSD>

## 0.940

### Installation

```bash
wget -qO- https://github.com/ANGSD/angsd/releases/download/0.940/angsd0.940.tar.gz | \
tar xf -
cd htslib
make # install prefix=$CEUADMIN/angsd/0.940
make clean
cd -    
cd angsd
make HTSSRC=../htslib install prefix=$CEUADMIN/angsd/0.940
make clean
```

Note that 

1. angsd0.940.tar.gz file is actually a tar file (NOT gzipped).
2. The make command for htslib can also give a complete bin/include/lib/share set.
3. Once installed, object files are cleaned in both cases.
4. The package is associated withhtslib/1.16, and for 1.20 we use `make HTSSRC=/usr/local/Cluster-Apps/ceuadmin/htslib/1.20/lib`.

### docker / singularity

Since the option `docker pull thorfinn/angsd` is unavailable, we turn to singularity.

```bash
# check https://quay.io/repository/biocontainers/angsd?tab=tags
singularity pull docker://quay.io/biocontainers/angsd:0.940--h13024bc_4
singularity exec angsd_0.940--h13024bc_4.sif angsd --help
```

### Test

```bash
module load ceuadmin/samtools
# reference genome
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.fa.gz
gunzip hg19.fa.gz
samtools faidx hg19.fa
sed -r 's/^>chr/>/' hg19.fa > hg19.nochr.fa
samtools faidx hg19.nochr.fa
# ancestral genome
wget http://popgen.dk/software/download/angsd/hg19ancNoChr.fa.gz -O chimpHg19.fa.gz
samtools faidx chimpHg19.fa.gz
# Sample test data
wget http://popgen.dk/software/download/angsd/bams.tar.gz
tar xf bams.tar.gz
ls bams/*.bam > bam.filelist
# SAF
angsd -b bam.filelist \
      -ref hg19.nochr.fa \
      -anc chimpHg19.fa.gz \
      -GL 1 \
      -doSaf 1 \
      -doMajorMinor 1 \
      -doMaf 1 \
      -doCounts 1 \
      -minMapQ 30 -minQ 20 \
      -out test
# Site Frequency Spectrum (SFS)
realSFS test.saf.idx -P 4 > test.sfs
# site-specific theta values (-fold 1 if without ancestral state)
realSFS saf2theta test.saf.idx -sfs test.sfs -outname test
# Summary Statistics & Neutrality Metrics (global or sliding-window)
thetaStat do_stat test.thetas.idx
thetaStat do_stat test.thetas.idx \
  -win 50000 -step 10000 \
  -outnames test.thetasWindow.gz
```

Relevant plots are made with [angsd.R](files/angsd.R).

## Reference

Korneliussen, T.S., Albrechtsen, A. & Nielsen, R. ANGSD: Analysis of Next Generation Sequencing Data. BMC Bioinformatics 15, 356 (2014). <https://doi.org/10.1186/s12859-014-0356-4>
