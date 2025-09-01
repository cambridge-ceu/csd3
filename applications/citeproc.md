---
sort: 15
---

# citeproc

Web: [https://hackage.haskell.org/package/citeproc](https://hackage.haskell.org/package/citeproc) ([GitHub](https://github.com/jgm/citeproc))

We can set up a version as follows,

```bash
cd ${HPC_WORK}/
wget -qO- https://hackage.haskell.org/package/citeproc-0.4.0.1/citeproc-0.4.0.1.tar.gz | \
tar xvfz -
cd citeproc-0.4.0.1
module load cabal/3.0.0.0 gcc/6
cabal install --installdir=${HPC_WORK}/bin exe:citeproc
```

We have error messages as follows,

```
[1 of 1] Compiling Main             ( app/Main.hs, dist/build/citeproc/citeproc-tmp/Main.o )

app/Main.hs:35:36: error:
    • Variable not in scope: (<>) :: IO () -> [Char] -> IO a0
    • Perhaps you meant one of these:
        ‘<|>’ (imported from Control.Applicative),
        ‘<$>’ (imported from Prelude), ‘*>’ (imported from Prelude)
   |
35 |     putStrLn $ "citeproc version " <> VERSION_citeproc
   |                                    ^^
cabal: Failed to build exe:citeproc from citeproc-0.4.0.1. See the build log
above for details.
```

and we change `<>` to `<|>` at line 35 of `app/Main.hs` and repeat the last command with success.

An executable file can also be generated with

```bash
cabal build --enable-executable-static
```

An example use with `pandoc`:

```bash
pandoc README.md --citeproc --mathjax -s -o index.html
```

where `README.md` contains lines,

```
---
title: Shiny for Genetic Analysis Package (gap) Designs
output:
  html_document:
    mathjax:  default
    fig_caption:  true
    toc: true
    section_numbering: true
bibliography: shinygap.bib
vignette: >
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteIndexEntry{Shiny for Genetic Analysis Package (gap) Designs}
  %\VignetteEncoding{UTF-8}
---

# Appendix: Theory for gap designs

## Family-based and population-based designs

See the R/gap package vignette jss or @zhao07.

## Case-cohort design

### Power

Following @cai04, we have
$$\Phi\left(Z_\alpha+\tilde{n}^\frac{1}{2}\theta\sqrt{\frac{p_1p_2p_D}{q+(1-q)p_D}}\right)$$

where $\alpha$ is the significance level, $\theta$ is the log-hazard ratio for
two groups, $p_j, j = 1, 2$, are the proportion of the two groups
in the population ($p_1 + p_2 = 1$), $\tilde{n}$ is the total number of subjects in the subcohort, $p_D$ is the proportion of the failures in
the full cohort, and $q$ is the sampling fraction of the subcohort.

### Sample size

$$\tilde{n}=\frac{nBp_D}{n-B(1-p_D)}$$ where $B=\frac{Z_{1-\alpha}+Z_\beta}{\theta^2p_1p_2p_D}$ and $n$ is the whole cohort size.

# References

```

and `shinygap.bib` contains two entries,

```
@article{cai04,
   author = {Cai, J. and Zeng, D.},
   title = {Sample size/power calculation for case–cohort studies},
   journal = {Biometrics},
   volume = {60},
   number = {4},
   pages = {1015-1024},
   ISSN = {1471-0056},
   DOI = {10.1111/j.0006-341X.2004.00257.x},
   year = {2004},
   pmid = {15606422},
   type = {Journal Article}
}

@article{zhao07,
   Author = {Zhao, J. H.},
   Title = {gap: genetic analysis package},
   Journal = {Journal of Statistical Software},
   Volume = {23},
   Number = {8},
   Pages = {1-18},
   Year = {2007}
}
```

We would like to use available styles as well from [https://github.com/citation-style-language/styles](https://github.com/citation-style-language/styles), after which we add the following after the command `bibliography`.

```
csl: biomed-central.csl
```
