---
sort: 21
---

# lapack

Web: [http://www.netlib.org/lapack/](http://www.netlib.org/lapack/)

The sequence is as follows,

```bash
wget http://www.netlib.org/lapack/lapack-3.9.0.tar.gz
tar xvfz lapack-3.9.0.tar.gz
cd lapack-3.9.0
mkdir build
cd build
## ccmake .
cmake ..
make
make install
```

Note `ccmake` is commented as it does not work properly on csd3. By default these build static libraries into build/lib/. It is also possible to build the static libraries in lapack-3.9.0/ by making a copy of `make.inc.example` as `make.inc` and compile `libblas.a`,`liblapack.a` as well as `libcblas.a` and `liblapacke.a` from BLAS/ and LAPACKE/ directories.

To enable the shared libraries, proceed with

```bash
cmake -DCMAKE_INSTALL_PREFIX=${HPC_WORK} -DCMAKE_BUILD_TYPE=RELEASE -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON -DCBLAS=ON ..
```
