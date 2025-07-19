#!/bin/bash
genome=$1  # 002/3/4
caller=$2  # hac/sup

dataset="hg${genome}_${caller}"
home=${PWD}

rm -rf ${dataset}_happy_out
export output=small_variants_happy/${dataset}_happy_out
mkdir ${output}
pushd ${output}
module load ceuadmin/hap.py
hap.py \
    ${home}/benchmarking/truthset/HG${genome}_GRCh38_1_22_v4.2.1_benchmark.vcf.gz \
    ${home}/wf-human-var-output/${dataset}_v4/hg${genome}.wf_snp.vcf.gz \
    -f ${home}/benchmarking/truthset/HG${genome}_GRCh38_1_22_v4.2.1_benchmark_noinconsistent.bed \
    -r ${home}/benchmarking/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna \
    -o ${caller}_happy_out \
    --pass-only --engine=vcfeval --threads=16 \
    --engine-vcfeval-template ${home}/benchmarking/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.sdf
popd
