---
sort: 1
---

# brms

It is available from CRAN, so it can be installed with `install.packages()`. Here is a documentation example,

```r
  library(brms)
# Survival regression modeling the time between the first
# and second recurrence of an infection in kidney patients.
  fit3 <- brm(time | cens(censored) ~ age * sex + disease + (1|patient),
              data = kidney, family = lognormal())
  summary(fit3)
  plot(fit3, ask = FALSE)
  plot(conditional_effects(fit3), ask = FALSE)
  fit3cox <- brm(time | cens(censored) ~ age * sex + disease + (1|patient),
                 data = kidney, family = family('cox'))
  summary(fit3cox)
  plot(fit3cox, ask = FALSE)
```

In case of compilng error, it is necessary to use the developmental version of rstan (2.21.3 at the time of writing), see below.

## 2.20.4

It turns out that this version compiles well under module `ceuadmin/R/4.3.3`.
