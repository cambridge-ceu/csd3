---
sort: 18
---

# Rfast

For 2.0.4, we received the following error,

```
Error: C++17 standard requested but CXX17 is not defined
```

To proceed, we modify ~/.R/Makevars with the following line

```
CXX17 = g++ -std=gnu++17 -fPIC
```

We can get away with this,

```bash
module load gcc/6
Rscript -e "install.packages('Rfast')"
```

## 2.0.8

Actaully the requirement for C++17 is explicitly stated, <https://cran.r-project.org/package=Rfast>.

```bash
module load R/4.2.2
Rscript -e 'install.packages("Rfast")'
```

## Rfast2

It is similar to Rfast, e.g., 0.1.5.
