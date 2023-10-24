---
sort: 43
---

# regenie

Web: [https://github.com/rgcgithub/regenie](https://github.com/rgcgithub/regenie) ([documentation](https://rgcgithub.github.io/regenie/))

It is the easiest to use the Centos 7 distribution,

```bash
export version=v2.2.4
wget -qO- https://github.com/rgcgithub/regenie/releases/download/${version}/regenie_${version}.gz_x86_64_Centos7_mkl.zip | \
gunzip -c > regenie_${version}
chmod +x regenie_${version}
ln -sf regenie_${version} regenie
regenie --help
```

The last command gives the following information (Why .gz in the banner?),

```
              |=============================|
              |      REGENIE v2.2.4.gz      |
              |=============================|

Copyright (c) 2020-2021 Joelle Mbatchou, Andrey Ziyatdinov and Jonathan Marchini.
Distributed under the MIT License.
Compiled with Boost Iostream library.
Using Intel MKL with Eigen.


Usage:
  regenie [OPTION...]

  -h, --help      print list of available options
      --helpFull  print list of all available options

 Main options:
      --step INT                specify if fitting null model (=1) or
                                association testing (=2)
      --bed PREFIX              prefix to PLINK .bed/.bim/.fam files
      --pgen PREFIX             prefix to PLINK2 .pgen/.pvar/.psam files
      --bgen FILE               BGEN file
      --sample FILE             sample file corresponding to BGEN file
      --ref-first               use the first allele as the reference for
                                BGEN or PLINK bed/bim/fam input format [default
                                assumes reference is last]
      --keep FILE               comma-separated list of files listing samples
                                to retain in the analysis (no header; starts
                                with FID IID)
      --remove FILE             comma-separated list of files listing samples
                                to remove from the analysis (no header;
                                starts with FID IID)
      --extract FILE            comma-separated list of files with IDs of
                                variants to retain in the analysis
      --exclude FILE            comma-separated list of files with IDs of
                                variants to remove from the analysis
  -p, --phenoFile FILE          phenotype file (header required starting with
                                FID IID)
      --phenoCol STRING         phenotype name in header (use for each
                                phenotype to keep; can use parameter expansion
                                {i:j})
      --phenoColList STRING,..,STRING
                                comma separated list of phenotype names to
                                keep (can use parameter expansion {i:j})
  -c, --covarFile FILE          covariate file (header required starting with
                                FID IID)
      --covarCol STRING         covariate name in header (use for each
                                covariate to keep; can use parameter expansion
                                {i:j})
      --covarColList STRING,..,STRING
                                comma separated list of covariate names to
                                keep (can use parameter expansion {i:j})
      --catCovarList STRING,..,STRING
                                comma separated list of categorical
                                covariates
  -o, --out PREFIX              prefix for output files
      --qt                      analyze phenotypes as quantitative
      --bt                      analyze phenotypes as binary
  -1, --cc12                    use control=1,case=2,missing=NA encoding for
                                binary traits
  -b, --bsize INT               size of genotype blocks
      --cv INT(=5)              number of cross validation (CV) folds
      --loocv                   use leave-one out cross validation (LOOCV)
      --l0 INT(=5)              number of ridge parameters to use when
                                fitting models within blocks [evenly spaced in
                                (0,1)]
      --l1 INT(=5)              number of ridge parameters to use when
                                fitting model across blocks [evenly spaced in (0,1)]
      --lowmem                  reduce memory usage by writing level 0
                                predictions to temporary files
      --lowmem-prefix PREFIX    prefix where to write the temporary files in
                                step 1 (default is to use prefix from --out)
      --split-l0 PREFIX,N       split level 0 across N jobs and set prefix of
                                output files
      --run-l0 FILE,K           run level 0 for job K in {1..N} using master
                                file created from '--split-l0'
      --run-l1 FILE             run level 1 using master file from
                                '--split-l0'
      --keep-l0                 avoid deleting the level 0 predictions
                                written on disk after fitting the level 1 models
      --strict                  remove all samples with missingness at any of
                                the traits
      --print-prs               also output polygenic predictions without
                                using LOCO (=whole genome PRS)
      --gz                      compress output files (gzip format)
      --apply-rint              apply Rank-Inverse Normal Transformation to
                                quantitative traits
      --threads INT             number of threads
      --pred FILE               file containing the list of predictions files
                                from step 1
      --ignore-pred             skip reading predictions from step 1
                                (equivalent to linear/logistic regression with only
                                covariates)
      --use-prs                 when using whole genome PRS step 1 output in
                                '--pred'
      --write-samples           write IDs of samples included for each trait
                                (only in step 2)
      --minMAC FLOAT(=5)        minimum minor allele count (MAC) for tested
                                variants
      --minINFO DOUBLE(=0)      minimum imputation info score (Impute/Mach
                                R^2) for tested variants
      --no-split                combine asssociation results into a single
                                for all traits
      --firth                   use Firth correction for p-values less than
                                threshold
      --approx                  use approximation to Firth correction for
                                computational speedup
      --spa                     use Saddlepoint approximation (SPA) for
                                p-values less than threshold
      --pThresh FLOAT(=0.05)    P-value threshold below which to apply
                                Firth/SPA correction
      --write-null-firth        store coefficients from null models with
                                approximate Firth for step 2
      --compute-all             store Firth estimates for all chromosomes
      --use-null-firth FILE     use stored coefficients for null model in
                                approximate Firth
      --chr STRING              specify chromosome to test in step 2 (use for
                                each chromosome)
      --chrList STRING,..,STRING
                                Comma separated list of chromosomes to test
                                in step 2
      --range CHR:MINPOS-MAXPOS
                                to specify a physical position window for
                                variants to test in step 2
      --sex-specific STRING     for sex-specific analyses (male/female)
      --af-cc                   print effect allele frequencies among
                                cases/controls for step 2
      --test STRING             'additive', 'dominant' or 'recessive'
                                (default is additive test)
      --set-list FILE           file with sets definition
      --extract-sets FILE       comma-separated list of files with IDs of
                                sets to retain in the analysis
      --exclude-sets FILE       comma-separated list of files with IDs of
                                sets to remove from the analysis
      --extract-setlist STRING  comma separated list of sets to retain in the
                                analysis
      --exclude-setlist STRING  comma separated list of sets to remove from
                                the analysis
      --anno-file FILE          file with variant annotations
      --anno-labels FILE        file with labels to annotations
      --mask-def FILE           file with mask definitions
      --aaf-file FILE           file with AAF to use when building masks
      --aaf-bins FLOAT,..,FLOAT
                                comma separated list of AAF bins cutoffs for
                                building masks
      --build-mask STRING       rule to construct masks, can be 'max', 'sum'
                                or 'comphet' (default is max)
      --singleton-carrier       define singletons as variants with a single
                                carrier in the sample
      --write-mask              write masks in PLINK bed/bim/fam format
      --mask-lovo STRING        apply Leave-One-Variant-Out (LOVO) scheme
                                when building masks
                                (<set_name>,<mask_name>,<aaf_cutoff>)
      --mask-lodo STRING        apply Leave-One-Domain-Out (LODO) scheme when
                                building masks
                                (<set_name>,<mask_name>,<aaf_cutoff>)
      --skip-test               skip computing association tests after
                                building masks
      --check-burden-files      check annotation file, set list file and mask
                                file for consistency
      --strict-check-burden     to exit early if the annotation, set list and
                                mask definition files don't agree

For more information, use option '--help' or visit the website: https://rgcgithub.github.io/regenie/

```

## 3.2.7

We could compile from source,

```bash
cd ~/rds/public_databases/software/
wget -qO- https://github.com/rgcgithub/regenie/archive/refs/tags/v3.2.7.tar.gz | \
tar xvfz -
cd regenie-3.2.7/
export BGEN_PATH=~/rds/public_databases/software/bgen
module load zlib/1.2.11
export ZLIB_LIBRARY=/usr/local/Cluster-Apps/zlib/1.2.11
module load gcc/6
module load cmake-3.19.7-gcc-5.4-5gbsejo
module load intel/mkl/mic/2018.4
mkdir build
cd build
cmake ..
make
```

where the bgen and zlib libraries are indicated; module `gcc/6` and `cmake-3.19.7` are also necessary to get around some other errors.

Note that `module load intel/mkl/mic/2018.4` is optional but desirable, and now we have

```
              |============================|
              |        REGENIE v3.2.7      |
              |============================|

Copyright (c) 2020-2022 Joelle Mbatchou, Andrey Ziyatdinov and Jonathan Marchini.
Distributed under the MIT License.
Using Intel MKL with Eigen.


Usage:
  ./regenie-3.2.7 [OPTION...]

  -h, --help      print list of available options
      --helpFull  print list of all available options

 Main options:
      --step INT                specify if fitting null model (=1) or 
                                association testing (=2)
      --bed PREFIX              prefix to PLINK .bed/.bim/.fam files
      --pgen PREFIX             prefix to PLINK2 .pgen/.pvar/.psam files
      --bgen FILE               BGEN file
      --sample FILE             sample file corresponding to BGEN file
      --ref-first               use the first allele as the reference for 
                                BGEN or PLINK bed/bim/fam input format 
                                [default assumes reference is last]
      --keep FILE               comma-separated list of files listing 
                                samples to retain in the analysis (no 
                                header; starts with FID IID)
      --remove FILE             comma-separated list of files listing 
                                samples to remove from the analysis (no 
                                header; starts with FID IID)
      --extract FILE            comma-separated list of files with IDs of 
                                variants to retain in the analysis
      --exclude FILE            comma-separated list of files with IDs of 
                                variants to remove from the analysis
  -p, --phenoFile FILE          phenotype file (header required starting 
                                with FID IID)
      --phenoCol STRING         phenotype name in header (use for each 
                                phenotype to keep; can use parameter 
                                expansion {i:j})
      --phenoColList STRING,..,STRING
                                comma separated list of phenotype names to 
                                keep (can use parameter expansion {i:j})
  -c, --covarFile FILE          covariate file (header required starting 
                                with FID IID)
      --covarCol STRING         covariate name in header (use for each 
                                covariate to keep; can use parameter 
                                expansion {i:j})
      --covarColList STRING,..,STRING
                                comma separated list of covariate names to 
                                keep (can use parameter expansion {i:j})
      --catCovarList STRING,..,STRING
                                comma separated list of categorical 
                                covariates
  -o, --out PREFIX              prefix for output files
      --qt                      analyze phenotypes as quantitative
      --bt                      analyze phenotypes as binary
  -1, --cc12                    use control=1,case=2,missing=NA encoding 
                                for binary traits
  -b, --bsize INT               size of genotype blocks
      --cv INT(=5)              number of cross validation (CV) folds
      --loocv                   use leave-one out cross validation (LOOCV)
      --l0 INT(=5)              number of ridge parameters to use when 
                                fitting models within blocks [evenly spaced 
                                in (0,1)]
      --l1 INT(=5)              number of ridge parameters to use when 
                                fitting model across blocks [evenly spaced 
                                in (0,1)]
      --lowmem                  reduce memory usage by writing level 0 
                                predictions to temporary files
      --lowmem-prefix PREFIX    prefix where to write the temporary files 
                                in step 1 (default is to use prefix from 
                                --out)
      --split-l0 PREFIX,N       split level 0 across N jobs and set prefix 
                                of output files
      --run-l0 FILE,K           run level 0 for job K in {1..N} using 
                                master file created from '--split-l0'
      --run-l1 FILE             run level 1 using master file from 
                                '--split-l0'
      --l1-phenoList STRING,...,STRING
                                run level 1 for a subset of the phenotypes 
                                (specified as comma-separated list)
      --keep-l0                 avoid deleting the level 0 predictions 
                                written on disk after fitting the level 1 
                                models
      --strict                  remove all samples with missingness at any 
                                of the traits
      --print-prs               also output polygenic predictions without 
                                using LOCO (=whole genome PRS)
      --gz                      compress output files (gzip format)
      --apply-rint              apply Rank-Inverse Normal Transformation to 
                                quantitative traits
      --apply-rerint            apply Rank-Inverse Normal Transformation to 
                                residualized quantitative traits in step 2
      --apply-rerint-cov        apply Rank-Inverse Normal Transformation to 
                                residualized quantitative traits and 
                                project covariates out in step 2
      --threads INT             number of threads
      --pred FILE               file containing the list of predictions 
                                files from step 1
      --ignore-pred             skip reading predictions from step 1 
                                (equivalent to linear/logistic regression 
                                with only covariates)
      --use-prs                 when using whole genome PRS step 1 output 
                                in '--pred'
      --write-samples           write IDs of samples included for each 
                                trait (only in step 2)
      --minMAC FLOAT(=5)        minimum minor allele count (MAC) for tested 
                                variants
      --minINFO DOUBLE(=0)      minimum imputation info score (Impute/Mach 
                                R^2) for tested variants
      --no-split                combine asssociation results into a single 
                                for all traits
      --firth                   use Firth correction for p-values less than 
                                threshold
      --approx                  use approximation to Firth correction for 
                                computational speedup
      --spa                     use Saddlepoint approximation (SPA) for 
                                p-values less than threshold
      --pThresh FLOAT(=0.05)    P-value threshold below which to apply 
                                Firth/SPA correction
      --write-null-firth        store coefficients from null models with 
                                approximate Firth for step 2
      --compute-all             store Firth estimates for all chromosomes
      --use-null-firth FILE     use stored coefficients for null model in 
                                approximate Firth
      --chr STRING              specify chromosome to test in step 2 (use 
                                for each chromosome)
      --chrList STRING,..,STRING
                                Comma separated list of chromosomes to test 
                                in step 2
      --range CHR:MINPOS-MAXPOS
                                to specify a physical position window for 
                                variants to test in step 2
      --sex-specific STRING     for sex-specific analyses (male/female)
      --af-cc                   print effect allele frequencies among 
                                cases/controls for step 2
      --test STRING             'additive', 'dominant' or 'recessive' 
                                (default is additive test)
      --condition-list FILE     file with list of variants to include as 
                                covariates
      --condition-file FORMAT,FILE
                                optional genotype file which contains the 
                                variants to include as covariates
      --condition-file-sample FILE
                                sample file accompanying BGEN file with the 
                                conditional variants
      --interaction STRING      perform interaction testing with a 
                                quantitative/categorical covariate
      --interaction-snp STRING  perform interaction testing with a variant
      --interaction-file FORMAT,FILE
                                optional genotype file which contains the 
                                variant for GxG interaction test
      --interaction-file-sample FILE
                                sample file accompanying BGEN file with the 
                                interacting variant
      --interaction-file-reffirst
                                use the first allele as the reference for 
                                the BGEN or PLINK file with the interacting 
                                variant [default assumes reference is last]
      --interaction-prs         perform interaction testing with the full 
                                PRS from step 1
      --force-condtl            to also condition on interacting SNP in the 
                                marginal GWAS test
      --no-condtl               to print out all main effects in GxE 
                                interaction test
      --rare-mac FLOAT(=1000)   minor allele count (MAC) threshold below 
                                which to use HLM for interaction testing 
                                with QTs
      --set-list FILE           file with sets definition
      --extract-sets FILE       comma-separated list of files with IDs of 
                                sets to retain in the analysis
      --exclude-sets FILE       comma-separated list of files with IDs of 
                                sets to remove from the analysis
      --extract-setlist STRING  comma separated list of sets to retain in 
                                the analysis
      --exclude-setlist STRING  comma separated list of sets to remove from 
                                the analysis
      --anno-file FILE          file with variant annotations
      --anno-labels FILE        file with labels to annotations
      --mask-def FILE           file with mask definitions
      --aaf-file FILE           file with AAF to use when building masks
      --set-singletons          use 0/1 indicator in third column of AAF 
                                file to specify singleton variants
      --aaf-bins FLOAT,..,FLOAT
                                comma separated list of AAF bins cutoffs 
                                for building masks
      --build-mask STRING       rule to construct masks, can be 'max', 
                                'sum' or 'comphet' (default is max)
      --vc-tests STRING,..,STRING
                                comma separated list of tests to compute 
                                for each set of variants included in a mask 
                                [skat/skato/skato-acat/acatv/acato]
      --vc-maxAAF FLOAT(=1)     maximum AAF for variants included in 
                                gene-based tests
      --weights-col arg         column index (1-based) for user-defined 
                                weights in annotation file
      --multiply-weights        multiply the user defined weights by the 
                                default SKAT weights in SKAT/ACAT tests
      --joint STRING            comma spearated list of joint tests to 
                                perform
      --singleton-carrier       define singletons as variants with a single 
                                carrier in the sample
      --write-mask              write masks in PLINK bed/bim/fam format
      --mask-lovo STRING        apply Leave-One-Variant-Out (LOVO) scheme 
                                when building masks 
                                (<set_name>,<mask_name>,<aaf_cutoff>)
      --mask-lodo STRING        apply Leave-One-Domain-Out (LODO) scheme 
                                when building masks 
                                (<set_name>,<mask_name>,<aaf_cutoff>)
      --skip-test               skip computing association tests after 
                                building masks
      --check-burden-files      check annotation file, set list file and 
                                mask file for consistency
      --strict-check-burden     to exit early if the annotation, set list 
                                and mask definition files don't agree
      --force-qt                force QT run for traits with few unique 
                                values
      --par-region STRING(=hg38)
                                build code to identify PAR region 
                                boundaries on chrX

For more information, use option '--help' or visit the website: https://rgcgithub.github.io/regenie/
```

## Reference

Mbatchou, J., Barnard, L., Backman, J. et al. Computationally efficient whole-genome regression for quantitative and binary traits. _Nat Genet_ 53, 1097–1103 (2021). <https://doi.org/10.1038/s41588-021-00870-7>
