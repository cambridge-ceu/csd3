---
sort: 7
---

# git2r

## 0.35.0

We first download and unpack the source package, then mask the `configure` command

```bash
wget -qO- https://cran.r-project.org/src/contrib/git2r_0.35.0.tar.gz | \
tar xvfz -
cd git2r
mv configure configure.sav
# create src/Makevars
cd -
```

where we also create `Makevars` at `src/` with the following contents,

```
# Use C++17 standard
CXX_STD = CXX17

# Compiler flags
CXXFLAGS = -Wall -O3

# Linker flags
LDFLAGS = -shared

# Include directories
PKG_CPPFLAGS = -I/usr/local/Cluster-Apps/ceuadmin/libgit2/1.1.0/include

# Libraries to link against
PKG_LIBS = -L/usr/local/Cluster-Apps/ceuadmin/libgit2/1.1.0/lib -lgit2
```

This is half-way through and issue command `libssh2/1.11.0-icelake`, and we are now ready to compile

```bash
R CMD INSTALL git2r
```
