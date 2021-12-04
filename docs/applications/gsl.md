---
sort: 17
---

# R/gsl

When there is message,

```
configure: error: Need GSL version >= 1.16
ERROR: configuration failed for package ‘gsl’
* removing ‘/rds/user/jhz22/hpc-work/R/gsl’
* restoring previous ‘/rds/user/jhz22/hpc-work/R/gsl’

The downloaded source packages are in
        ‘/tmp/Rtmp5Qygwr/downloaded_packages’
Warning message:
In install.packages("gsl") :
  installation of package ‘gsl’ had non-zero exit status
```

Our first attempt is to load modules as for `R/gnn`

```bash
module avail gsl
module load gsl/2.4
```

Unfortunately, the same error message remains.

Our second attempt is to install from source

```bash
Rscript -e 'download.packages("gsl",".")'
tar xvfz gsl_2.1-7.tar.gz
cd gsl
mv configure configure.sav
cd -
gsl-config --cflags
gsl-config --libs
```

where we mask the default `configure` and the latter two commands give

```
-I/usr/local/Cluster-Apps/gsl/2.4/include
-L/usr/local/Cluster-Apps/gsl/2.4/lib -lgsl -lgslcblas -lm
```

and we use template `Markvars.in` from gsl/src/ and create `Makevars` with the following contents,

```
# Kindly supplied by Dirk Eddelbuettel
# set by configure
GSL_CFLAGS = -I/usr/local/Cluster-Apps/gsl/2.4/include
GSL_LIBS   = -L/usr/local/Cluster-Apps/gsl/2.4/lib -lgsl -lgslcblas -lm

# combine to standard arguments for R
PKG_CPPFLAGS =  $(GSL_CFLAGS) -I.
PKG_LIBS = $(GSL_LIBS)
```

Now our installation is succesful with

```bash
R CMD INSTALL gsl
```

Note that it was proposed on the web to use an equivalence of `CFLAGS=$(gsl-config --cflags) LDFLAGS=$(gsl-config --cflags) R` and try `install.packages("gsl")` but that does not work, either.

## gsl_2.1-7.1

The requires more recent version of GNU gsl and we illustrate with 2.7 below.

```bash
wget -qO- https://mirror.ibcp.fr/pub/gnu/gsl/gsl-latest.tar.gz | \
tar xfz -
cd gsl-2.7/
configure --prefix=${HPC_WORK}
make
make install
Rscript -e 'install.packages("gsl")'
```
