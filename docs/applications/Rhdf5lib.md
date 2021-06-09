---
sort: 38
---

# R/Rhdf5lib

This is useful for hdf5 file handling, but BiocManager::install() gives error `cp: cannot stat ‘hdf5/c++/src/.libs/libhdf5_cpp.a’: No such file or directory ` so we proceed manually,

```bash
module load gcc/6
cd $HOME
wget https://bioconductor.org/packages/3.11/bioc/src/contrib/Rhdf5lib_1.10.1.tar.gz
tar xfz Rhdf5lib_1.10.1.tar.gz
cd Rhdf5lib
./configure
mv configure configure.sav
cd src
tar xfz hdf5small_cxx_hl_1.10.6.tar.gz
cd hdf5
./configure --prefix=$HPC_WORK --enable-build-all --enable-cxx CFLAGS=-fPIC
make
make install
mv configure configure.sav
cd $HOME
R CMD INSTALL Rhdf5lib
```
