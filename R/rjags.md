---
sort: 26
---

# rjags

Web page: [https://sourceforge.net/projects/mcmc-jags/files/rjags/](https://sourceforge.net/projects/mcmc-jags/files/rjags/).

## 4.16

We still mask the default `configure` command and generate a customised `Makevars`,

```
Rscript -e 'download.packages"rjags",".")
tar xvfz rjags_4-16.tar.gz
cd rjags
mv configure configure.sav
cat << 'EOL' > src/Makevars
PKG_CPPFLAGS=-I/usr/local/include/JAGS
PKG_LIBS=-L:/usr/local/lib -ljags
EOL
cd -
R CMD INSTALL rjags
```

say JAGS is with `/usr/local` -- this is generic since the script was for Fedora 38.

Once this is done, `R2jags` can also be installed.

## 4.6

It is known for sometime for its difficulty to install; here is what was done

```bash
# Cardio
export PKG_CONFIG_PATH=/scratch/$USER/lib/pkgconfig

R CMD INSTALL rjags_4-6.tar.gz --configure-args='CPPFLAGS="-fPIC" LDFLAGS="-L/scratch/$USER/lib -ljags"
--with-jags-prefix=/scratch/$USER
--with-jags-libdir=/scratch/$USER/lib
--with-jags-includedir=/scratch/$USER/include'

# csd3
export hpcwork=/rds-d4/user/$USER/hpc-work
export PKG_CONFIG_PATH=${hpcwork}/lib/pkgconfig

wget https://cran.r-project.org/src/contrib/rjags_4-10.tar.gz
R CMD INSTALL rjags_4-10.tar.gz --configure-args='CPPFLAGS="-fPIC" LDFLAGS="-L${hpcwork}/lib -ljags"
--with-jags-prefix=${hpcwork}
--with-jags-libdir=${hpcwork}/lib
--with-jags-includedir=${hpcwork}/include'
```

As is with the module `jags-4.3.0-gcc-5.4.0-4z5shby`, we would see this error message from R 4.1.0,

```
** testing if installed package can be loaded from temporary location
Error: package or namespace load failed for ‘rjags’:
 .onLoad failed in loadNamespace() for 'rjags', details:
  call: dyn.load(file, DLLpath = DLLpath, ...)
  error: unable to load shared object '/rds/user/jhz22/hpc-work/R/00LOCK-rjags/00new/rjags/libs/rjags.so':
  /rds/user/jhz22/hpc-work/R/00LOCK-rjags/00new/rjags/libs/rjags.so: undefined symbol: _ZN4jags7Console10setRNGnameERKNSt7__cxx1112basic_stringIcSt11char_t$
Error: loading failed
Execution halted
ERROR: loading failed
```

then this is due to different versions of compilers were used to build JAGS and rjags, so the former needs to be rebuilt.

## 4_13

This following can be adapted from `rjags/src` under Fedora 37 for R-devel,

```bash
g++ -std=gnu++14 -I"/home/jhz22/R-devel/include" -DNDEBUG -I/usr/local/include/JAGS -fpic -g -O2 -c jags.cc -o jags.o
g++ -std=gnu++14 -I"/home/jhz22/R-devel/include" -DNDEBUG -I/usr/local/include/JAGS -fpic -g -O2 -c parallel.cc -o parallel.o
```

This is due to call such as `#include <rng/RNGFactory.h>` as in `parallel.cc` is within /usr/local/include/JAGS.
