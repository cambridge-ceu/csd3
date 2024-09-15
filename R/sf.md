---
sort: 33
---

# sf

A number of packages use it as dependency and there might be error such as this,

```
Error in dyn.load(file, DLLpath = DLLpath, ...) :
  unable to load shared object '/rds/user/jhz22/hpc-work/R/sf/libs/sf.so':
  /rds/user/jhz22/hpc-work/R/sf/libs/sf.so: undefined symbol: GEOSSTRtree_nearest_generic_r
Calls: <Anonymous> ... asNamespace -> loadNamespace -> library.dynam -> dyn.load
Execution halted
```

We can get away with this,

```bash
module load geos-3.6.2-gcc-5.4.0-vejexvy
module load gcc/6
Rscript -e "install.packages('sf')"
```

## 1.0-17

We use a number of modules

```bash
module load ceuadmin/proj/7.2.1
module load ceuadmin/gdal/3.7.0
module load ceuadmin/geos/3.8.4
module load ceuadmin/libiconv/1.17
module load ceuadmin/openssl/3.2.1
module load ceuadmin/tiff/4.6.0
```

and also mask `configure` and create `src/Makevars`,

```
PKG_CPPFLAGS=-I/usr/local/Cluster-Apps/ceuadmin/proj/7.2.1/include \
             -I/usr/local/Cluster-Apps/ceuadmin/gdal/3.7.0/include \
             -I/usr/local/Cluster-Apps/ceuadmin/geos/3.8.4/include \
             -I/usr/local/Cluster-Apps/ceuadmin/7.85.0/include \
             -I/usr/local/Cluster-Apps/ceuadmin/libarchive/3.7.5/include \
             -I/usr/local/Cluster-Apps/openssl/3.2.1/include

PKG_LIBS=-L/usr/local/Cluster-Apps/ceuadmin/proj/7.2.1/lib \
         -lproj \
         -L/usr/local/Cluster-Apps/ceuadmin/gdal/3.7.0/lib64 \
         -lgdal \
         -L/usr/local/Cluster-Apps/ceuadmin/geos/3.8.4/lib \
         -lgeos_c \
         -L/usr/local/Cluster-Apps/ceuadmin/curl/7.85.0/lib \
         -lcurl \
         -L/usr/local/Cluster-Apps/ceuadmin/libarchive/3.7.5/lib \
         -larchive \
         -L/usr/local/Cluster-Apps/openssl/3.2.1/lib64 \
         -lssl \
         -lcrypto

CXX_STD=CXX
```

then `R CMD INSTALL sf`.

## 1.0-10/11/12

We have seen error

```
Error: package or namespace load failed for ‘sf’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/rds/user/jhz22/hpc-work/R/00LOCK-sf-10/00new/sf/libs/sf.so':
  /rds/user/jhz22/hpc-work/R/00LOCK-sf-10/00new/sf/libs/sf.so: undefined symbol: _Z16CPL_gdalmdiminfoN4Rcpp6VectorILi16ENS_15PreserveStorageEEES2_S2_S2_
Error: loading failed
Execution halted
ERROR: loading failed
* removing ‘/rds/user/jhz22/hpc-work/R/sf’
* restoring previous ‘/rds/user/jhz22/hpc-work/R/sf’
```

though they generate the same `sf/src/Makevars` as 1.0-9 which is installed successfully.

The error is actually due to **Rcpp** and after its reinstallation the loading is OK.
