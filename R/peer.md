---
sort: 15
---

# peer

An R package is done as follows,

```bash
git clone https://github.com/PMBio/peer PMBio
cd PMBio
module load cmake/2.8 python/2.7
mkdir build && cd build
module load R/3.4
cmake -DBUILD_R_PACKAGE=1 ..
make
## build/ version
cd R
R CMD INSTALL peer -l ..
## cran/ version
cd ../../cran
R CMD INSTALL peer -l ..
```

Therefore the R package has to be called using module `R/3.4`, such as `library(peer,lib.loc='/rds/project/jmmh2/rds-jmmh2-public_databases/software/peer/PMBio')`.

We can check if it works under module `ceuadmin/R`. The following script is extracted from `vigette("OUTRIDER")`.

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

which is rather confusing with so many uses of `ods`.

The following records its setup using conda, <https://www.biostars.org/p/9461665/>

```bash
module load miniconda/2
export mypath=/rds/project/jmmh2/rds-jmmh2-public_databases/software/peer/1.3
conda create --prefix=${mypath} -c conda-forge -c bioconda r-peer
conda init bash
source ~/.bashrc
source activate ${mypath}
# This mirrors snakemake but proves optional:
# conda install -c conda-forge mamba
# mamba repoquery depends -a r-peer
# module
ln -s ${mypath} $CEUADMIN/peer/1.3
module load ceuadmin/peer/1.3
cd examples
Rscript -e 'install.packages("qtl")'
R --no-save < r_demo.R
```

This is somewhat heavy going, ideally for other R packages to be installed. In this case, `qtl` is installed and `r_demo.R` is executed and obtains `r_demo_covs.pdf`, `r_demo_nk.pdf`, and `r_demo.pdf`.
