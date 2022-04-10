---
sort: 7
---

# bedops

Web: [https://bedops.readthedocs.io/en/latest/](https://bedops.readthedocs.io/en/latest/) ([forum](https://bedops.altius.org/forum/))

## Installation

```bash
wget -qO- https://github.com/bedops/bedops/releases/download/v2.4.39/bedops_linux_x86_64-v2.4.39.tar.bz2 | \
tar xfj -
```

would extract the executables into the bin/ directory.

## Examples

The following converts 0-based and 1-based coordinates.

```bash
# 1-->0
bedops --everything --range 1:-1 one-based-input.bed zero-based-output.bed
# 0-->1
bedops --everything --range 1:1 zero-based-input.bed one-based-output.bed
# 1-kb window upstream of a subset of forward-stranded transcription start sites (TSSs) in TSSs.bed piped 1kb_windows_upstream_of_forward_stranded_TSSs.bed
awk ‘$6 == "+"’ TSSs.bed | bedops --range 1000:0 --everything - > 1kb_windows_upstream_of_forward_stranded_TSSs.bed
# Reverse strand TSS upstream padding combined together by calling bedops once more
awk ‘$6 == "-"’ TSSs.bed | \
bedops --range 0:1000 --everything - | \
bedops --everything 1kb_windows_upstream_of_forward_stranded_TSSs.bed - >1kb_upstream_padding_TSSs.bed
# Pipe to map on motif predictions found in a BED-formatted text file called motif_predictions.bed
awk ‘$6 == "-"’ TSSs.bed | \
bedops --range 0:1000 --everything - | \
bedops --everything 1kb_windows_upstream_of_forward_stranded_TSSs.bed - | \
bedmap --echo --echo-map-id-uniq - motif_predictions.bed > motif_IDs_1kb_upstream_padding_TSSs.bed
# Relate BAM and VCF reads
bedmap --echo --echo-map-id-uniq <(bam2bed < reads.bam) <(vcf2bed < variants.vcf) > reads_with_unique_IDs_of_overlapping_SNPs.bed
```

## Reference

Neph S, et al. (2016). Operating on Genomic Ranges Using BEDOPS, in Math E, Davis S (Ed). Statistical Genomics-Methods and Protocols. Humana Press. Chapter 14, 267-281.
