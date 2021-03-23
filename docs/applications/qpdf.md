---
sort: 27
---

# qpdf

Web page: https://sourceforge.net/projects/qpdf/.

```bash
cd $HPC_WORK
wget -qO- https://sourceforge.net/projects/qpdf/files/qpdf/9.1.0/qpdf-9.1.0.tar.gz | \
tar xvfz -
cd qpdf-9.1.0
./configure --prefix=$HPC_WORK
make
make install
```
