---
sort: 14
---

# Appendix B. LoF via loftee

## Location

The location of VEP is here on CSD3,

`~/rds/rds-jmmh2-public_databases/ensembl-vep`

but also referred without the `rds-jmmh2-` prefix (why?), as in

[https://cambridge-ceu.github.io/csd3/systems/directories.html](https://cambridge-ceu.github.io/csd3/systems/directories.html)

## Features

* VEP version 104
* GRCh38 assembly
* homo_sapiends/homo_sapiends_merged species
* kent-335_base/ as required by setup for perl5/ Bio::DB::BigFile below
* Perl modules as in perl5/
* Plugins

## Notes on plugins

### --- clinvar ---

The compressed VCF and index files for GRCh38 are `clinvar.vcf.gz` and `clinvar.vcf.gz.tbi`, with counterparts for GRCh37 are `clinvar_GRCh37.vcf.gz` and `clinvar_GRCh37.vcf.gz.tbi`, respectively.

### --- loftee ---

#### loftee

This is in line with the VEP installation which only includes GRCh38 reference files.

**Example code**

```bash
#!/usr/bin/bash

export ENSEMBL=~/rds/rds-jmmh2-public_databases/ensembl-vep
export PERL5LIB=${ENSEMBL}/Bio:${ENSEMBL}/perl5/lib/perl5:${ENSEMBL}/loftee:$HPC_WORK/bin
export rds=..  # ~/rds/rds-jmmh2-public_databases/ensembl-vep will be user-specific
export outdir=..

## GRCh38
export LOFTEE38=${ENSEMBL}/loftee/loftee_data/GRCh38
export LOFTEE38GERP=${LOFTEE38}/gerp_conservation_scores.homo_sapiens.GRCh38.bw
export LOFTEE38HA=${LOFTEE38}/human_ancestor.fa.gz
export LOFTEE38SQL=${LOFTEE38}/loftee.sql

if [ ! -f Homo_sapiens.GRCh38.dna.toplevel.fa ]; then
   ln -sf ${rds}/.vep/homo_sapiens_merged/104_GRCh38/Homo_sapiens.GRCh38.dna.toplevel.fa
fi

${rds}/vep --input_file VEP_input.txt \
           --format ensembl \
           --output_file ${outdir}/VEP_output.txt \
           --force_overwrite \
           --offline \
           --symbol \
           --merged \
           --fasta Homo_sapiens.GRCh38.dna.toplevel.fa \
           --dir_cache ${rds}/.vep \
           --dir_plugins . \
           --protein \
           --symbol \
           --tsl \
           --canonical \
           --mane_select \
           --biotype \
           --check_existing \
           --sift b \
           --polyphen b \
           --plugin LoF,loftee_path:.,gerp_bigwig:${LOFTEE38GERP},human_ancestor_fa:${LOFTEE38HA},conservation_file:${LOFTEE38SQL}
```

#### loftee-grch37

This directory is appropriate with GRCh37 based on 98.3 from my ${HPC_work}/ensembl-vep; see also [loftee-grch37/test.sh](loftee-grch37/test.sh).

**Example code**

```bash
#!/usr/bin/bash

export ENSEMBL=~/rds/rds-jmmh2-public_databases/ensembl-vep
export PERL5LIB=${ENSEMBL}/Bio:${ENSEMBL}/perl5/lib/perl5:${ENSEMBL}/loftee-grch37:$HPC_WORK/bin
export rds=..  # ~/rds/rds-jmmh2-public_databases/ensembl-vep will be user-specific

## GRCh37
export LOFTEE37=${ENSEMBL}/loftee-grch37
export LOFTEE37GERP=${LOFTEE37}/GERP_scores.final.sorted.txt.gz
export LOFTEE37HA=${LOFTEE37}/human_ancestor.fa.rz
export LOFTEE37SQL=${LOFTEE37}/phylocsf_gerp.sql

${rds}/vep --input_file VEP_input.txt \
           --format ensembl \
           --output_file VEP_output_GRCh37.txt \
           --force_overwrite \
           --offline \
           --symbol \
	   --dir_cache ${rds}/.vep \
           --dir_plugins . \
           --use_given_ref \
           --check_existing \
           --protein \
           --symbol \
           --tsl \
           --canonical \
           --mane_select \
           --biotype \
           --sift b \
           --polyphen b \
           --plugin LoF,loftee_path:.,human_ancestor_fa:${LOFTEE37HA},conservation_file:${LOFTEE37SQL}
```

### --- GeneSplicer ---

This is a self-contained plugin.

### --- REVEL ---

The REVEL/ directory contains reference files for REVEL score.