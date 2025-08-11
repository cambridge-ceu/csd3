---
sort: 11
---

# igraph

## 2.1.4

This works well with `R CMD INSTALL --no-configure igraph` using `Makevars` in 2.0.2 and adding `-Ivendor/io/parsers`, but we still have

```
Error: package or namespace load failed for ‘igraph’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/rds/project/rds-4o5vpvAowP0/software/R/00LOCK-igraph/00new/igraph/libs/igraph.so':
  /rds/project/rds-4o5vpvAowP0/software/R/00LOCK-igraph/00new/igraph/libs/igraph.so: undefined symbol: mpz_sizeinbase
Error: loading failed
Execution halted
ERROR: loading failed
* removing ‘/rds/project/rds-4o5vpvAowP0/software/R/igraph’
* restoring previous ‘/rds/project/rds-4o5vpvAowP0/software/R/igraph’
```

Somehow we use the default modules,

```
Currently Loaded Modulefiles:
 1) rhel8/slurm           4) cuda/11.4                                      7) ucx/1.15.0
 2) singularity/current   5) vgl/2.5.1/64                                   8) intel-oneapi-mpi/2021.6.0/intel/guxuvcpm
 3) rhel8/global          6) intel-oneapi-compilers/2022.1.0/gcc/b6zld2mz   9) rhel8/default-icl
```

followed by `module load ceuadmin/R` and try again to get it compiled and loaded.

## 2.0.2

We succeded with this,

```bash
module load gcc/6
module load ceuadmin/glpk/4.57
Rscript -e 'download.packages("igraph",".")'
tar xvfz igraph_2.0.2.tar.gz
cd igraph
./configure
# mv configure configure.sav
# modify src/Makevars
# export LD_LIBRARY_PATH=/usr/local/software/master/gcc/9/lib64:$LD_LIBRARY_PATH
R CMD INSTALL --no-configure igraph
```

Unfortunately, unlike stated in the package, manual work is still needed, involving adding into`Makevars` `-I/usr/local/Cluster-Apps/ceuadmin/glpk/4.57/include` and `-L/usr/local/Cluster-Apps/ceuadmin/glpk/4.57/lib`.

```
# Generated from Makevars.in, do not edit by hand
include sources.mk

PKG_CFLAGS=$(C_VISIBILITY)
PKG_CXXFLAGS=$(CXX_VISIBILITY)
PKG_FFLAGS=$(F_VISIBILITY)

PKG_CPPFLAGS=-DUSING_R -I. -Ivendor -Ivendor/cigraph/src -Ivendor/cigraph/include -Ivendor/cigraph/vendor -Ivendor/mini-gmp -I/rds/user/jhz22/hpc-work/include/libxml2 -I/usr/local/Cluster-Apps/ceuadmin/glpk/4.57/include\
    -DNDEBUG -DNTIMER -DNPRINT -DIGRAPH_THREAD_LOCAL= \
    -DPRPACK_IGRAPH_SUPPORT \
    -DHAVE_GFORTRAN=1 \
    -D_GNU_SOURCE=1

PKG_LIBS = -lglpk -L/rds/user/jhz22/hpc-work/lib:/usr/local/Cluster-Apps/ceuadmin/glpk/4.57/lib -lxml2 -L/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/zlib-1.2.11-lnf7bswyozdhprbg7jo6n5ha5633ftj2/lib -lz -llzma -lm -ldl $(LAPACK_LIBS) $(BLAS_LIBS) $(FLIBS)

OBJECTS=${SOURCES}
```

The installation of `tidygraph` 1.3.1, `Seurat` 5.0.2 (we used gcc/7) follows suite.
