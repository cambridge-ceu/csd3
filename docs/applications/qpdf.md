---
sort: 37
---

# qpdf

Web page: https://sourceforge.net/projects/qpdf/.

```bash
export version=10.3.2
cd $HPC_WORK
wget -qO- https://sourceforge.net/projects/qpdf/files/qpdf/9.1.0/qpdf-${version}.tar.gz | \
tar xvfz -
cd qpdf-${version}
./configure --prefix=$HPC_WORK
make
make install
```
