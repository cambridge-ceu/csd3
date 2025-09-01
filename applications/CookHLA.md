---
sort: 17
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
tar xvfz -
# 3. beagle 5.1
wget https://faculty.washington.edu/browning/beagle/beagle.18May20.d20.jar -O beagle.jar
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

The imputation gives 1958BC+HM_CEU_REF.MHC.HLA_IMPUTATION_OUT .alleles and .hped files, which is handled with HATK[^2] and HLA-TAPAS[^3]. The software also takes output from HIBAG[^4], among others.

## 1000Genomes

We are rather tempted to use these from CookHLA with SNP2HLA, and follow the footnote on SNP2HLA we have,

```bash
csh SNP2HLA.csh 1958BC 1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC 1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC plink
plink --noweb --dosage 1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC.dosage noheader format=1 \
      --fam 1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC.fam \
      --linear --out 1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC.dosage.assoc
```

we obtain the screen output,

```
SNP2HLA: Performing HLA imputation for dataset 1958BC
- Java memory = 2000Mb
- Beagle window size = 1000 markers
[1] Extracting SNPs from the MHC.
[2] Performing SNP quality control.
[3] Convering data to beagle format.
[4] Performing HLA imputation (see 1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC.bgl.log for progress).
[5] Converting posterior probabilities to PLINK dosage format.
[6] Converting imputation genotypes to PLINK .ped format.
DONE!

PLINK v1.90p 64-bit (8 Nov 2021)               www.cog-genomics.org/plink/1.9/
(C) 2005-2021 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to 1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC.dosage.assoc.log.
Options in effect:
  --dosage 1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC.dosage noheader format=1
  --fam 1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC.fam
  --linear
  --noweb
  --out 1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC.dosage.assoc

Note: --dosage automatically performs a regression; --linear/--logistic has no
additional effect.
Note: --noweb has no effect since no web check is implemented yet.
257130 MB RAM detected; reserving 128565 MB for main workspace.
10 people (9 males, 1 female) loaded from .fam.
10 phenotype values loaded from .fam.
Using 1 thread (no multithreaded calculations invoked).
10 people pass filters and QC.
Among remaining phenotypes, 0 are cases and 10 are controls.
--dosage: Reading from
1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC.dosage.
--dosage: Results saved to
1958BC_IMPUTED_1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC.dosage.assoc.assoc.dosage
```

## References

Choi W, Luo Y, Raychaudhuri S & Han B HATK: HLA analysis toolkit. _Bioinformatics_ 37, 416-418 (2020).

Cook S, et al. Accurate imputation of human leukocyte antigens with CookHLA. _Nat Comm_ 12, 1264 (2021).

Degenhardt F, et al. Construction and benchmarking of a multi-ethnic reference panel for the imputation of HLA class I and II alleles. _Hum Mol Genet_ 28, 2078-2092 (2018).

Jia X, et al. Imputing Amino Acid Polymorphisms in Human Leukocyte Antigens. _PLOS ONE_ 8, e64683 (2013).

