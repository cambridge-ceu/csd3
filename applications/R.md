---
sort: 45
---

# R

## Installed modules

From the console we check its availability with `module avail R` and see

```
------------------------------------------------------------- /usr/local/software/modulefiles --------------------------------------------------------------
R/3.4           R/3.5           R/3.6           R/4.0.3         R/4.0.5-icelake R/4.1.0-icelake
```

so we can proceed with

```bash
module load R/4.0.3
R
```

The second line calls `/usr/local/Cluster-Apps/R/R.4.0.3/bin/R`.

## Compiling from source

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

Additional amemendments are necessary, e.g., package igraph 2.0.2 requires glpk/4.57 (see below).

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

## R/4.2.2

The following script is used to generate `ceuadmin/R/4.2.2`

```bash
#!/usr/bin/bash

module load gcc/6 geos-3.6.2-gcc-5.4.0-vejexvy gettext-0.19.8.1-gcc-5.4.0-5iqkv5z pcre2-10.20-gcc-5.4.0-tcuhtrb texlive
export prefix=/usr/local/Cluster-Apps/ceuadmin/R/4.2.2
cd ${prefix}
export version=4.2.2
wget -qO- https://cran.r-project.org/src/base/R-${major}/R-${version}.tar.gz | \
tar xvfz -
cd R-${version}
export gcc6=/usr/local/software/master/gcc/6
export intl=/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/gettext-0.19.8.1-5iqkv5zrractwd57vydu5czosgtrlwj2/
export HPC_WORK=/rds/user/jhz22/hpc-work
export include=${gcc6}/include:${intl}/include:${HPC_WORK}/include
export ldflags=${gcc6}/lib64:${gcc6}/lib:${intl}/lib:${HPC_WORK}/lib64:${HPC_WORK}/lib
./configure --prefix=${prefix} \
            --with-pcre2 \
            --enable-R-shlib CPPFLAGS=-I${include} LDFLAGS=-L${ldflags} LIBS=-ltinfo LIBS=-lintl
make
make install
```

## 4.3.3[-gcc11]

This is a lot messier,

```bash
#!/usr/bin/bash

module load gcc/6 geos-3.6.2-gcc-5.4.0-vejexvy gettext-0.19.8.1-gcc-5.4.0-5iqkv5z pcre2-10.20-gcc-5.4.0-tcuhtrb texlive
module load image-magick-7.0.5-9-gcc-5.4.0-d4lemcc
module load ceuadmin/glpk/4.57

export prefix=/rds-d4/user/$USER/hpc-work
export prefix=/rds/project/jmmh2/rds-jmmh2-public_databases/software
cd ${prefix}
export version=4.3.3
IFS=\. read major minor1 minor2 <<<${version}
wget -qO- https://cran.r-project.org/src/base/R-${major}/R-${version}.tar.gz | \
tar xvfz -
cd R-${version}
export gcc6=/usr/local/software/master/gcc/6
export intl=/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/gettext-0.19.8.1-5iqkv5zrractwd57vydu5czosgtrlwj2/
export HPC_WORK=/rds/user/jhz22/hpc-work
export include=${gcc6}/include:${intl}/include:${HPC_WORK}/include
export ldflags=${gcc6}/lib64:${gcc6}/lib:${intl}/lib:${HPC_WORK}/lib64:${HPC_WORK}/lib
./configure --prefix=${prefix} \
            --with-pcre2 \
            --enable-R-shlib CPPFLAGS=-I${include} LDFLAGS=-L${ldflags} LIBS=-ltinfo LIBS=-lintl
make
make install
ln -sf  ${prefix}/R-${version}/bin/R $HOME/bin/R
Rscript -e 'update.packages(checkBuilt=TRUE,ask=FALSE)'
```

Package DescTools 0.99.54 requires gcc/11 (there is problem with gcc/9 on CSD3) and to get around we also created `ceuadmin/R/4.3.3-gcc11`.

This is created under gcc/11 to enable package such as DescTools 0.99.54.

## icelake

