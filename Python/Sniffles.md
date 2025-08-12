---
sort: 13
---

# Sniffles

GitHub: <https://github.com/fritzsedlazeck/Sniffles>

## Installation

This Python package takes advantage of SVanalyzer, i.e.,

```bash
module load ceuadmin/SVanalyzer
conda install sniffles
sniffles --version
```

## Example

For the GIAB PackBio Hi-Fi Ashkenazi Trio data,

```bash
# wget (-c to resume)
wget ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/PacBio_HiFi-Revio_20231031/HG002_PacBio-HiFi-Revio_20231031_48x_GRCh38-GIABv3.bam*
# rsync can check directory
rsync --partial --progress -av \
  rsync://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/PacBio_HiFi-Revio_20231031/* .
wget ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/references/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta.gz*
sniffles \
  --input HG002_PacBio-HiFi-Revio_20231031_48x_GRCh38-GIABv3.bam  \
  --reference GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta.gz \
  --vcf HG002_PacBio-HiFi-Revio_20231031_48x_GRCh38-GIABv3.vcf.gz \
  --threads 8
module load ceuadmin/bcftools
bcftools query -f "%CHROM\t%POS\t%ID\t%REF\t%ALT\t%QUAL\t%FILTER\t%FORMAT\n" \
  HG002_PacBio-HiFi-Revio_20231031_48x_GRCh38-GIABv3.vcf.gz -H | head -2
```

We see

```
Generating index for HG002_PacBio-HiFi-Revio_20231031_48x_GRCh38-GIABv3.vcf.gz...
Indexing VCF output took 0.15s.
Done.
Wrote 28267 called SVs to HG002_PacBio-HiFi-Revio_20231031_48x_GRCh38-GIABv3.vcf.gz (single-sample, sorted, bgzipped, tabix-indexed)
bcftools query -f "%CHROM\t%POS\t%ID\t%REF\t%ALT\t%QUAL\t%FILTER\t\n" HG002_PacBio-HiFi-Revio_20231031_48x_GRCh38-GIABv3.vcf.gz -H | head -2
#[1]CHROM       [2]POS  [3]ID   [4]REF  [5]ALT  [6]QUAL [7]FILTER
chr1    10863   Sniffles2.INS.4S0       N       CAGGCGCAGAGAGGCGCGCCGCGCCGGCGCAGGCGCAGAGAGGCGCGCCGCGCCGGCGCAGGCGCAGAGAGGCGCGCCGCGCCGGCGCAGGCGCAGAGACACATGCTAGCGCGTCCAGGGGAGGAGGCGTGGCA        33      PASS
...
```
