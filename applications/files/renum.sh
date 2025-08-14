#!/usr/bin/env bash

module load ceuadmin/bcftools

# Input VCF path
vcf="UKBB_UKBL_binary.vcf.gz"

# Output mapping file
mapfile="rename_map.txt"

# Extract original sample IDs from the VCF header
bcftools query -l "$vcf" | \
  awk '{ printf("%s ID%04d\n", $0, NR) }' > "$mapfile"

echo "Mapping saved to $mapfile"
head -n 5 "$mapfile"

bcftools reheader -s rename_map.txt \
  UKBB_UKBL_binary.vcf.gz \
  -o UKBB_shortIDs.vcf.gz

bcftools index UKBB_shortIDs.vcf.gz

awk 'BEGIN {
    while ((getline < "rename_map.txt") > 0) {
        old[$1] = $2
    }
    close("rename_map.txt")
}
NR == 1 {
    print
    next
}
{
    if ($1 in old) {
        print old[$1], $2
    } else {
        print $1, $2
    }
}' hg_simple_clean.txt > hg_simple_clean_shortIDs.txt
