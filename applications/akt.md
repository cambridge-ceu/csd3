---
sort: 3
---

# akt

Web: [https://github.com/Illumina/akt](https://github.com/Illumina/akt)

This is Illumina's ancestry and kinship toolkit and the installation is canonical.

```bash
wget -qO- https://github.com/Illumina/akt/archive/refs/tags/v0.3.3.tar.gz | \
tar xvfz -
cd akt-0.3.3
make
cd test
test.sh
```

then `akt` is available in the current directory and used by `test/test.sh`.

Alternatively, one can clone the latest version from GitHub

```bash
git clone https://github.com/Illumina/akt
cd akt
make
```
