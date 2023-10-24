---
sort: 20
---

# geany

Web: <https://www.geany.org/> (<https://www.geany.org/download/git/>, <https://github.com/geany/geany/> )

> Geany is a powerful, stable and lightweight programmer's text editor that provides tons of useful features without bogging down your workflow. It runs on Linux, Windows and macOS, is translated into over 40 languages, and has built-in support for more than 50 programming languages.

## Prerequistes

`rst2pdf` (<https://rst2pdf.org/>) which requires Python>=3.8, is prepared for PDF documentation

```bash
module load texlive
module load python/3.8
virtualenv py38
source /usr/local/Cluster-Apps/ceuadmin/rst2pdf/0.101/py38/bin/activate
pip install PyPI
pip install rst2pdf[aafiguresupport,mathsupport,plantumlsupport,rawhtmlsupport,sphinx,svgsupport]
rst2pdf --version
```

As requested, `PyPI` (<https://pypi.org/>) is instadlled and options are added to the canonical `pip install rst2pdf` (see also <https://pypi.org/project/rst2pdf/>).

Note that many utilities are now available, including `qr`, `svg2pdf`, `ttx` as well as `sphinx-apidoc|autogen|build|quickstart`.

## 1.38

This proceeds as follows,

```bash
module load gcc/7
wget https://github.com/geany/geany/releases/download/1.38.0/geany-1.38.tar.gz
tar xfz geany-1.38.tar.gz
cd geany-1.38/
configure --prefix=$CEUADMIN/geany/1.38 --enable-binreloc=yes
make
make install
```

The `gcc/7` module is loaded since C++17 is required.

To this point, the software as with the utilities is available upon `module load ceuadmin/geany`.

## 2.0

(To be continued)

It requires gtk+>=3.22, so the setup for gtk+3.24.9 is somewhat involved. At least, these are necessary,

```bash
module load gcc/7
module load glib-2.56.2-gcc-5.4.0-4rjjizl
# pango 1.41.1
./configure --prefix=$CEUADMIN/pango/1.41.1
wget https://download.gnome.org/sources/pango/1.41/pango-1.41.1.tar.xz
tar xf pango-1.41.1.tar.xz
cd pango-1.41.1/
./configure --prefix=$CEUADMIN/pango/1.41.1
make
make install
# gtk+-3.24.9
wget https://download.gnome.org/sources/gtk+/3.24/gtk%2B-3.24.9.tar.xz
tar xf gtk+-3.24.9.tar.xz
cd gtk+-3.24.9
module load gettext-0.19.8.1-gcc-5.4.0-5iqkv5z
module load ceuadmin/gettext
export intl=/usr/local/Cluster-Apps/ceuadmin/gettext/0.21/
module load cups-2.2.3-gcc-5.4.0-du37l7s
module load ceuadmin/pango
export ldflags=${gcc6}/lib64:${gcc6}/lib:${intl}/lib:${HPC_WORK}/lib64:${HPC_WORK}/lib
configure --prefix=${CEUADMIN}/gtk+/3.24.9 CPPFLAGS=-I${intl}/include LDFLAGS=-L${ldflags} LIBS=-lintl
make
# geany 2.0
wget https://github.com/geany/geany/releases/download/2.0.0/geany-2.0.tar.gz
tar tvfz geany-2.0.tar.gz
```

Attempts to use available modules available modules, e.g.,

```bash
module load atk-2.20.0-gcc-5.4.0-kiljdkb
module load cairo/1.16.0
module load ceuadmin/fribidi
module load glib-2.56.2-gcc-5.4.0-4rjjizl
module load gtkplus-2.24.31-gcc-5.4.0-2a7zfti
module load ceuadmin/rst2pdf
export h=/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/gtkplus-2.24.31-2a7zfti5vy55wwliac2v5bnwybhsfs4a/
export g=/usr/local/software/spack/current/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/glib-2.56.2-4rjjizlvegjs2vwdag76hzgvlck3zlqb
wget https://download.gnome.org/sources/pango/1.5/pango-1.5.2.tar.gz
tar xvfz pango-1.5.2.tar.gz
cd pango-1.5.2/
configure --prefix=$CEUADMIN/pango/1.5.2 GLIB_CFLAGS="-I$g/include/glib-2.0 -I$g/lib/glib-2.0/include" GLIB_LIBS="-L$g/lib -L${intl} -lintl -lglib-2.0"
make
./configure --prefix=$CEUADMIN/geany/2.0 --enable-binreloc=yes \
            GTK_CFLAGS="-I${h}/include -I${h}/lib/gtk-2.0/include -I${h}/include/gtk-2.0/gtk" \
            GTK_CFLAGS="-I${g}/include/glib-2.0 -I${g}/lib/glib-2.0/include -I$g/include/glib-2.0/include" \
            GTK_LIBS="-L${h}/lib -lgtk-x11-2.0 -L$g/lib -lglib-2.0"
```
