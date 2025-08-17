---
sort: 7
---

# hap.py

Web: <https://github.com/Illumina/hap.py>

```bash
wget -qO- https://github.com/Illumina/hap.py/archive/refs/tags/v0.3.15.tar.gz | tar xvfz -
cd hap.py-0.3.15/
module load gcc/6
source ~/rds/software/py2.7/bin/activate
export HG19=~/rds/public_databases/lib64/giab_lsk114_2022.12/analysis/hg002_truvari_svs/human_g1k_v37.fasta
python install.py $CEUADMIN/hap.py/0.3.15 --with-rtgtools
```

Now we set to replicate ONT benchmarks,

```bash
module load ceuadmin/awscli
aws s3 ls --no-sign-request s3://ont-open-data/giab_lsk114_2022.12/
aws s3 sync --no-sign-request s3://ont-open-data/giab_lsk114_2022.12/ giab_lsk114_2022.12
cd giab_lsk114_2022.12/benchmarking
mkdir truthset && cd truthset
wget ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/AshkenazimTrio/HG002_NA24385_son/NISTv4.2.1/GRCh38/*
cd ../..
```

which contains `analysis/run-happy.sh`, when modified as [`happy.sb`](files/happy.sb) and after running gives

```
Hap.py
[W] overlapping records at chr6:29747433 for sample 0
[W] Variants that overlap on the reference allele: 5
[I] Total VCF records:         4048342
[I] Non-reference VCF records: 4048342
[W] overlapping records at chr1:151482 for sample 0
[W] Variants that overlap on the reference allele: 5359
[I] Total VCF records:         6084932
[I] Non-reference VCF records: 6084932
...
```

as in [happy.e](files/happy.e) as well as output [happy.o](files/happy.o)

```
Formatting FASTA data
Processing "GCA_000001405.15_GRCh38_no_alt_analysis_set.fna"

Detected: 'Human GRCh38 with UCSC naming', installing reference.txt


Input Data
Files              : GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
Format             : FASTA
Type               : DNA
Number of sequences: 195
Total residues     : 3099922541
Minimum length     : 970
Mean length        : 15897038
Maximum length     : 248956422

Output Data
SDF-ID             : b881adee-81c0-4dc3-b5b3-300ef6ca0b0b
Number of sequences: 195
Total residues     : 3099922541
Minimum length     : 970
Mean length        : 15897038
Maximum length     : 248956422
Hap.py
Benchmarking Summary:
  Type Filter  TRUTH.TOTAL  TRUTH.TP  TRUTH.FN  QUERY.TOTAL  QUERY.FP  QUERY.UNK  FP.gt  FP.al  METRIC.Recall  METRIC.Precision  METRIC.Frac_NA  METRIC.F1_Score  TRUTH.TOTAL.TiTv_ratio  QUERY.TOTAL.TiTv_ratio  TRUTH.TOTAL.het_hom_ratio  QUERY.TOTAL.het_hom_ratio
 INDEL    ALL       525469    430462     95007       776455     55575     279008  14126  20494       0.819196          0.888280        0.359336         0.852340                     NaN                     NaN                   1.528276                   1.767044
 INDEL   PASS       525469    430462     95007       776455     55575     279008  14126  20494       0.819196          0.888280        0.359336         0.852340                     NaN                     NaN                   1.528276                   1.767044
   SNP    ALL      3365127   3361205      3922      4783865      7749    1413355   1385   3124       0.998835          0.997701        0.295442         0.998267                2.100128                1.668217                   1.581196                   1.671398
   SNP   PASS      3365127   3361205      3922      4783865      7749    1413355   1385   3124       0.998835          0.997701        0.295442         0.998267                2.100128                1.668217                   1.581196                   1.671398
```

NB only HG002 is tested here.
