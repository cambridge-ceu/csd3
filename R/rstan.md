---
sort: 22
---

# R/rstan

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
