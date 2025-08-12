---
sort: 32
---

# lapack

Web: [http://www.netlib.org/lapack/](http://www.netlib.org/lapack/)

The sequence is as follows,

```bash
wget -qO- https://github.com/Reference-LAPACK/lapack/archive/refs/tags/v3.10.1.tar.gz | \
tar xfz -
cd lapack-3.10.1
mkdir build
cd build
module load cmake-3.19.7-gcc-5.4-5gbsejo
## ccmake .
cmake ..
make
make install
```

Note `ccmake` is commented as it does not work properly on csd3. It is also possible to build the static libraries by making a copy of `make.inc.example` as `make.inc` and compile `libblas.a`,`liblapack.a` as well as `libcblas.a` and `liblapacke.a` from BLAS/ and LAPACKE/ directories.

To enable the shared libraries, proceed with

```bash
cmake -DCMAKE_INSTALL_PREFIX=${HPC_WORK} -DCMAKE_BUILD_TYPE=RELEASE -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON -DCBLAS=ON ..
```
