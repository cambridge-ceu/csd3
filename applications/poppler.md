---
sort: 33
---

# poppler

Official page: [https://poppler.freedesktop.org/](https://poppler.freedesktop.org/).

## Installation

We work on the latest version, 0.84.0.

```bash
module load xz/5.2.2
wget https://poppler.freedesktop.org/poppler-0.84.0.tar.xz
tar xf poppler-0.84.0.tar.xz
cd poppler-0.84.0
mkdir build
cd build
module load gcc/5
module load boost-1.58.0-gcc-5.4.0-onpiqcr
module load libiconv-1.15-gcc-5.4.0-ymwv5vs
module load lcms-2.8-gcc-5.4.0-oaipjmr
module load openjpeg-2.1-gcc-5.4.0-myd2p3o
cmake -DCMAKE_CXX_FLAGS="-liconv" -DCMAKE_INSTALL_PREFIX:PATH=/rds/user/$USER/hpc-work -DENABLE_UNSTABLE_API_ABI_HEADERS=ON ..
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

Note also the packages `R/Rpoppler`, `pdftools` and `qpdf` from CRAN.

## pdf2djvu

The -DENABLE_UNSTABLE_API_ABI_HEADERS=ON flags above enables pdf2djvu to be compiled.

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
