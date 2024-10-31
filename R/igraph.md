---
sort: 11
---

# igraph

For 2.0.2, we succeded with this,

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
