---
sort: 20
---

# geany

Web: <https://www.geany.org/> (<https://www.geany.org/download/git/>, <https://github.com/geany/geany/>, <https://plugins.geany.org/> )

> Geany is a powerful, stable and lightweight programmer's text editor that provides tons of useful features without bogging down your workflow. It runs on Linux, Windows and macOS, is translated into over 40 languages, and has built-in support for more than 50 programming languages.

## Prerequistes

`rst2pdf` (<https://rst2pdf.org/>) which requires Python>=3.8, is prepared for PDF documentation

```bash
module load texlive
module load python/3.8
cd /usr/local/Cluster-Apps/ceuadmin/rst2pdf/0.101/
virtualenv py38
source /usr/local/Cluster-Apps/ceuadmin/rst2pdf/0.101//py38/bin/activate
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

[YouTube](https://m.youtube.com/watch?v=VkG1YrNgb7U>)

It requires GTK+ >= 3.24.

```bash
module load gcc/7
wget -qO- https://github.com/geany/geany/releases/download/2.0.0/geany-2.0.tar.gz | \
tar xvfz -
cd geany-2.0
module load ceuadmin/rst2pdf
module load ceuadmin/gtk+/3.24.0
module load glib-2.56.2-gcc-5.4.0-4rjjizl
export PKG_CONFIG_PATH=$CEUADMIN/gtk+/lib/pkgconfig:$PKG_CONFIG_PATH
configure --prefix=$CEUADMIN/geany/2.0 --enable-binreloc=yes
make
make install
```

### geany-plugins

```bash
wget -qO- https://github.com/geany/geany-plugins/releases/download/2.0.0/geany-plugins-2.0.tar.gz | \
tar xfz -
cd geany-plugins-2.0/
configure --prefix=$CEUADMIN/geany/2.0 --with-geany-libdir=$CEUADMIN/geany/2.0/lib
make
make install
```

We now have the plugins which can be seen from Tools --> Plugin Manager.

### gtk+

```bash
wget -qO- https://download.gnome.org/sources/gtk+/3.8/gtk%2B-3.8.0.tar.xz | \
tar xfJ -
cd gtk+-3.24.0
module load ceuadmin/pango/1.41.1
module load cups-2.2.3-gcc-5.4.0-du37l7s
module load ceuadmin/gettext/0.20
module load glib-2.56.2-gcc-5.4.0-4rjjizl
module load spack/current
source $SPACK_ROOT/share/spack/setup-env.sh
configure --prefix=${CEUADMIN}/gtk+/3.24.0
make
make install
```

Strangely, the glib module has to be unloaded to avoid a call of a mislocated `sbang`.

### pango

```bash
wget https://download.gnome.org/sources/pango/1.41/pango-1.41.1.tar.xz
tar xf pango-1.41.1.tar.xz
cd pango-1.41.1/
./configure --prefix=$CEUADMIN/pango/1.41.1
make
make install
```

1.5.2 is also successful but again has permission issue.

### legacy attempts

These are to do with higher version of GTK+ or avaiable CSD3 modules.

#### cups (failed)

```bash
# cups 2.3.6 requires root
wget -qO- https://github.com/apple/cups/archive/refs/tags/v2.3.6.tar.gz | \
tar xfz -
cd cups-2.3.6
module load ceuadmin/libiconv/1.17
configure --prefix=$CEUADMIN/cups/2.3.6 --with-cups-user
make
make install
```

The failure is due to the fact that root permission is required.

#### graphene

Web: <https://ebassi.github.io/graphene/>

```bash
# 1.4.0
wget -qO- https://github.com/ebassi/graphene/archive/refs/tags/1.4.0.tar.gz | \
tar xfvz -
cd graphene-1.4.0/
autogen.sh
configure --prefix=$CEUADMIN/graphene/1.4.0
make
make install
# 1.8.0
wget -qO- https://github.com/ebassi/graphene/releases/download/1.8.0/graphene-1.8.0.tar.xz | \
tar xfJ -
cd graphene-1.8.0
mkdir _build
cd _build
module load ninja
meson --reconfigure --prefix=$CEUADMIN/graphene/1.8.0 ..
cd ..
ninja -C _build
ninja -C _build test
ninja -C _build install
```

#### Others (failed)

```bash
module load atk-2.20.0-gcc-5.4.0-kiljdkb
module load cairo/1.16.0
module load ceuadmin/fribidi
module load glib-2.56.2-gcc-5.4.0-4rjjizl
module load gtkplus-2.24.31-gcc-5.4.0-2a7zfti
module load ceuadmin/rst2pdf
export g=/usr/local/software/spack/current/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/glib-2.56.2-4rjjizlvegjs2vwdag76hzgvlck3zlqb
export h=/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/gtkplus-2.24.31-2a7zfti5vy55wwliac2v5bnwybhsfs4a
export include=${h}/lib/gtk-2.0/include:${h}/include/gtk-2.0/gtk:${g}/include/glib-2.0:${g}/lib/glib-2.0/include
export ldflags=${h}/lib:${g}/lib
./configure --prefix=$CEUADMIN/geany/2.0 --enable-binreloc=yes GTK_CFLAGS=-I${include} LDFLAGS=-L${ldflags} GTK_LIBS=-lgtk-x11-2.0 GTK_LIBS=-lglib-2.0
make
```
