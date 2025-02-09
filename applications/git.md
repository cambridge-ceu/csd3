---
sort: 22
---

# git

Web: <https://git-scm.com/downloads/linux>.

<font color="red"><b>9/2/2025 Update</b></font>

Module `ceuadmin/git/2.48.1` is now available, which takes advantage of the modernised approach via `meson` and avoid memory leaks.

## Installation

```bash
wget -qO- https://www.kernel.org/pub/software/scm/git/git-2.48.1.tar.gz | \
tar xfz -
cd git-2.48.1
module load ceuadmin/libgcrypto ceuadmin/docbook2X
source ~/COVID-19/py37/bin/activate
make prefix=$CEUADMIN/git/2.48.1 install install-doc install-html
```

The Python call sets default to `meson` but the `./configure --prefix=.` routine should also work after the `make` statement above.
A lot of work is needed when adding `install-info` in the `make` statement above due to somewhat earlier implementation in
`ceuadmin/docbook2X`.
