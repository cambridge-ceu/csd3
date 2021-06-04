---
sort: 26
---

# R/plumber

It requires R/sodium which in turn requires `libsodium`, [https://doc.libsodium.org/](https://doc.libsodium.org/).

```bash
wget -qO- https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz | \
tar xvfz -
cd libsodium-1.0.18
configure --prefix=${HPC_WORK}
make
make install
```

Following this, we could issue `Rscript -e "install.packages('plumber')"`.
