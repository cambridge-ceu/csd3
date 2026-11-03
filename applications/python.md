---
sort: 72
---

# Python

## 3.14.10

Install CPython 3.14.10 under `$CEUADMIN/python/3.14.10` using GCC 12.5.0, OpenSSL 3.3.0-dev, SQLite 3.49.2 and libffi 3.4.2.

```bash
#!/bin/bash -l
set -euo pipefail

V=3.14.10
PREFIX="$CEUADMIN/python/$V"
BUILD="$HOME/build/python-$V"

OPENSSL=/usr/local/Cluster-Apps/openssl/3.2.1
SQLITE=/usr/local/Cluster-Apps/ceuadmin/sqlite/3.49.2
LIBFFI=/usr/local/software/spack/spack-views/rocky8-icelake-20220710/libffi-3.4.2/gcc-11.3.0/alfpockhsgmv5vzwjg474kaaestxs7fa

module load ceuadmin/gcc/12.5.0
module load libffi/3.4.2/gcc/alfpockh

# Correct OpenSSL pkg-config files for this installation
mkdir -p "$HOME/.local/pkgconfig/openssl"
for f in openssl libssl libcrypto; do
    sed -e "s|/usr/local/lib64|$OPENSSL/lib64|g" \
        -e "s|/usr/local/include|$OPENSSL/include|g" \
        "$OPENSSL/lib64/pkgconfig/$f.pc" \
        > "$HOME/.local/pkgconfig/openssl/$f.pc"
done

export PKG_CONFIG_PATH="$HOME/.local/pkgconfig/openssl:$SQLITE/lib/pkgconfig:$LIBFFI/lib/pkgconfig"
export CPPFLAGS="-I$OPENSSL/include -I$SQLITE/include -I$LIBFFI/include"
export LDFLAGS="-L$OPENSSL/lib64 -L$SQLITE/lib -L$LIBFFI/lib64 \
-Wl,-rpath,$OPENSSL/lib64 -Wl,-rpath,$SQLITE/lib \
-Wl,-rpath,$LIBFFI/lib64"

[[ "$(gcc -dumpversion)" == 12.5.0 ]]
[[ "$(pkg-config --modversion openssl)" == 3.3.0-dev ]]
[[ "$(pkg-config --modversion sqlite3)" == 3.49.2 ]]

mkdir -p "$BUILD" "$PREFIX"
cd "$BUILD"

curl -fLO "https://www.python.org/ftp/python/$V/Python-$V.tar.xz"
echo "de414a57119abef52784d8993e341d53aed635fc2b05c2607d9f98a2c5b72032  Python-$V.tar.xz" \
    | sha256sum -c -

rm -rf "Python-$V"
tar -xf "Python-$V.tar.xz"
cd "Python-$V"

./configure \
    --prefix="$PREFIX" \
    --with-openssl="$OPENSSL" \
    --with-openssl-rpath=auto \
    --with-ensurepip=install

make -j "${SLURM_CPUS_PER_TASK:-8}"
make altinstall
cd "$PREFIX/bin"
ln -sf python3.14 python
ln -sf python3.14 python3

```

Load the module and verify:

```bash
module load ceuadmin/python/3.14.10

python --version
python3 --version
python3.14 --version
python - <<'PY'
import sys
import ssl
import sqlite3
import zlib
import bz2
import lzma
import readline
import ctypes
import curses
import uuid

print("Python:  ", sys.version)
print("OpenSSL: ", ssl.OPENSSL_VERSION)
print("SQLite:  ", sqlite3.sqlite_version)
print("zlib:    ", zlib.ZLIB_VERSION)
print("bz2:     OK")
print("lzma:    OK")
print("readline: OK")
print("ctypes:  OK")
print("curses:  OK")
print("uuid:    OK")
PY
```
