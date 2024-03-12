---
sort: 28
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

This version is possible with a compatible `install.packages("StanHeaders")`. However, under R 4.3.3 built from gcc/6 there is still problem with GLIBCXX_3.4.26 seen from DescTools 0.99.54, so we switch to ceuadmin/R/4.3.3-gcc11 which installs smoothly.

We proceed to run the example 3 from `brm` function,

```r

# Survival regression modeling the time between the first
# and second recurrence of an infection in kidney patients.

library(brms)
fit <- brm(time | cens(censored) ~ age * sex + disease + (1|patient),
           data = kidney, family = lognormal())
summary(fit)
plot(fit, ask = FALSE)
plot(conditional_effects(fit), ask = FALSE)
```

giving

```
Compiling Stan program...
Start sampling

SAMPLING FOR MODEL 'anon_model' NOW (CHAIN 1).
Chain 1: Rejecting initial value:
Chain 1:   Log probability evaluates to log(0), i.e. negative infinity.
Chain 1:   Stan can't start sampling from this initial value.
Chain 1: Rejecting initial value:
Chain 1:   Log probability evaluates to log(0), i.e. negative infinity.
Chain 1:   Stan can't start sampling from this initial value.
Chain 1:
Chain 1: Gradient evaluation took 0.00047 seconds
Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 4.7 seconds.
Chain 1: Adjust your expectations accordingly!
Chain 1:
Chain 1:
Chain 1: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 1: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 1: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 1: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 1: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 1: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 1: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 1: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 1: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 1: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 1: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 1: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 1:
Chain 1:  Elapsed Time: 33.481 seconds (Warm-up)
Chain 1:                12.849 seconds (Sampling)
Chain 1:                46.33 seconds (Total)
Chain 1:

SAMPLING FOR MODEL 'anon_model' NOW (CHAIN 2).
Chain 2: Rejecting initial value:
Chain 2:   Log probability evaluates to log(0), i.e. negative infinity.
Chain 2:   Stan can't start sampling from this initial value.
Chain 2:
Chain 2: Gradient evaluation took 0.000372 seconds
Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 3.72 seconds.
Chain 2: Adjust your expectations accordingly!
Chain 2:
Chain 2:
Chain 2: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 2: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 2: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 2: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 2: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 2: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 2: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 2: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 2: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 2: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 2: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 2: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 2:
Chain 2:  Elapsed Time: 34.142 seconds (Warm-up)
Chain 2:                12.88 seconds (Sampling)
Chain 2:                47.022 seconds (Total)
Chain 2:

SAMPLING FOR MODEL 'anon_model' NOW (CHAIN 3).
Chain 3: Rejecting initial value:
Chain 3:   Log probability evaluates to log(0), i.e. negative infinity.
Chain 3:   Stan can't start sampling from this initial value.
Chain 3:
Chain 3: Gradient evaluation took 0.000378 seconds
Chain 3: 1000 transitions using 10 leapfrog steps per transition would take 3.78 seconds.
Chain 3: Adjust your expectations accordingly!
Chain 3:
Chain 3:
Chain 3: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 3: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 3: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 3: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 3: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 3: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 3: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 3: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 3: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 3: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 3: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 3: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 3:
Chain 3:  Elapsed Time: 30.619 seconds (Warm-up)
Chain 3:                12.783 seconds (Sampling)
Chain 3:                43.402 seconds (Total)
Chain 3:

SAMPLING FOR MODEL 'anon_model' NOW (CHAIN 4).
Chain 4:
Chain 4: Gradient evaluation took 0.000372 seconds
Chain 4: 1000 transitions using 10 leapfrog steps per transition would take 3.72 seconds.
Chain 4: Adjust your expectations accordingly!
Chain 4:
Chain 4:
Chain 4: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 4: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 4: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 4: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 4: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 4: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 4: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 4: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 4: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 4: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 4: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 4: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 4:
Chain 4:  Elapsed Time: 33.639 seconds (Warm-up)
Chain 4:                13.336 seconds (Sampling)
Chain 4:                46.975 seconds (Total)
Chain 4:
> summary(fit)
 Family: lognormal
  Links: mu = identity; sigma = identity
Formula: time | cens(censored) ~ age * sex + disease + (1 | patient)
   Data: kidney (Number of observations: 76)
  Draws: 4 chains, each with iter = 2000; warmup = 1000; thin = 1;
         total post-warmup draws = 4000

Group-Level Effects:
~patient (Number of levels: 38)
              Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
sd(Intercept)     0.42      0.25     0.03     0.93 1.00      811     1655

Population-Level Effects:
              Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
Intercept         2.63      0.95     0.71     4.54 1.00     2416     2745
age               0.02      0.02    -0.03     0.06 1.00     2083     2572
sexfemale         2.57      1.12     0.39     4.87 1.00     2136     2373
diseaseGN        -0.43      0.51    -1.46     0.55 1.00     2912     3017
diseaseAN        -0.55      0.49    -1.53     0.41 1.00     3225     2610
diseasePKD        0.56      0.71    -0.86     1.98 1.00     3377     2972
age:sexfemale    -0.03      0.03    -0.08     0.02 1.00     2173     2460

Family Specific Parameters:
      Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
sigma     1.16      0.13     0.92     1.43 1.00     2140     2025

Draws were sampled using sampling(NUTS). For each parameter, Bulk_ESS
and Tail_ESS are effective sample size measures, and Rhat is the potential
scale reduction factor on split chains (at convergence, Rhat = 1).
> plot(fit, ask = FALSE)
> plot(conditional_effects(fit), ask = FALSE)
```
