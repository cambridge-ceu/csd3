---
sort: 26
---

# Genotype-Harmonizer

Web: [https://github.com/molgenis/systemsgenetics](https://github.com/molgenis/systemsgenetics) ([Manual](https://github.com/molgenis/systemsgenetics/wiki/Genotype-Harmonizer)).

## 1.4.23

```bash
wget -qO- https://github.com/molgenis/systemsgenetics/releases/download/1.4.0_20-8.1/GenotypeHarmonizer-1.4.23-dist.tar.gz | \
tar xvfz -
cd GenotypeHarmonizer-1.4.23
dos2unix GenotypeHarmonizer.sh
```

Alignment with HapMap3 data is possible with the following data.

```bash
wget ftp://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/latest_phaseIII_ncbi_b36/plink_format/hapmap3_r2_b36_fwd.consensus.qc.poly.map.bz2
bzip2 -d hapmap3_r2_b36_fwd.consensus.qc.poly.map.bz2
wget ftp://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/latest_phaseIII_ncbi_b36/plink_format/hapmap3_r2_b36_fwd.consensus.qc.poly.ped.bz2
bzip2 -d hapmap3_r2_b36_fwd.consensus.qc.poly.ped.bz2
wget ftp://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/latest_phaseIII_ncbi_b36/plink_format/relationships_w_pops_121708.txt
```

A HapMap2+HapMap3 combined data is available from [https://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/latest_phaseII+III_ncbi_b36/forward/non-redundant/](https://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/latest_phaseII+III_ncbi_b36/forward/non-redundant/).

### Example

```bash
# Extract first 6Mb of chr20 for CEU samples

# Create list of CEU sampels to extract
awk '$7 == "CEU" {print $1,$2}' relationships_w_pops_121708.txt > ceuSamples.txt
module load plink-1.9-gcc-5.4.0-sm3ojoi
plink --chr 20 --file hapmap3_r2_b36_fwd.consensus.qc.poly --out hapmap3CeuChr20B36Mb6 --from-mb 0 --to-mb 6 --recode --keep ceuSamples.txt

# - liftover to b37 -

# Create bed
awk '{$5=$2;$2=$4;$3=$4+1;$1="chr"$1;print $1,$2,$3,$5}' OFS="\t" hapmap3CeuChr20B36Mb6.map > hapmap3CeuChr20B36Mb6b36.bed

# Update mapping
wget -qO- https://hgdownload.cse.ucsc.edu/goldenpath/hg18/liftOver/hg18ToHg19.over.chain.gz | \
gunzip -c > hg18ToHg19.over.chain
liftOver -bedPlus=4 hapmap3CeuChr20B36Mb6b36.bed hg18ToHg19.over.chain hapmap3CeuChr20B36Mb6b37.bed hapmap3CeuChr20B36Mb6unmapped.txt

# All SNPs are mapped. Normally we would have to account for this

# Create mapping update list used by Plink
awk '{print $4, $2}' OFS="\t" hapmap3CeuChr20B36Mb6b37.bed > hapmap3CeuChr20B36Mb6b37.txt

# Update plink mappings
plink --file hapmap3CeuChr20B36Mb6 --recode --out hapmap3CeuChr20B37Mb6 --update-map hapmap3CeuChr20B36Mb6b37.txt

# No we have to again create a plink file to make sure the implied order is correct after liftover.
plink --file hapmap3CeuChr20B37Mb6 --out hapmap3CeuChr20B37Mb6 --make-bed
dos2unix HarmonizeBinaryPlinkExample.sh
HarmonizeBinaryPlinkExample.sh
```

## 1.4.25

This appears simpler, namely.

```bash
wget -qO- https://github.com/molgenis/systemsgenetics/archive/refs/tags/GH_1.4.25.tar.gz | x
tar xvfz -
cd GenotypeHarmonizer-1.4.25-SNAPSHOT/
do2unix *.sh
HarmonizeBinaryPlinkExample.sh
```

which produces results in `exampleOutput/`.

## Reference

Deelen, P. et al. Genotype harmonizer: automatic strand alignment and format conversion for genotype data integration. _BMC Research Notes_ 7, 901 (2014).
