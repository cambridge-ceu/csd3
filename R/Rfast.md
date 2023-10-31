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

## 2.0.9

This is done under R 4.3.2

```bash
Rscript -e 'download.packages("Rfast",".")'
tar xvfz Rfast_2.0.9.tar.gz
R CND INSTALL Rfast
module load R/4.2.2
R CMD INSTALL Rfast
```

the second call of `R CMD INSTALL` simply take advantages of `GLIBCXX_3.4.26`. Instances can be found for instance,

> strings /usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-9.2.0-jx6bolbg5xir5al7djbzfubyojnz6tq2/lib64/libstdc++.so.6 | grep GLIBCXX

## Rfast2

It is similar to Rfast, e.g., 0.1.5.1.

## Other packages

These includes `rcdk`, which involves `R/4.2.2`.
