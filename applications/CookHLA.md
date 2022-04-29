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

where ~/COVID-19/py37 is our Python virtual environment under Python version 3.7, and pyliftover is the Python liftover package.

Nevertheless, the dependency directory already contains plink, beagle5.jar (can be renamed into beagle.jar), mach1 and all BEAGLE utilities.

## Example

The example mirrors those in SNP2HLA[^1],

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

The imputation gives 1958BC+HM_CEU_REF.MHC.HLA_IMPUTATION_OUT .alleles and .hped files, which is handled with [HATK](https://github.com/WansonChoi/HATK).

## References

Jia, X. et al. Imputing Amino Acid Polymorphisms in Human Leukocyte Antigens. _PLOS ONE_ 8, e64683 (2013).

Cook, S. et al. Accurate imputation of human leukocyte antigens with CookHLA. _Nature Communications_ 12, 1264 (2021).

---

[^1]: SNP2HLA

    > Web: [SNP2HLA v1.0.3](https://software.broadinstitute.org/mpg/snp2hla/) ([BEAGLE utitlities](https://faculty.washington.edu/browning/beagle_utilities/utilities.html))
    >
    > ### Installation
    >
    > It turns out to be difficult to download beagle 3.0.4 as indicated so it is included in the files/ directory ([beagle 3.0.4](files/beagle_3.0.4_05May09.zip), [documentation](files/beagle_3.3.2_31Oct11.pdf), [example](files/beagle_example.zip)).
    >
    > ```bash
    > wget -qO- https://software.broadinstitute.org/mpg/snp2hla/data/SNP2HLA_package_v1.0.3.tar.gz | \
    > tar xvfz -
    > cd SNP2HLA_package_v1.0.3/SNP2HLA
    > # add beagle2linkage.jar as above
    > # test.sh is adapted from SNP2HLA.csh by removing argument checking and as an executable.
    > # The .dos file described in README.txt is actually the .dosage file generated internally from test.sh
    > # The association statistics will be in .assoc.assoc.dosage; the double .assoc guarantees an .assoc.log file.
    > csh SNP2HLA.csh 1958BC HM_CEU_REF 1958BC_IMPUTED plink
    > csh ParseDosage.csh 1958BC_IMPUTED.bgl.gprobs > 1958BC_IMPUTED.bgl.dos
    > plink --noweb --dosage 1958BC_IMPUTED.dosage noheader format=1 --fam 1958BC_IMPUTED.fam --logistic --out 1958BC_IMPUTED.assoc
    > ```
    >
    > As indicated, we call the .csh scripts with `csh` which is actually `tsch` on csd3.
    >
    > ### Example
    >
    > The screen output is as follows,
    >
    > ```
    >   SNP2HLA: Performing HLA imputation for dataset 1958BC
    > - Java memory = 2000Mb
    > - Beagle window size = 1000 markers
    > [1] Extracting SNPs from the MHC.
    > [2] Performing SNP quality control.
    > [3] Convering data to beagle format.
    > [4] Performing HLA imputation (see 1958BC_IMPUTED.bgl.log for progress).
    > [5] Converting posterior probabilities to PLINK dosage format.
    > [6] Converting imputation genotypes to PLINK .ped format.
    > DONE!
    > ```
    >
    > The output is 1958BC_IMPUTED in PLINK binary format.
    >
    > ### MakeReference
    >
    > We first create `MakeReference.tcsh` such that calls to .pl scripts are prefixed with `perl`, e.g.,
    >
    > ```bash
    > diff MakeReference.csh MakeReference.tcsh
    > ```
    >
    > ```
    > 77c77
    > <     ./HLAtoSequences.pl $HLA_DATA HLA_DICTIONARY_AA.txt AA > $OUTPUT.AA.ped
    > ---
    > >     perl HLAtoSequences.pl $HLA_DATA HLA_DICTIONARY_AA.txt AA > $OUTPUT.AA.ped
    > 81c81
    > <     ./encodeVariants.pl $OUTPUT.AA.ped $OUTPUT.AA.map $OUTPUT.AA.CODED
    > ---
    > >     perl encodeVariants.pl $OUTPUT.AA.ped $OUTPUT.AA.map $OUTPUT.AA.CODED
    > 93c93
    > <     ./encodeHLA.pl $HLA_DATA $OUTPUT.HLA.map > $OUTPUT.HLA.ped
    > ---
    > >     perl encodeHLA.pl $HLA_DATA $OUTPUT.HLA.map > $OUTPUT.HLA.ped
    > 100c100
    > <     ./HLAtoSequences.pl $HLA_DATA HLA_DICTIONARY_SNPS.txt SNPS > $OUTPUT.SNPS.ped
    > ---
    > >     perl HLAtoSequences.pl $HLA_DATA HLA_DICTIONARY_SNPS.txt SNPS > $OUTPUT.SNPS.ped
    > 104c104
    > <     ./encodeVariants.pl $OUTPUT.SNPS.ped $OUTPUT.SNPS.map $OUTPUT.SNPS.CODED
    > ---
    > ```
    >
    > ```bash
    > tcsh MakeReference.tcsh HAPMAP_CEU HAPMAP_CEU_HLA.ped HM_CEU_REF plink
    > ```
    >
    > ```
    > tcsh MakeReference.tcsh HAPMAP_CEU HAPMAP_CEU_HLA.ped HM_CEU_REF plink
    > Creating reference panel: HM_CEU_REF
    > [1] Generating amino acid sequences from HLA types.
    > [2] Encoding amino acids positions.
    > [3] Encoding HLA alleles.
    > [4] Generating DNA sequences from HLA types.
    > [5] Encoding SNP positions.
    > [6] Extracting founders.
    > [7] Merging SNP, HLA, and amino acid datasets.
    > Warning: Variants 'SNP_A_30018350' and 'AA_A_-11_30018350' have the same
    > position.
    > Warning: Variants 'SNP_A_30018461_G' and 'SNP_A_30018461_A' have the same
    > position.
    > Warning: Variants 'SNP_A_30018461_T' and 'SNP_A_30018461_G' have the same
    > position.
    > 987 more same-position warnings: see log file.
    > [8] Performing quality control.
    > [9] Preparing files for Beagle.
    > [10] Converting to beagle format.
    > [11] Phasing reference using Beagle (see progress in HM_CEU_REF.bgl.log).
    > [12] Done.
    > ```
