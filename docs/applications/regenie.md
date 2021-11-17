---
sort: 39
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

## Reference

Mbatchou, J., Barnard, L., Backman, J. et al. Computationally efficient whole-genome regression for quantitative and binary traits. Nat Genet 53, 1097–1103 (2021). https://doi.org/10.1038/s41588-021-00870-7
