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

## 2.0

(To be continued)

It requires gtk+>=3.22, so the setup for gtk+3.24.9 is somewhat involved. At least, these are necessary,

```bash
wget https://download.gnome.org/sources/gtk+/3.24/gtk%2B-3.24.9.tar.xz
tar xf gtk+-3.24.9.tar.xz
wget https://github.com/geany/geany/releases/download/2.0.0/geany-2.0.tar.gz
tar tvfz geany-2.0.tar.gz
```

Some tweaks are necessary with available modules, e.g.,

```bash
module load gtkplus-2.24.31-gcc-5.4.0-2a7zfti
module load glib-2.56.3-gcc-5.4.0-zxgw6wi
export h=/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/gtkplus-2.24.31-2a7zfti5vy55wwliac2v5bnwybhsfs4a/
export g=/usr/local/software/spack/current/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/glib-2.56.3-zxgw6wiqrgcsdub5iknairidnjfopchs
./configure GTK_CFLAGS="-I${h}/include -I$g/include/glib-2.0" GTK_LIBS="-L${h}/lib -lgtk-x11-2.0"
```

The `glibconfig.h` is reported missing.
