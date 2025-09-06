---
sort: 38
---

# LEMMA

Web: [https://mkerin.github.io/LEMMA/](https://mkerin.github.io/LEMMA/) ([GitHub](https://github.com/mkerin/LEMMA/))

## 1.0.2

A by-product of SAIGE installation is LEMMA,

```bash
wget -qO- https://github.com/mkerin/LEMMA/archive/v1.0.2.tar.gz | \
tar xvfz | \
cd LEMMA-1.0.2
cmake -S . -B build \
      -DBGEN_ROOT=${HOME}/SAIGE/thirdParty/bgen \
      -DBOOST_ROOT=${HOME}/SAIGE/thirdParty/bgen/3rd_party/boost_1_55_0
cd build
make
```

## 1.0.4

The documentation indicates these requirements,

- [GCC](https://gcc.gnu.org/) version 9.4 or above
- [CMake](https://cmake.org/) version 3.16 or above
- [Boost](https://www.boost.org/) version 1.78 or above
- [OpenMPI](https://www.open-mpi.org/) version 3.1 or above

However, it is successful with these on CSD3:

```bash
module load gcc/11
module load cmake-3.19.7-gcc-5.4-5gbsejo
module load ceuadmin/bgen/1.1.7
module load boost-1.66.0-gcc-5.4.0-slpq3un
echo $LD_LIBRARY_PATH

wget -qO- https://github.com/mkerin/LEMMA/archive/refs/tags/v1.0.4.tar.gz | \
tar xfz -
cd LEMMA-1.0.4

cmake -S . -B build \
    -DBGEN_ROOT=/usr/local/Cluster-Apps/ceuadmin/bgen/1.1.7/ \
    -DBOOST_ROOT=/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/boost-1.66.0-slpq3unogrbhig6d4pniky7aft46jgqo/ \
    -DMKL_ROOT=/usr/local/Cluster-Apps/intel/2017.4/compilers_and_libraries_2017.4.196/linux/mkl/
cmake --build build -- -j4
build/tests
```

where the last statement generates benchmark tests.
