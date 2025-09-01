---
sort: 7
---

# aria2

Web: [https://aria2.github.io/](https://aria2.github.io/).

On CSD3, one can use the prerequiste `module load aria2-1.33.1-gcc-5.4.0-r36jubs`.

## Installation

```bash
export HPC_WORK=/rds/user/${USER}/hpc-work
cd ${HPC_WORK}
wget -qO- https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0.tar.gz | \
tar xvfz -
cd aria2-1.36.0/
module load gettext-0.19.8.1-gcc-5.4.0-zaldouz
module load jemalloc-4.5.0-gcc-5.4.0-j3zbugm
module load libuv-1.25.0-gcc-5.4.0-stlddds
module load zlib/1.2.11
# modules not picked up: expat-2.2.5-gcc-5.4.0-4mvunyd libgcrypt-1.8.1-gcc-5.4.0-gbvid6j openssl-system-gcc-5.4.0-equqac7
./configure --prefix=${HPC_WORK} --enable-libaria2 --enable-static --with-jemalloc --with-libuv LIBS=-lintl
make
make install
```

It also uses SQLite3, gmp, gnutls, nettle, cppunit, e.g., [git clone git://anongit.freedesktop.org/git/libreoffice/cppunit/](git clone git://anongit.freedesktop.org/git/libreoffice/cppunit/) ([sourceforge](https://sourceforge.net/projects/cppunit/files/cppunit/1.12.1/cppunit-1.12.1.tar.gz/)) and libssh2, e.g., [https://libssh2.org/download/libssh2-1.10.0.tar.gz](https://libssh2.org/download/libssh2-1.10.0.tar.gz).

## Examples

```bash
aria2c -h
aria2c -i urls.txt
awk 'NR==10' urls.txt | \
aria2c -i -
```

The commands give usage information, download files in `urls.txt` and the tenth file only, respectively.
