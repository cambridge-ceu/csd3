---
sort: 21
---

# proj4

## 1.0-15

Initially we see that

```
* installing to library ‘/rds/project/rds-4o5vpvAowP0/software/R’
* installing *source* package ‘proj4’ ...
** this is package ‘proj4’ version ‘1.0-15’
file ‘configure’ is missing
** using staged installation
** libs
using C compiler: ‘gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-24)’
using C++ compiler: ‘g++ (GCC) 8.5.0 20210514 (Red Hat 8.5.0-24)’
using C++17
gcc -I"/usr/local/Cluster-Apps/ceuadmin/R/4.5.0-icelake/include" -DNDEBUG -I/usr/local/Cluster-Apps/ceuadmin/libgit2/1.1.0/include  -I/usr/local/Cluster-Apps/ceuadmin/libiconv/1.17/include    -fpic  -g -O2  -c p4.c -o p4.o
p4.c:9:10: fatal error: proj_api.h: No such file or directory
 #include <proj_api.h>
          ^~~~~~~~~~~~
compilation terminated.
make: *** [/usr/local/Cluster-Apps/ceuadmin/R/4.5.0-icelake/etc/Makeconf:202: p4.o] Error 1
ERROR: compilation failed for package ‘proj4’
* removing ‘/rds/project/rds-4o5vpvAowP0/software/R/proj4’
* restoring previous ‘/rds/project/rds-4o5vpvAowP0/software/R/proj4’
```

After downloading and extracting the package, create `src/Makevars` similar to one used for `git2r`,

```
# Use C++17 standard
CXX_STD = CXX17

# Compiler flags
CXXFLAGS = -Wall -O3

# Linker flags
LDFLAGS = -shared

# Include directories
PKG_CPPFLAGS = -I/usr/local/Cluster-Apps/ceuadmin/proj/7.2.1/include

# Libraries to link against
PKG_LIBS = -L/usr/local/Cluster-Apps/ceuadmin/proj/7.2.1/lib -lproj
```

We see

```
** building package indices
** testing if installed package can be loaded from temporary location
Error: package or namespace load failed for ‘proj4’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/rds/project/rds-4o5vpvAowP0/software/R/00LOCK-proj4/00new/proj4/libs/proj4.so':
  libtiff.so.6: cannot open shared object file: No such file or directory
Error: loading failed
Execution halted
ERROR: loading failed
* removing ‘/rds/project/rds-4o5vpvAowP0/software/R/proj4’
* restoring previous ‘/rds/project/rds-4o5vpvAowP0/software/R/proj4’
```

The solutions comes after we issue `module load ceuadmin/tiff/4.6.0`.

