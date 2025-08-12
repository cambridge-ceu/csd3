---
sort: 66
---

# Notes on emsembl-vep

## Location & module

The location of VEP is here on CSD3,

`~/rds/rds-jmmh2-public_databases/ensembl-vep`

The CSD3 module is named `ceuadmin/ensembl-vep/104`, `/usr/local/Cluster-Apps/ceuadmin/ensembl-vep/104` is a symbolic link to the CSD3 location above.

On icelake, we use module `ceuadmin/ensembl-vep/111-icelake`, e.g.,

```bash
module load ceuadmin/ensembl-vep/111-icelake
vep --help
```

to get

```
#----------------------------------#
# ENSEMBL VARIANT EFFECT PREDICTOR #
#----------------------------------#

Versions:
  ensembl              : 111.a6cc543
  ensembl-funcgen      : 111.5327cdd
  ensembl-io           : 111.dbba8d6
  ensembl-variation    : 111.d616b1e
  ensembl-vep          : 111.0

Help: dev@ensembl.org , helpdesk@ensembl.org
Twitter: @ensembl

http://www.ensembl.org/info/docs/tools/vep/script/index.html

Usage:
./vep [--cache|--offline|--database] [arguments]

Basic options
=============

--help                 Display this message and quit

-i | --input_file      Input file
-o | --output_file     Output file
--force_overwrite      Force overwriting of output file
--species [species]    Species to use [default: "human"]

--everything           Shortcut switch to turn on commonly used options. See web
                       documentation for details [default: off]
--fork [num_forks]     Use forking to improve script runtime

For full option documentation see:
http://www.ensembl.org/info/docs/tools/vep/script/vep_options.html
```

## Features

- VEP version 104
- GRCh38 assembly
- homo_sapiends/homo_sapiends_merged species
- kent-335_base/ as required by setup for perl5/ Bio::DB::BigFile below
- Perl modules as in perl5/
- Plugins

## Plugins

The version check under `icelake` is furnised with

```bash
perl/5.26.3_system/gcc-8.4.1-4cl2czq
perl INSTALL.pl -a p -g list
```

### --- clinvar ---

The compressed VCF and index files for GRCh38 are `clinvar.vcf.gz` and `clinvar.vcf.gz.tbi`, with counterparts for GRCh37 are `clinvar_GRCh37.vcf.gz` and `clinvar_GRCh37.vcf.gz.tbi`, respectively.

### --- loftee ---

This is in line with the VEP installation which only includes GRCh38 reference files.

#### GRCh38

```bash
#!/usr/bin/bash

export ENSEMBL=~/rds/rds-jmmh2-public_databases/ensembl-vep
export PERL5LIB=${ENSEMBL}/Bio:${ENSEMBL}/perl5/lib/perl5:${ENSEMBL}/loftee:$HPC_WORK/bin
export rds=..  # ~/rds/rds-jmmh2-public_databases/ensembl-vep will be user-specific
export outdir=..

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

#### GRCh37

This mirrors GRCh37 based on 98.3 from **/rds/rds-jmmh2-public_databases/software/ensembl-vep**; see also [loftee-grch37/test.sh](loftee-grch37/test.sh).

```bash
#!/usr/bin/bash

export ENSEMBL=~/rds/rds-jmmh2-public_databases/ensembl-vep
export PERL5LIB=${ENSEMBL}/Bio:${ENSEMBL}/perl5/lib/perl5:${ENSEMBL}/loftee-grch37:$HPC_WORK/bin
export rds=..  # ~/rds/rds-jmmh2-public_databases/ensembl-vep will be user-specific

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
