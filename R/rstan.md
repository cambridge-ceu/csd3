---
sort: 26
---

# rstan

Official page: [https://mc-stan.org/users/interfaces/rstan](https://mc-stan.org/users/interfaces/rstan) and also [https://cran.r-project.org/package=rstan](https://cran.r-project.org/package=rstan).

It is necessary to have `¬/.R/Makevars` the following lines,

```
CXX14 = g++ -fPIC -std=gnu++11 -fext-numeric-literals
```

to deal with `error: unable to find numeric literal operator 'operator""Q'` but

```
CXX14 = g++ -std=c++1y -fPIC
```

to do away with the error message ``C++14 standard requested but CXX14 is not defined`.

In case `ggplot2` installed with `gcc 5.2.0` it is also necessary to preceed with `module load gcc/5`.

For the developmental version, try `remotes::install_github("stan-dev/rstan", ref = "develop", subdir = "rstan/rstan")`.

## StanHeaders

This is required by `rstan` and much more versioned than CRAN.

```r
remotes::install_github("stan-dev/rstan/StanHeaders", ref = "develop")
```

After this, rstan_2.33.1.9000 also installs under gcc/6 and C++17.

## rstanarm

The following command follows suit,

```r
remotes::install_github("stan-dev/rstanarm", INSTALL_opts = "--no-multiarch", force = TRUE)
```

A version with survival analysis is done with,

```r
install.packages("rstanarm", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
```
