---
sort: 31
---

# tenXplore

For 1.17.1, we received the following error,

```
Error: class "RESTfulSummarizedExperiment" is not exported by 'namespace:restfulSE'
Execution halted
ERROR: lazy loading failed for package ‘tenXplore’
```

and indeed RESTfulSE does not contain the named class. However, it does import `SummarizedExperiment` from R/SummarizedExperiment so we proceed with the fix.

```bash
Rscript -e 'download.packages("tenXplore",".",repos=BiocManager::repositories()[1])'
tar xvfz tenXplore_1.17.1.tar.gz
```

to change tenXplore/NAMESPACE and R/tenXplore.R, namely,

```
importClassesFrom(SummarizedExperiment,SummarizedExperiment)
#' @importClassesFrom SummarizedExperiment SummarizedExperiment
```

though in theory the first line can be generate from the second line with devtools::document(). We then proceed with

```bash
R CMD INSTALL tenXplore
```

From R, we conduct a test,

```r
nrows <- 200; ncols <- 6
counts <- matrix(runif(nrows * ncols, 1, 1e4), nrows)
rowRanges <- GRanges(rep(c("chr1", "chr2"), c(50, 150)),
                     IRanges(floor(runif(200, 1e5, 1e6)), width=100),
                     strand=sample(c("+", "-"), 200, TRUE),
                     feature_id=sprintf("ID%03d", 1:200))
colData <- DataFrame(Treatment=rep(c("ChIP", "Input"), 3),
                     row.names=LETTERS[1:6])
rse <- SummarizedExperiment(assays=SimpleList(counts=counts),
                            rowRanges=rowRanges, colData=colData)
rse
```

which gives

```
class: RangedSummarizedExperiment
dim: 200 6
metadata(0):
assays(1): counts
rownames: NULL
rowData names(1): feature_id
colnames(6): A B ... E F
colData names(1): Treatment
```

In fact, this test is extracted from ?SummarizedExperiment.
