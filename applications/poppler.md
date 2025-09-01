---
sort: 52
---

# poppler

Official page: [https://poppler.freedesktop.org/](https://poppler.freedesktop.org/).

## Updates on icelake

This mirrors earlier procedure for `cclake`.

```
wget -qO- https://poppler.freedesktop.org/poppler-0.84.0.tar.xz | \
tar Jxf -
cd poppler-0.84.0
module load boost/1.77.0/gcc/5i7wp5ky
module load lcms/2.9/gcc/5pdbznpf
module load libiconv/1.16/gcc/4miyzf3w
module load openjpeg-2.1-gcc-5.4.0-myd2p3o
git clone git://git.freedesktop.org/git/poppler/test test-data
make build && cd build
cmake -DCMAKE_CXX_FLAGS="-liconv" -DCMAKE_INSTALL_PREFIX=$CEUADMIN/poppler/0.84.0 \
      -DENABLE_UNSTABLE_API_ABI_HEADERS=ON -DTESTDATADIR=../test-data -Wno-dev ..
module load cmake/3.21.3/gcc/6p22w6m2
ccmake .
make
make install
```

The cmake/latest is version 3.26.5, whose `ccmake` is dysfunctional. We could resort to `cmake/3.21.3/gcc/6p22w6m2`. Since there is difficulty with tiff, it is disabled from `ccmake`.

## Installation

We work on the latest version, 0.84.0.

```bash
module load xz/5.2.2
wget https://poppler.freedesktop.org/poppler-0.84.0.tar.xz
tar Jxf poppler-0.84.0.tar.xz
cd poppler-0.84.0
git clone git://git.freedesktop.org/git/poppler/test test-data
mkdir build
cd build
module load gcc/5
module load boost-1.58.0-gcc-5.4.0-onpiqcr
module load libiconv-1.15-gcc-5.4.0-ymwv5vs
module load lcms-2.8-gcc-5.4.0-oaipjmr
module load openjpeg-2.1-gcc-5.4.0-myd2p3o
cmake -DCMAKE_CXX_FLAGS="-liconv" -DCMAKE_INSTALL_PREFIX:PATH=/rds/user/$USER/hpc-work \
      -DENABLE_UNSTABLE_API_ABI_HEADERS=ON -DTESTDATADIR=../test-data -Wno-dev ..
make
make install
```

Note it is necessary to change prefix, cc and c++ to gcc and g++ in line with gcc/5, e.g.,

```
CMAKE_INSTALL_PREFIX:PATH=/rds/user/$USER/hpc-work
CMAKE_C_COMPILER:FILEPATH=/usr/local/software/master/gcc/5/bin/gcc
CMAKE_CXX_COMPILER:FILEPATH=/usr/local/software/master/gcc/5/bin/g++
```

which could be done by editing CMakeCache.txt and/or calling `ccmake .`. After these we have
the followihg utilities:
pdfattach, pdfdetach, pdffonts, pdfimages, pdfinfo, pdfseparate, pdftocairo, pdftohtml, pdftoppm, pdftops, pdftotext, pdfunite,
and following libraries: libpoppler.so, libpoppler-cpp.so, libpoppler-glibc.so, libpoppler-qt5.so.

Note that `poppler-cpp.pc` is installed at `hpc-work/lib64/pkgconfig` and preferably in the search path with

```bash
export PKG_CONFIG_PATH=$HPC_WORK/lib/pkgconfig:$HPC_WORK/lib64/pkgconfig:$PKG_CONFIG_PATH
```

after which we could install R/pdftools from CRAN.

Note also the packages `R/Rpoppler`, `pdftools` (for 3.4.0, 0.84 is called instead of 0.84.0, so a symbolic link is created there) and `qpdf` from CRAN.

## nspr

There is complaint from `nss` on `nspr`,

```
-- Checking for module 'nss>=3.19'
--   Found nss, version 3.67.0
Package 'NSS-UTIL' requires 'nspr >= 4.30.0' but version of NSPR is 4.10.0
```

so we furnish this with

```bash
wget -qO- https://ftp.mozilla.org/pub/nspr/releases/v4.35/src/nspr-4.35.tar.gz | tar xvfz -
module unload gcc/6
cd nspr-4.35/
cd nspr
./configure --prefix=${HPC_WORK}
make
make install
```

Note the default `gcc/4.8.5` has to be used rather than `gcc/6`. Upon completion, we succeed with

```bash
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/Cluster-Apps/ceuadmin/poppler/0.84  -DCMAKE_BUILD_TYPE=release
make
make install
```

## pdf2djvu

The -DENABLE_UNSTABLE_API_ABI_HEADERS=ON flags above enables pdf2djvu to be compiled. The headers are not installed by default but to pass -DENABLE_UNSTABLE_API_ABI_HEADERS=ON (for Poppler >= 0.78) or -DENABLE_XPDF_HEADERS=ON (for older Popplers) to cmake; or pass --enable-xpdf-headers to configure.

```bash
wget https://github.com/jwilk/pdf2djvu/releases/download/0.9.19/pdf2djvu-0.9.19.tar.xz
tar xf pdf2djvu-0.9.19.tar.xz
cd pdf2djvu-0.9.19
./configure --prefix=${HPC_WORK}
module load gettext-0.19.8.1-gcc-5.4.0-zaldouz
module load libuuid-1.0.3-gcc-5.4.0-weheiii
make
make install
```

This appears better than [https://pdf2djvu.com/](https://pdf2djvu.com/).

It is preferable to have GraphicsMagick++ installed,

```bash
wget -qO- https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/1.3.38/GraphicsMagick-1.3.38.tar.gz/download | \
tar xfz -
cd GraphicsMagick-1.3.38/
./configure --prefix=$HPC_WORK --enable-shared
make
make install
```

Note we explicitly enables shared libraries to be called.