<font color="red"><b>26/3/2022 Update</b></font> `module load R/4.1.0-icelake` <font color="blue"><b>will enable R 4.1.0 from icelake.</b></font>

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
./configure --prefix=${HPC_WORK} --enable-shared --with-curses
make
make install
```

where ncurses can be installed as follows (recent version actually is with libtinfo.so, e.g., LDFLAGS=-L$HPC_WORK/lib LIBS=-ltinfo),

```bash
wget -qO- https://invisible-mirror.net/archives/ncurses/current/ncurses.tar.gz | \
tar xfz -
cd ncurses-6.3-20221224/
./configure --prefix=$HPC_WORK --with-shared --enable-termcap
make
make install
```

while `libicuuc.so.50` can be installed following similar procedure, their availability is as follows,

- [https://github.com/unicode-org/icu/releases/tag/release-50-2](https://github.com/unicode-org/icu/releases/tag/release-50-2)
- [https://github.com/unicode-org/icu/archive/refs/tags/release-50-2.tar.gz](https://github.com/unicode-org/icu/archive/refs/tags/release-50-2.tar.gz)

Finally, `libgnutls.so.28`[^gnutls] requires `nettle-2.7.1`.

```bash
module load autogen-5.18.12-gcc-5.4.0-jn2mr4n
module load gettext-0.19.8.1-gcc-5.4.0-zaldouz

cd ${HPC_WORK}
wget -qO- wget http://www.lysator.liu.se/~nisse/archive/nettle-2.7.1.tar.gz | \
tar xfvz -
cd nettle-2.7.1/
configure --prefix=$HPC_WORK --with-include-path=$HPC_WORK/include --with-lib-path=$HPC_WORK/lib:$HPC_WORK/lib64 --enable-mini-gmp
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

### nano editor

It is relatively easy to set up `nano`, but one has to use the usual login node,

```bash
module load gcc/6
wget -qO- --no-check-certificate https://nano-editor.org/dist/v6/nano-6.0.tar.gz | \
tar xfz -
cd nano-6.0
configure --prefix=${HPC_WORK}
make
make install
```

The executable thus obtained also runs under icelake.

### alpine

We rather attemp to mirror efforts for `nano`,

```bash
wget -qO- wget https://alpine.x10host.com/alpine/release/src/alpine-2.25.tar.xz | \
tar Jxf -
cd alpine-2.25
configure
make
```

but `pico`, `pilot` and `alpine` obtained from the usual login node do not work, and we have to do these under icelake whose executables require TCL 8.6 under the usual login node where we amend them with

```bash
module load tcl-8.6.6-gcc-5.4.0-mongkp2
```

i.e., loading `libtcl8.6.so`. Take forward this idea, we could create two files,

```bash
#!/usr/bin/bash

export alpine=${HOME}/alpine-2.25
module load tcl-8.6.6-gcc-5.4.0-mongkp2
${alpine}/pico/pico $@
```

called `pico.sh` and

```bash
#!/usr/bin/bash

export alpine=${HOME}/alpine-2.25
module load tcl-8.6.6-gcc-5.4.0-mongkp2
${alpine}/pico/pilot $@
```

called `pilot.sh`, respectively. Then the two commands can be used both from the usual login nodes as well as icelake.

For `alpine` we get `alpine/alpine: /usr/lib64/libcrypt.so.1: version `XCRYPT_2.0' not found (required by alpine/alpine)`. Nevertheless we might compile two sets of executables under the usual login node and icelake, respectively.

Additional information is available from [https://alpine.x10host.com/alpine/release/](https://alpine.x10host.com/alpine/release/).

[^gnutls]:
    On CSD3, there is a more recent module `nettle-3.4-gcc-5.4.0-2mdpaut`. Moreover, with 3.5
    there is also an option `--with-included-unistring` during configuration.

    Version 3.7.8 requires libunistring (optionally --with-included-unistring), libidn2, libunbound, and trousers.

    ```bash
    ./configure --prefix=$HPC_WORK --with-included-unistring --with-nettle-mini --enable-ssl3-support \
                CFLAGS=-I$HPC_WORK/include LDFLAGS=-L$HPC_WORK/lib LIBS=-lunbound LIBS=-ltspi --enable-sha1-support --disable-guile
    ```

    It is necessary to edit `lib/pkcs11_privkey.c` to make `ck_rsa_pkcs_pss_params` definition explicit. Then there is error with guile so we use --disable-guile.
