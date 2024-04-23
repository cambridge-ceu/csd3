---
sort: 43
---

# qtltools

Web: [https://github.com/qtltools/qtltools](https://github.com/qtltools/qtltools) ([documentation](https://qtltools.github.io/qtltools/)).

## Installation

We can obtain the source from GitHub and run the setup script,

```bash
module load gcc/6
module load pcre/8.38
module load texlive
git clone https://github.com/qtltools/qtltools
cd qtltools
install_script.sh
cp bin/QTLtools ${HPC_WORK}/bin
```

The first three modules are actually for R, simply to be in line with other setup.

Although most software listed in the script are duplicated, it seems easiser to keep them intact. Upon completion, the following message is seen,

> Script succesfully completed. If you want to install QTLtools please type (as root): make install. You may want to delete the install and downloads directories as well.

## Usage

With

```bash
QTLtools
```

and we get

```
QTLtools
  * Authors : Olivier DELANEAU / Halit ONGEN / Emmanouil DERMITZAKIS
  * Contact : olivier.delaneau@gmail.com / halit.ongen@unige.ch / Emmanouil.Dermitzakis@unige.ch
  * Webpage : https://qtltools.github.io/qtltools/
  * Version : 1.3.1-25-g6e49f85f20
  * Date    : 02/02/2022 - 20:35:44
  * Citation: A complete tool set for molecular QTL discovery and analysis, https://doi.org/10.1038/ncomms15452

Usage:
  QTLtools [mode] [options]
  eg: QTLtools cis --help

Available modes:
  bamstat   Calculate basic QC metrics for BAM/SAM
  mbv       Match BAM to VCF
  pca       Calculate principal components for a BED/VCF/BCF file
  correct   Covariate correction of a BED file
  cis       cis QTL analysis
  trans     trans QTL analysis
  fenrich   Functional enrichment for QTLs
  fdensity  Functional density around QTLs
  genrich   GWAS enrichment for QTLs
  rtc       Regulatory Trait Concordance analysis
  rtc-union Find the union of QTLs
  extract   Data extraction mode
  quan      Quantification mode
  ase       Measure allelic imbalance at every het genotype
  rep       Replicate QTL associations into independent data set
  gwas      GWAS tests
```
