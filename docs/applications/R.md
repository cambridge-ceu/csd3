---
sort: 31
---

# R

To compile all the PDF documentations, load texlive.

```bash
module load gcc/6
module load pcre/8.38
module load texlive
wget https://cran.r-project.org/src/base/R-4/R-4.0.0.tar.gz
tar xvfz R-4.0.0.tar.gz
cd R-4.0.0
export prefix=/rds-d4/user/$USER/hpc-work
./configure --prefix=${prefix} \
            --with-pcre1 \
            --enable-R-shlib CPPFLAGS=-I${prefix}/include LDFLAGS=-L${prefix}/lib
make
make install
```

With this setup, `R CMD check --as-cran` for a CRAN package check can be run smoothly.

Package reinstallation could be done with `update.packages(checkBuilt = TRUE, ask = FALSE)`.

It may complain about libiconv.so.2,

> ... R: error while loading shared libraries: libiconv.so.2: cannot open shared object file: No such file or directory

which can be installed as follows,

```bash
wget -qO- https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.16.tar.gz | tar xvfz -
cd libiconv-1.16
./configure --prefix=${HPC_WORK}
make
make install
```
