---
sort: 39
---

# peer

Web: GitHub, <https://github.com/PMBio/peer> ([wiki](https://github.com/PMBio/peer/wiki))

Three modules `ceuadmin/peer/[micromamba|full|1.3]` are described below.

## 1. micromamba

This enables many programs including micromamba, R package to be avaiable, e.g.,

```bash
module load ceuadmin/peer/micromamba
micromamba repoquery depends r-peer
micromamba --help
python --version
R --version
```

The first `micromama` command gives,

```
 Name      Version Build            Channel     Subdir
─────────────────────────────────────────────────────────
 libgcc-ng 13.2.0  hc881cc4_6       conda-forge linux-64
 r-base    3.4.1   h4fe35fd_8       conda-forge linux-64
 r-peer    1.3     r341h470a237_1   bioconda    linux-64
```

From the R seesion, we can use `library(peer)`.

## 2. full

This is activated with `module load ceuadmin/peer/full`, which is set up as follows,

```bash
git clone https://github.com/PMBio/peer PMBio
cd PMBio
mkdir build && cd build
export dest=/usr/local/Cluster-Apps/ceuadmin/peer/full
module load cmake/2.8 R/3.4 python/2.7
cmake -DBUILD_PEERTOOL=1 -DBUILD_R_PACKAGE=1 -DCMAKE_INSTALL_PREFIX=${dest} ..
make
sed -i 's|/usr/local/Cluster-Apps/python/2.7.5|/usr/local/Cluster-Apps/ceuadmin/peer/full|' python/cmake_install.cmake
make install
mkdir -p ${dest}/lib/R
export R_LIBS=${dest}/lib/R
cd R
R CMD INSTALL peer -l ${dest}/lib/R
## cran/ version
cd ../../cran
R CMD INSTALL peer -l ${dest}/lib/R
```

