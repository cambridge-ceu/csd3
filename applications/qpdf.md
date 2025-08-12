---
sort: 51
---

# qpdf

## 11.9.1

This is built under CentOS 8 (icelakte).

```bash
wget -qO- https://github.com/qpdf/qpdf/archive/refs/tags/v11.9.1.tar.gz | \
tar xvfz -
cd qpdf-11.9.1/
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$CEUADMIN/qpdf/11.9.1 ..
make
make install
qpdf --version
```

## 10.4.0

This is built under CentOS 7.

### GitHub

Web page [https://github.com/qpdf/qpdf](https://github.com/qpdf/qpdf).

```bash
module load zlib/1.2.11
git clone https://github.com/qpdf/qpdf
cd qpdf
configure --prefix=${HPC_WORK}
make
make install
```

### Sourceforge

Web page: [https://sourceforge.net/projects/qpdf/](https://sourceforge.net/projects/qpdf/).

```bash
module load zlib/1.2.11
export version=10.4.0
cd $HPC_WORK
wget -qO- --no-check-certificate https://sourceforge.net/projects/qpdf/files/qpdf/${version}/qpdf-${version}.tar.gz | \
tar xvfz -
cd qpdf-${version}
./configure --prefix=$HPC_WORK
make
make install
```
