---
sort: 3
---

# R packages

source: `{{ page.path }}`

:star: **[R website](https://www.r-project.org/)**

Here is a list of (well, most likely to be difficult to install/update) R packages.

As noted elsewhere, most packages are compiled under `gcc/6` -- at time of writing this is gcc 6.5.0. Most likely packages will be compiled given C++17, which is furnished with `~/.R/Makevars` containing the following lines.

```
CXX17 = g++ -std=gnu++17 -fPIC
```

Occasionally, package(s) such as `glmnet` will indicate this, a practice that facilitates installation greatly.

{% include list.liquid all=true %}

For completeness, here is the counterpart for `biopython`

```r
library(Biostrings)
fasta_file_path <- 'https://rest.uniprot.org/uniprotkb/P04217.fasta'
fasta_sequences <- readAAStringSet(fasta_file_path, format = "fasta")
AA_sequence <- fasta_sequences[[1]]
cat("Sequence:", toString(AA_sequence), "\n")
iso_442688365 <- 'TDGEGALSEPSATVTIEELAAPPPPVLMHHGESSQVLHPGNK'
match_position <- regexpr(iso_442688365, AA_sequence)
match_position
mp <- matchPattern(iso_442688365,AA_sequence)
mp
```

which handles URL and generates more informative output,

```
> match_position
[1] 186
attr(,"match.length")
[1] 42
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
> mp <- matchPattern(iso_442688365,AA_sequence)
> mp
Views on a 495-letter AAString subject
subject: MSMLVVFLLLWGVTWGPVTEAAIFYETQPSLWAESESLLKPLANVTLTCQAHLETPDFQLFKNGVAQEPVHLDSPAIKHQFLLTGDTQGRYRCR...RPQLRATWSGAVLAGRDAVLRCEGPIPDVTFELLREGETKAVKTVRTPGAAANLELIFVGPQHAGNYRCRYRSWVPHTFESELSDPVELLVAES
views:
      start end width
  [1]   186 227    42 [TDGEGALSEPSATVTIEELAAPPPPVLMHHGESSQVLHPGNK]
```