Note that R/3.4` (due to `/usr/local/software/master/R/3.4/bin/python` points to `/usr/local/software/master/R/3.4/bin/python3.7`) has to be loaded before `python/2.7`.

The `peertool`, R and python packages are accessible, e.g., 

```bash
cd examples
sed 's|./peertool|peertool|' standalone_demo.sh | bash
Rscript -e 'install.packages("qtl")'
R --no-save < r_demo.R
python python_demo.py
```

The output are briefly described here,

1. The standalone tool produces files in 11 directories with prefix `peer_out*`.
2. Later, `qtl` is installed and `r_demo.R` executed which generates `r_demo_covs.pdf`, `r_demo_nk.pdf`, and `r_demo.pdf`.
3. The Python counterpart gives `demo_simple.pdf`, `demo_covs.pdf`, and `demo_factors.pdf`.

The versioning information of the standalone application is checked with

`$CEUADMIN/peer/full/bin/peertool --version`

```
/usr/local/Cluster-Apps/ceuadmin/peer/full/bin/peertool  version: 1.0
```

The Python counterpart can also be verified with `python`,

```
Python 2.7.18 (default, Apr 24 2020, 00:37:06)
[GCC 9.3.0] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import pylab
>>> import scipy
>>> import peer
>>> peer
<module 'peer' from '/usr/local/Cluster-Apps/ceuadmin/peer/full/lib/python2.7/site-packages/peer.py'>
```

## 3. 1.3

It is called with `module load ceuadmin/peer/1.3`, a Miniconda/2 installation which follows <https://www.biostars.org/p/9461665/> (mamba is too slow to get going) and <https://bioconda.github.io/recipes/peer/README.html#package-peer>.

As shall be seen, really `Miniconda` is a platform to distribute the Linux binary and R package (No python package).

```bash
module load miniconda/2
export mypath=/rds/project/jmmh2/rds-jmmh2-public_databases/software/peer/1.3
conda create --prefix=${mypath} -c conda-forge -c bioconda r-peer
conda init bash
source ~/.bashrc
source activate ${mypath}
conda install peer
conda config --show-sources
# All requested packages already installed:
conda install micromamba
micromamba install peer
#micromamba activate /rds/project/jmmh2/rds-jmmh2-public_databases/software/peer/1.3
#micromamba run -p /rds/project/jmmh2/rds-jmmh2-public_databases/software/peer/1.3 peer
micromamba repoquery search peer
micromamba repoquery search r-peer
micromamba repoquery depends r-peer
mkdir $CEUADMIN/peer
ln -s ${mypath} $CEUADMIN/peer/1.3
module load ceuadmin/peer/1.3
cd examples
Rscript -e 'install.packages("qtl")'
R --no-save < r_demo.R
```

This is somewhat heavy going, ideally for other R packages to be installed.

Iit turns out `peertool` (<https://conda.anaconda.org/bioconda/linux-64/peer-1.3-hdbdd923_0.tar.bz2> according to `conda-meta/peer-1.3-hdbdd923_0.json`) instead of a Python package is installed.

We also have the following information,

```
peer               bioconda/linux-64::peer-1.3-hdbdd923_0
```

and `peertool --version` also gives,

```
peertool  version: 1.0
```

## OUTRIDER

We can also check if it works under a module, e.g., `ceuadmin/R`, which we usually use. The following script is extracted from `vigette("OUTRIDER")`.

```r
ctsFile <- system.file('extdata', 'KremerNBaderSmall.tsv', package='OUTRIDER')
ctsTable <- read.table(ctsFile, check.names=FALSE)
ods <- OUTRIDER::OutriderDataSet(countData=ctsTable)
ods <- OUTRIDER::filterExpression(ods, minCounts=TRUE, filterGenes=TRUE)
ods <- OUTRIDER::OUTRIDER(ods)
peer <- function(ods, maxFactors=NA, maxItr=30)
# PEER implementation
{
    if(!require(peer)){
        stop("Please install the 'peer' package from GitHub to use this ",
                "functionality.")
    }
    # default and recommendation by PEER: min(0.25*n, 100)
    maxFactors <- min(as.integer(0.25*ncol(ods)), 100)
    logCts <- log2(t(t(OUTRIDER::counts(ods)+1)/sizeFactors(ods)))
    model <- PEER()
    PEER_setNmax_iterations(model, maxItr)
    PEER_setNk(model, maxFactors)
    PEER_setPhenoMean(model, logCts)
    PEER_setAdd_mean(model, TRUE)
    PEER_update(model)
    peerResiduals <- PEER_getResiduals(model)
    peerMean <- t(t(2^(logCts - peerResiduals)) * sizeFactors(ods))
    normalizationFactors(ods) <- pmax(peerMean, 1E-8)
    metadata(ods)[["PEER_model"]] <- list(
            alpha     = PEER_getAlpha(model),
            residuals = PEER_getResiduals(model),
            W         = PEER_getW(model))
    return(ods)
}
ods <- OUTRIDER::estimateSizeFactors(ods)
ods <- peer(ods)
ods <- OUTRIDER::fit(ods)
ods <- computeZscores::computeZscores(ods, peerResiduals=TRUE)
ods <- OUTRIDER::computePvalues(ods)
ods <- OUTRIDER::plotCountCorHeatmap(ods, normalized=TRUE)
```

the rather confusing uses of `ods` seem to illustrate whereabout a `peer` model works.

## References

**DESeq2**

Love MI, Huber W, Anders S. Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. ***Genome Biol***. 2014;15(12):550. <https://doi.org/10.1186/s13059-014-0550-8>. PMID: 25516281; PMCID: PMC4302049.

**edgeR**

Zhou X, Lindsay H, Robinson MD. Robustly detecting differential expression in RNA sequencing data using observation weights. ***Nucleic Acids Res***. 2014 Jun;42(11):e91. <https://doi.org/10.1093/nar/gku310>. Epub 2014 Apr 20. PMID: 24753412; PMCID: PMC4066750.

**OUTRIDER**

Brechtmann F, Mertes C, Matusevičiūtė A, Yépez VA, Avsec Ž, Herzog M, Bader DM, Prokisch H, Gagneur J. OUTRIDER: A Statistical Method for Detecting Aberrantly Expressed Genes in RNA Sequencing Data. ***Am J Hum Genet***. 2018 Dec 6;103(6):907-917. <https://doi.org/10.1016/j.ajhg.2018.10.025>. Epub 2018 Nov 29. PMID: 30503520; PMCID: PMC6288422.

**peer**

Stegle O, Parts L, Durbin R, Winn J. A Bayesian framework to account for complex non-genetic factors in gene expression levels greatly increases power in eQTL studies. ***PLoS Comput Biol***. 2010 May 6;6(5):e1000770. <https://doi.org/10.1371/journal.pcbi.1000770>. PMID: 20463871; PMCID: PMC2865505.

Parts L, Stegle O, Winn J, Durbin R. Joint genetic analysis of gene expression data with inferred cellular phenotypes. ***PLoS Genet***. 2011 Jan 20;7(1):e1001276. <https://doi.org/10.1371/journal.pgen.1001276>. PMID: 21283789; PMCID: PMC3024309.
