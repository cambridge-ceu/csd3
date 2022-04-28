---
sort: 12
---

# CookHLA

Web: [https://github.com/WansonChoi/CookHLA](https://github.com/WansonChoi/CookHLA)

## Installation

According to the GitHub page above, the following steps are required.

```bash
# 0. CookHLA
git clone https://github.com/WansonChoi/CookHLA.git
cd CookHLA
# 1. PLINK 1.9
module load plink-1.9-gcc-5.4.0-sm3ojoi
mkdir dependency
cd dependency
# 2. mach1
wget -qO- https://csg.sph.umich.edu/abecasis/MACH/download/mach.1.0.18.Linux.tgz | \
# 3. beagle 5.1
wget https://faculty.washington.edu/browning/beagle/beagle.18May20.d20.jar -O beagle.jar
tar xvfz -
# 4. beagle utilities
wget https://faculty.washington.edu/browning/beagle_utilities/beagle2linkage.jar
wget https://faculty.washington.edu/browning/beagle_utilities/beagle2vcf.jar
wget https://faculty.washington.edu/browning/beagle_utilities/linkage2beagle.jar
wget https://faculty.washington.edu/browning/beagle_utilities/vcf2beagle.jar
wget https://faculty.washington.edu/browning/beagle_utilities/transpose.jar
# 6. Python
source ~/COVID-19/py37/bin/activate
pip install pyliftover==0.4
```

where ~/COVID-19/py37 is our Python virtual environment under Python version 3.7.

Nevertheless, the dependency directory already contains plink, beagle5.jar (can be renamed into beagle.jar), mach1 and all BEAGLE utilities.

## Example

The example mirrors those in SNPHLA[^1],

```bash
# Adaptive Genetic Map
python -m MakeGeneticMap \
    -i example/1958BC.hg19 \
    -hg 19 \
    -ref 1000G_REF/1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC \
    -o work/1958BC+1000G_REF.EUR

# Imputation
python CookHLA.py \
    -i example/1958BC.hg19 \
    -hg 19 \
    -o work/1958BC+HM_CEU_REF \
    -ref example/HM_CEU_REF \
    -gm example/AGM.1958BC+HM_CEU_REF.mach_step.avg.clpsB \
    -ae example/AGM.1958BC+HM_CEU_REF.aver.erate \
    -mem 20g \
    -mp 8
```

## Reference

Jia, X. et al. Imputing Amino Acid Polymorphisms in Human Leukocyte Antigens. _PLOS ONE_ 8, e64683 (2013).

Cook, S. et al. Accurate imputation of human leukocyte antigens with CookHLA. _Nature Communications_ 12, 1264 (2021).

---

[^1]: SNP2HLA

Web: [SNP2HLA v1.0.3](https://software.broadinstitute.org/mpg/snp2hla/) ([utitlities](https://faculty.washington.edu/browning/beagle_utilities/utilities.html))

It turns out to be difficult to download beagle 3.0.4 as indicated so it is included in the files/ directory ([beagle 3.0.4](files/beagle_3.0.4_05May09.zip), [documentation](files/beagle_3.3.2_31Oct11.pdf), [example](files/beagle_example.zip)).

```bash
wget -qO- https://software.broadinstitute.org/mpg/snp2hla/data/SNP2HLA_package_v1.0.3.tar.gz | \
tar xvfz -
cd SNP2HLA_package_v1.0.3/SNP2HLA
# add beagle2linkage.jar as above
# test.sh is adapted from SNP2HLA.csh by removing argument checking and as an executable.
test.sh 1958BC HM_CEU_REF 1958BC_IMPUTED plink 2000 1000
```

The output is 1958BC_IMPUTED in PLINK binary format.
