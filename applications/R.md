---
sort: 33
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

It may complain about `libiconv.so.2`,

> ... R: error while loading shared libraries: libiconv.so.2: cannot open shared object file: No such file or directory

which can be installed as follows,

```bash
wget -qO- https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.16.tar.gz | tar xvfz -
cd libiconv-1.16
./configure --prefix=${HPC_WORK}
make
make install
```

We could also try from `module avail libiconv`.

## icelake

As CSD3 often experiences problem from the login nodes, it is then desirable to use `login-icelake.hpc.cam.ac.uk`.

However, there will be complaints about availability of `libreadline.so.6` and then `libiccuuc.so.50` which can be got around with their installations.

```
error while loading shared libraries: libreadline.so.6: cannot open shared object file: No such file or directory
...
error while loading shared libraries: libicuuc.so.50: cannot open shared object file: No such file or directory
...
error while loading shared libraries: libgnutls.so.28: cannot open shared object file: No such file or directory
...
libpng15.so.15: cannot open shared object file: No such file or directory
```

The setup below complies with ordinary login nodes.

```bash
wget -qO- --no-check-certificate https://ftp.gnu.org/pub/pub/gnu/readline/readline-6.3.tar.gz | tar xfvz -
cd readline-6.3/
./configure --prefix=${HPC_WORK}
make
make install
```

while `libicuuc.so.50` can be installed following similar procedure, their availability is as follows,

- [https://github.com/unicode-org/icu/releases/tag/release-50-2](https://github.com/unicode-org/icu/releases/tag/release-50-2)
- [https://github.com/unicode-org/icu/archive/refs/tags/release-50-2.tar.gz](https://github.com/unicode-org/icu/archive/refs/tags/release-50-2.tar.gz)

Finally, `libgnutls.so.28`[^1] requires `nettle-2.7.1`.

```bash
module load autogen-5.18.12-gcc-5.4.0-jn2mr4n
module load gettext-0.19.8.1-gcc-5.4.0-zaldouz

cd ${HPC_WORK}
wget -qO- wget http://www.lysator.liu.se/~nisse/archive/nettle-2.7.1.tar.gz | \
tar xfvz -
cd nettle-2.7.1/
configure --prefix=$HPC_WORK
make
make install
wget --no-check-certificate https://www.gnupg.org/ftp/gcrypt/gnutls/v3.2/gnutls-3.2.21.tar.xz
tar xf gnutls-3.2.21.tar.xz
cd gnutls-3.2.21/
./configure --prefix=${HPC_WORK} --enable-shared --disable-non-suiteb-curves
make
make install
```

- [https://gnutls.org/](https://gnutls.org/)
- [https://www.gnupg.org/ftp/gcrypt/gnutls/v3.2/](https://www.gnupg.org/ftp/gcrypt/gnutls/v3.2/)
- [https://gitlab.com/gnutls/gnutls/](https://gitlab.com/gnutls/gnutls/)

The `libpng15.so` can be made available from a standard GNU-ware installation as follows,

```bash
cd ${HPC_WORK}
wget -qO- https://sourceforge.net/projects/libpng/files/libpng15/1.5.30/libpng-1.5.30.tar.gz | \
tar xvfz -
cd libpng-1.5.30
./configure --prefix=$HPC_WORK
make
make install
```

[^1]:
    On CSD3, there is a more recent module `nettle-3.4-gcc-5.4.0-2mdpaut`. Moreover, with 3.5
    there is also an option `--with-included-unistring` during configuration.