Immuno Polymorphism Database-international ImMunoGeneTics project (IMGT) (IPD-IMGT/HLA), [https://www.ebi.ac.uk/ipd/imgt/hla/](https://www.ebi.ac.uk/ipd/imgt/hla/)

Luo, Y, et al. A high-resolution HLA reference panel capturing global population diversity enables multi-ancestry fine-mapping in HIV host response. _Nat Genet_ 53, 1504–1516 (2021), [https://doi.org/10.1038/s41588-021-00935-7](https://doi.org/10.1038/s41588-021-00935-7).

WHO Committe. Nomenclature for Factors of the HLA System, [http://hla.alleles.org/](http://hla.alleles.org/).

Zheng X, et al. HIBAG—HLA genotype imputation with attribute bagging. _The Pharmacogenomics J_ 14, 192-200 (2014), [HLARES](https://hibag.s3.amazonaws.com/hlares_index.html).

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
    > We first create `MakeReference.tcsh` such that calls to .pl scripts are prefixed with `perl`, so that
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

[^2]: HATK (HLA Analysis Toolkit)

    > Web: <https://github.com/WansonChoi/HATK> ([docs](https://github.com/WansonChoi/HATK/tree/master/docs))
    >
    > ### Installation
    >
    > ```bash
    > git clone https://github.com/WansonChoi/HATK
    > ```
    >
    > ### Example
    >
    > Scripts extracted from the documentation example is [hatk.sh](https://github.com/cambridge-ceu/csd3/blob/master/applications/files/hatk.sh),
    >
    > In particular,
    >
    > ```bash
    > python3 HATK.py \
    >         --variants example/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18 \
    >         --hped example/wtccc_filtered_58C_RA.hatk.300+300.hped \
    >         --2field \
    >         --pheno example/wtccc_filtered_58C_RA.hatk.300+300.phe \
    >         --pheno-name RA \
    >         --out work/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18 \
    >         --imgt 3320 \
    >         --hg 18 \
    >         --imgt-dir example/IMGTHLA3320 \
    >         --multiprocess 2
    > ```
    >
    > where `--variants` reads in the genotype files and `--hped` the .hped file to be followed by specification of the RA phenotype in a logistic regression. Note that the example is more desirable compared to the toy data in SNP2HLA given its 600 samples and 29,373 variants.
    >
    > We observe screen output as follows,
    >
    > ```
    > Namespace(Ggroup=False, HLA=None, NoCaption=False, Pgroup=False, aa=None, ar=None, bmarkergenerator=False, chped=None, condition=None, condition_list=None, covar=None, covar_name=None, dict_AA=None, dict_SNPS=None, fam=None, fourF=False, hat=None, heatmap=False, hg='18', hla2hped=False, hped='example/wtccc_filtered_58C_RA.hatk.300+300.hped', imgt='3320', imgt2seq=False, imgt_dir='example/IMGTHLA3320', input=None, leave_NotFound=False, logistic=False, manhattan=False, maptable=None, metaanalysis=False, multiprocess=2, no_indel=False, nomencleaner=False, omnibus=False, oneF=False, out='MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18', phased=None, pheno='example/wtccc_filtered_58C_RA.hatk.300+300.phe', pheno_name='RA', platform=None, point_color='#778899', point_size='15', reference_allele=None, rhped=None, s1_bim=None, s1_logistic_result=None, s2_bim=None, s2_logistic_result=None, save_intermediates=False, threeF=False, top_color='#FF0000', twoF=True, variants='example/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18', yaxis_unit='10')
    >
    > [IMGT2Seq.py]: Multiprocessing.
    >
    > [ProcessIMGT.py]: Generating sequence information dictionary for HLA A.
    >
    > [ProcessIMGT.py]: Generating sequence information dictionary for HLA B.
    >
    > [ProcessIMGT.py]: Generating sequence information dictionary for HLA C.
    >
    > [ProcessIMGT.py]: Generating sequence information dictionary for HLA DPA1.
    >
    > [ProcessIMGT.py]: Generating sequence information dictionary for HLA DPB1.
    >
    > [ProcessIMGT.py]: Generating sequence information dictionary for HLA DQA1.
    >
    > [ProcessIMGT.py]: Generating sequence information dictionary for HLA DQB1.
    >
    > [ProcessIMGT.py]: Generating sequence information dictionary for HLA DRB1.
    >
    > [HLA_Study.py]: IMGT2Seq result :
    > < IMGT2Sequence(Newly generated.) >
    > - HLA Amino Acids : MyHLAStudy/HLA_DICTIONARY_AA.hg18.imgt3320
    > - HLA SNPs : MyHLAStudy/HLA_DICTIONARY_SNPS.hg18.imgt3320
    > - HLA Allele Table : MyHLAStudy/HLA_ALLELE_TABLE.imgt3320.hat
    > - Maptables for heatmap :
    >    A   : MyHLAStudy/HLA_MAPTABLE_A.hg18.imgt3320.txt
    >    B   : MyHLAStudy/HLA_MAPTABLE_B.hg18.imgt3320.txt
    >    C   : MyHLAStudy/HLA_MAPTABLE_C.hg18.imgt3320.txt
    >    DPA1: MyHLAStudy/HLA_MAPTABLE_DPA1.hg18.imgt3320.txt
    >    DPB1: MyHLAStudy/HLA_MAPTABLE_DPB1.hg18.imgt3320.txt
    >    DQA1: MyHLAStudy/HLA_MAPTABLE_DQA1.hg18.imgt3320.txt
    >    DQB1: MyHLAStudy/HLA_MAPTABLE_DQB1.hg18.imgt3320.txt
    >    DRB1: MyHLAStudy/HLA_MAPTABLE_DRB1.hg18.imgt3320.txt
    >
    >
    > [HLA_Study.py]: Given HPED file('example/wtccc_filtered_58C_RA.hatk.300+300.hped') is to be processed by NomenCleaner.
    >
    > [NomenCleaner.py]: Generating CHPED with Maximum 2 fields HLA alleles.
    >
    > [bMarkerGenerator.py]: Making Reference Panel for "MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18"
    >
    > [1] Generating Amino acid(AA)sequences from HLA types.
    > [2] Encoding Amino acids positions.
    > [3] Encoding HLA alleles.
    > [4] Generating DNA(SNPS) sequences from HLA types.
    > [5] Encoding SNP positions.
    > [6] Extracting founders.
    > [7] Merging SNP, HLA, and amino acid datasets.
    > Warning: Variants 'HLA_A*02:01' and 'HLA_A*01:01' have the same position.
    > Warning: Variants 'HLA_A*02:02' and 'HLA_A*02:01' have the same position.
    > Warning: Variants 'HLA_A*02:05' and 'HLA_A*02:02' have the same position.
    > 2924 more same-position warnings: see log file.
    > [8] Performing quality control.
    > [9] Making reference panel for HLA-AA,SNPS,HLA and Normal variants(SNPs) is Done!
    >
    > [HLA_Study.py]: bMarkerGenerator result(Prefix) :
    > MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18
    >
    > [HLA_Study.py]: Logistic Regression result :
    > MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.assoc.logistic
    >
    > [HLA_Study.py]: Manhattan result :
    > MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.manhattan.pdf
    >
    > [HLA_Study.py]: Heatmap result :
    >  A : MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.HLA_A.heatmap.pdf
    >  B : MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.HLA_B.heatmap.pdf
    >  C : MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.HLA_C.heatmap.pdf
    >  DPA1 : MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.HLA_DPA1.heatmap.pdf
    >  DPB1 : MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.HLA_DPB1.heatmap.pdf
    >  DQA1 : MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.HLA_DQA1.heatmap.pdf
    >  DQB1 : MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.HLA_DQB1.heatmap.pdf
    >  DRB1 : MyHLAStudy/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.HLA_DRB1.heatmap.pdf
    > ```
    >
    > We proceed with the imputation with the 1000Genomes panel provided with CookHLA on a real project,
    >
    > ```bash
    > export caprion=~/Caprion/analysis/HLA/CookHLA
    > export hatk=${HPC_WORK}/HATK
    > export cookhla=${HPC_WORK}/CookHLA
    >
    > cd ${cookhla}
    > python CookHLA.py \
    >        -i ${hatk}/example/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18 \
    >        -hg 18 \
    >        -o ${hatk}/work/hla_CookHLA \
    >        -ref ${cookhla}/1000G_REF/1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC \
    >        -gm ${caprion}/hla_IMPUTED.mach_step.avg.clpsB \
    >        -ae ${caprion}/hla_IMPUTED.aver.erate \
    >        -mem 20g \
    >        -mp 8
    > cd -
    > ```

[^3]: HLA-TAPAS (HLA-Typing At Protein for Association Studies)

    > Web: [https://github.com/immunogenomics/HLA-TAPAS](https://github.com/immunogenomics/HLA-TAPAS)
    >
    > ### Installation
    >
    > ```bash
    > git clone https://github.com/immunogenomics/HLA-TAPAS
    > ```
    >
    > The association tests require R packages, `argparse`, `multidplyr`, `rcompanion`, and their dependencies. The `OMNIBUS` analysis should be `OMNIBUS_LOGISTIC` or `OMNIBUS_LINEAR` instead.
    >
    > ### Example
    >
    > ```bash
    > python HLA-TAPAS.py \
    >        --target example/Case+Control.300+300.chr6.hg18 \
    >        --reference example/1000G.EUR.chr6.hg18.28mb-35mb \
    >        --hped-Ggroup example/1000G.EUR.Ggroup.hped \
    >        --pheno example/Case+Control.300+300.phe \
    >        --hg 18 \
    >        --out MyHLA-TAPAS/Case+Control+1000G_EUR_REF \
    >        --mem 4g \
    >        --nthreads 4
    > ```
    >
    > A collection of documentation example is [hla-tapas.sb](https://github.com/cambridge-ceu/csd3/blob/master/applications/files/hla-tapas.sb).

[^4]: HIBAG

    > Web: [https://hibag.s3.amazonaws.com/index.html](https://hibag.s3.amazonaws.com/index.html) ([Bioconductor](https://www.bioconductor.org/packages/release/bioc/html/HIBAG.html))
    >
    > ### Installation
    >
    > ```bash
    > Rscript -e 'BiocManager:install("HIBAG")'
    > ```
    >
    > ### Examples
    >
    > See [Amazon](https://hibag.s3.amazonaws.com/hlares_index.html#example) but most are available from [GitHub](https://zhengxwen.github.io/HIBAG/hibag_index.html#example).
