---
sort: 41
---

# qpdf

## GitHub

Web page [https://github.com/qpdf/qpdf](https://github.com/qpdf/qpdf).

```bash
module load zlib/1.2.11
git clone https://github.com/qpdf/qpdf
cd qpdf
configure --prefix=${HPC_WORK}
make
make install
```

## Sourceforge

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
