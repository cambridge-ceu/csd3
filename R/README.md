---
sort: 3
---

# R packages

source: `{{ page.path }}`

For completeness, here is the counterpart for `biopython`

```r
library(Biostrings)
fasta_file_path <- 'P04217.fasta'
fasta_sequences <- readAAStringSet(fasta_file_path, format = "fasta")
first_sequence <- fasta_sequences[[1]]
cat("Sequence:", toString(first_sequence), "\n")
search_442688365 <- 'TDGEGALSEPSATVTIEELAAPPPPVLMHHGESSQVLHPGNK'
match_position <- regexpr(search_442688365, first_sequence)
```

and the output is longer,

```
> match_position
[1] 186
attr(,"match.length")
[1] 42
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
```

Here is a list of (well, most likely to be difficult to install/update) R packages.

As noted elsewhere, most packages are compiled under `gcc/6` -- at time of writing this is gcc 6.5.0. Most likely packages will be compiled given C++17, which is furnished with `~/.R/Makevars` containing the following lines.

```
CXX17 = g++ -std=gnu++17 -fPIC
```

Occasionally, package(s) such as `glmnet` will indicate this, a practice that facilitates installation greatly.

{% include list.liquid all=true %}

:star: **[R website](https://www.r-project.org/)**
