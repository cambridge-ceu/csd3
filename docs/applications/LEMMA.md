---
sort: 17
---

# LEMMA

A by-product of SAIGE installation is LEMMA,

```bash
wget -qO- https://github.com/mkerin/LEMMA/archive/v1.0.2.tar.gz | \
tar xvfz | \
cd LEMMA-1.0.2
cmake -S . -B build \
      -DBGEN_ROOT=${HOME}/SAIGE/thirdParty/bgen \
      -DBOOST_ROOT=${HOME}/SAIGE/thirdParty/bgen/3rd_party/boost_1_55_0
cd build
make
```
