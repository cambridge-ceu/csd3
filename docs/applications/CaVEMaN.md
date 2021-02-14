---
sort: 7
---

# CaVEMaN

Web, https://github.com/funpopgen/CaVEMaN/

Causal Variant Evidence Mapping with Non-parametric resampling (CaVEMaN) is one of the three fine-mapping software which provided data for GTEx v8.

```bash
# binary distribution
https://github.com/funpopgen/CaVEMaN/releases/download/v1.01/CaVEMaN
# build from source
git clone https://github.com/funpopgen/CaVEMaN && cd CaVEMaN
module load xz
wget -qO- https://github.com/ldc-developers/ldc/releases/download/v1.24.0/ldc2-1.24.0-linux-x86_64.tar.xz | \
tar Jxf -
module load gsl/2.1
# modify makefile
LDC := ${PWD}/ldc2-1.24.0-linux-x86_64/bin/ldc2
DMD := ${PWD}/ldc2-1.24.0-linux-x86_64/bin/dmd
GSL := /usr/local/Cluster-Apps/gsl/2.1
make
```

Note that the D compiler setup actually requires gsl/2.1.
