---
sort: 13
---

# lpsymphony

## 1.32.0

As stated, the Bioconductor package comes with its version SYMPHONY; nevertheless it is actually easier to modify this.

As usual, we mask the `configure` commnand,

```bash
wget -qO- https://bioconductor.org/packages/release/bioc/src/contrib/lpsymphony_1.32.0.tar.gz | \
tar xvfz -
cd lpsymphony
mv configure configure.sav
```

and use a `Makevars` as follows,

```
# Use C++17 standard
CXX_STD = CXX17

# Compiler flags
CXXFLAGS = -Wall -O3

# Linker flags
LDFLAGS = -shared

# Include directories
PKG_CPPFLAGS = -I/usr/local/Cluster-Apps/ceuadmin/SYMPHONY/5.6.17/include

# Libraries to link against
PKG_LIBS = -L/usr/local/Cluster-Apps/ceuadmin/SYNPHONY/5.6.17/lib -lSym
```

where SYMPHONY 5.6.17 is installed using standard method.

```bash
wget -qO- https://www.coin-or.org/download/source/SYMPHONY/SYMPHONY-5.6.17.tgz | \
tar xvfz -
cd SYMPHONY-5.6.17/
configure --prefix=$CEUADMIN/SYMPHONY/5.6.17
make
make install
```

Now we do `R CMD INSTALL lpsymphony`.

Packages `IHW` 1.32.0 and `scp` 1.14.0 are ready to install.
