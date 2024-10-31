---
sort: 32
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

## 2.32.6

This version is possible with a compatible `install.packages("StanHeaders")`. However, under R 4.3.3 built from gcc/6 there is still problem with GLIBCXX_3.4.29 similarly seen from DescTools 0.99.54, so we switch to ceuadmin/R/4.3.3-gcc11 which installs smoothly.

Simiarly, rstanarm 2.32.1 installation goes well under ceuadmin/R/4.3.3-gcc11.

```r
library(rstanarm)
example(example_model)
print(example_model, digits = 1)
```

giving

```
stan_glmer
 family:       binomial [logit]
 formula:      cbind(incidence, size - incidence) ~ size + period + (1 | herd)
 observations: 56
------
            Median MAD_SD
(Intercept) -1.5    0.6
size         0.0    0.0
period2     -1.0    0.3
period3     -1.1    0.3
period4     -1.6    0.4

Error terms:
 Groups Name        Std.Dev.
 herd   (Intercept) 0.77
Num. levels: herd 15

------
* For help interpreting the printed output see ?print.stanreg
* For info on the priors used see ?prior_summary.stanreg
>      print(example_model, digits = 1)
stan_glmer
 family:       binomial [logit]
 formula:      cbind(incidence, size - incidence) ~ size + period + (1 | herd)
 observations: 56
------
            Median MAD_SD
(Intercept) -1.5    0.6
size         0.0    0.0
period2     -1.0    0.3
period3     -1.1    0.3
period4     -1.6    0.4

Error terms:
 Groups Name        Std.Dev.
 herd   (Intercept) 0.77
Num. levels: herd 15

------
* For help interpreting the printed output see ?print.stanreg
* For info on the priors used see ?prior_summary.stanreg
```
