---
sort: 46
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

## libiconv

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

## cclake

As CSD3 often experiences problem from the login nodes, it is desirable to use `login-icelake.hpc.cam.ac.uk`.

However, there will be complaints about availability of libreadline.so.6 and then libiccuuc.so.50 which can be got around with their installations.

```
error while loading shared libraries: libreadline.so.6: cannot open shared object file: No such file or directory
...
error while loading shared libraries: libicuuc.so.50: cannot open shared object file: No such file or directory
...
error while loading shared libraries: libgnutls.so.28: cannot open shared object file: No such file or directory
```

The setup below complies with ordinary login nodes.

```bash
wget -qO- --no-check-certificate https://ftp.gnu.org/pub/pub/gnu/readline/readline-6.3.tar.gz | tar xfvz -
cd readline-6.3/
./configure --prefix=${HPC_WORK}
make
make install
```

while libicuuc.so.50 can be installed following similar procedure, their availability is as follows,

- [https://github.com/unicode-org/icu/releases/tag/release-50-2](https://github.com/unicode-org/icu/releases/tag/release-50-2)
- [https://github.com/unicode-org/icu/archive/refs/tags/release-50-2.tar.gz](https://github.com/unicode-org/icu/archive/refs/tags/release-50-2.tar.gz)

Finally, libgnutls.so.28 is unnecessary to start an R session but useful otherwise.

```bash
module load autogen-5.18.12-gcc-5.4.0-jn2mr4n
module load nettle-3.4-gcc-5.4.0-2mdpaut

cd ${HPC_WORK}
wget --no-check-certificate https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/gnutls-3.5.13.tar.xz
tar xf gnutls-3.5.13.tar.xz
cd gnutls-3.5.13/
./configure --prefix=${HPC_WORK} --with-included-unistring --enable-shared
make
make install
```

- [https://gnutls.org/](https://gnutls.org/)
- [https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/](https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/)
- [https://gitlab.com/gnutls/gnutls/](https://gitlab.com/gnutls/gnutls/)

```
# the gnutls module does really load from module
module load gnutls-3.5.13-gcc-5.4.0-wsonkhq
export LD_LIBRARY_PATH=/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/gnutls-3.5.13-wsonkhqhl4izga6mudwzg3cenxbienr4/lib
```
