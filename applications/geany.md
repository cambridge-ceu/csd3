---
sort: 29
---

# geany

Web: <https://www.geany.org/> (<https://www.geany.org/download/git/>)\
GitHub: <https://github.com/geany/geany/>\
Plugins: <https://plugins.geany.org/>

> Geany is a powerful, stable and lightweight programmer's text editor that provides tons of useful features without bogging down your workflow. It runs on Linux, Windows and macOS, is translated into over 40 languages, and has built-in support for more than 50 programming languages.

## geany 2.0-icelake

<font color="red"><b>19/5/2025 Update</b></font>This revives its CentOS 7 counterpart (below) but also adds the PDF documentation.

```bash
wget -qO- https://github.com/geany/geany/releases/download/2.0.0/geany-2.0.tar.gz | \
tar xvfz -
cd geany-2.0
module load ceuadmin/rst2pdf
module load ceuadmin/gtk+/3.24.0
module load glib-2.56.2-gcc-5.4.0-4rjjizl
./configure --prefix=$CEUADMIN/geany/2.0-icelake --enable-binreloc=yes --enable-pdf-docs PKG_CONFIG_PATH=$CEUADMIN/gtk+/3.24.0/lib/pkgconfig
make
make install
```

The plugins are more involved.

```bash
wget -qO- https://github.com/geany/geany-plugins/releases/download/2.0.0/geany-plugins-2.0.tar.gz | \
tar xfz -
cd geany-plugins-2.0/
module load ceuadmin/enchant/2.2.0
module load ceuadmin/gtk+/3.24.0
module load glib-2.56.2-gcc-5.4.0-4rjjizl
./configure --prefix=$CEUADMIN/geany/2.0-icelake --with-geany-libdir=$CEUADMIN/geany/2.0-icelake/lib \
          --enable-spellcheck \
          PKG_CONFIG_PATH=${CEUADMIN}/enchant/2.2.0/lib/pkgconfig:${CEUADMIN}/gtk+/3.24.0/lib/pkgconfig
make
make check
make install
```

We now have the plugins which can be seen from Tools --> Plugin Manager.

## Prerequistes

`rst2pdf` (<https://rst2pdf.org/>) which requires Python>=3.8, is prepared for PDF documentation

```bash
module load texlive
module load python/3.8
cd /usr/local/Cluster-Apps/ceuadmin/rst2pdf/0.101/
virtualenv py38
source /usr/local/Cluster-Apps/ceuadmin/rst2pdf/0.101/py38/bin/activate
pip install PyPI
pip install rst2pdf[aafiguresupport,mathsupport,plantumlsupport,rawhtmlsupport,sphinx,svgsupport]
rst2pdf --version
```

As requested, `PyPI` (<https://pypi.org/>) is instadlled and options are added to the canonical `pip install rst2pdf` (see also <https://pypi.org/project/rst2pdf/>).

Note that many utilities are now available, including `qr`, `svg2pdf`, `ttx` as well as `sphinx-apidoc|autogen|build|quickstart`.

Spellcheck requires Hunspell and enchant to be available.

### Hunspell 1.7.0 & 1.7.2

Web: <https://hunspell.github.io/>\
Aspell dictionary location: <https://ftp.gnu.org/gnu/aspell/dict/en/>

```bash
wget -qO- https://github.com/hunspell/hunspell/archive/refs/tags/v1.7.0.tar.gz | \
tar xfz -
cd hunspell-1.7.0/
autoreconf -vfi
module load gcc/7
./configure --prefix=$CEUADMIN/hunspell/1.7.0
make
make install
make check
mkdir -p $CEUADMIN/dictionaries/hunspell
cd $CEUADMIN/dictionaries/hunspell
wget https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_GB.aff
wget https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_GB.dic
wget https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.aff
wget https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.dic
wget https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en/hyph_en_GB.dic
wget https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en/hyph_en_US.dic
wget https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en/README_en_GB.txt
wget https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en/README_en_US.txt
wget https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en/README_hyph_en_GB.txt
wget https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en/README_hyph_en_US.txt
cd -
```

and we build ceuadmin/hunspell/1.7.0. 1.7.2 is built similarly.

### enchant2 2.2.0

Web: <https://src.fedoraproject.org/repo/pkgs/enchant2/enchant-2.2.0.tar.gz/>

```bash
wget -qO- ...long sha512 name... enchant-2.2.0.tar.gz | \
tar xfz -
cd enchant-2.2.0/
./configure --prefix=$CEUADMIN/enchant/2.2.0 --enable-relocatable \
            --with-hunspell --with-hunspell-dir=$CEUADMIN/hunspell/dictionaries \
            PKG_CONFIG_PATH=$CEUADMIN/hunspell/1.7.0/lib/pkgconfig
make
make install
```

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
wget -qO- https://plugins.geany.org/geany-plugins/geany-plugins-1.38.tar.gz | \
tar xvfz -
cd geany-plugin-1.38
configure --prefix=$CEUADMIN/geany/1.38 --enable-spellcheck \
          PKG_CONFIG_PATH=$CEUADMIN/geany/1.38/lib/pkgconfig:$CEUAMIN/enchant/2.2.0/lib/pkgconfig
make
make install
```

The `gcc/7` module is loaded since C++17 is required.

To this point, the software as with the utilities is available upon `module load ceuadmin/geany`.

## 2.0

[Geany IDE 2.0 YouTube](https://m.youtube.com/watch?v=VkG1YrNgb7U>)

It requires GTK+ >= 3.24.

```bash
wget -qO- https://github.com/geany/geany/releases/download/2.0.0/geany-2.0.tar.gz | \
tar xvfz -
cd geany-2.0
module load gcc/7
module load ceuadmin/rst2pdf
module load ceuadmin/gtk+/3.24.0
module load glib-2.56.2-gcc-5.4.0-4rjjizl
configure --prefix=$CEUADMIN/geany/2.0 --enable-binreloc=yes PKG_CONFIG_PATH=$CEUADMIN/gtk+/3.24.0/lib/pkgconfig
make
make install
```

The plugins are more involved.

```bash
wget -qO- https://github.com/geany/geany-plugins/releases/download/2.0.0/geany-plugins-2.0.tar.gz | \
tar xfz -
cd geany-plugins-2.0/
module load gcc/7
module load ceuadmin/enchant/2.2.0
module load ceuadmin/gtk+/3.24.0
module load glib-2.56.2-gcc-5.4.0-4rjjizl
configure --prefix=$CEUADMIN/geany/2.0 --with-geany-libdir=$CEUADMIN/geany/2.0/lib \
          --enable-spellcheck \
          PKG_CONFIG_PATH=${CEUADMIN}/enchant/2.2.0/lib/pkgconfig:${CEUADMIN}/gtk+/3.24.0/lib/pkgconfig
make
make check
make install
```

We now have the plugins which can be seen from Tools --> Plugin Manager.

### gtk+ 3.24.0

```bash
wget -qO- https://download.gnome.org/sources/gtk+/3.8/gtk%2B-3.8.0.tar.xz | \
tar xfJ -
cd gtk+-3.24.0
module load ceuadmin/pango/1.41.1 ceuadmin/gettext/0.20
module load cups-2.2.3-gcc-5.4.0-du37l7s
module load glib-2.56.2-gcc-5.4.0-4rjjizl
module load spack/current
source $SPACK_ROOT/share/spack/setup-env.sh
configure --prefix=${CEUADMIN}/gtk+/3.24.0 LIBS=-lintl
make
make install
```

### pango 1.4.1

```bash
wget https://download.gnome.org/sources/pango/1.41/pango-1.41.1.tar.xz
tar xf pango-1.41.1.tar.xz
cd pango-1.41.1/
./configure --prefix=$CEUADMIN/pango/1.41.1
make
make install
```

1.5.2 is also successful but again has permission issue.

### gtk+ 3.90.0

It is as yet not needed, and requires graphene.

```bash
module load ceuadmin/gettext/0.20
wget -qO- https://download.gnome.org/sources/gtk+/3.90/gtk%2B-3.90.0.tar.xz | \
tar xJf -
cd gtk+-3.90.0
configure --prefix=$CEUADMIN/gtk+/3.90.0 PKG_CONFIG_PATH=${CEUADMIN}/graphene/1.8.0/lib64/pkgconfig --enable-static
export LD_LIBRARY_PATH=${CEUADMIN}/graphene/1.8.0/lib64:$LD_LIBRARY_PATH
ln -s ${CEUADMIN}/graphene/1.8.0/share/gir-1.0/Graphene-1.0.gir gsk/Graphene-1.0.gir
ln -s ${CEUADMIN}/graphene/1.8.0/share/gir-1.0/Graphene-1.0.gir gtk/Graphene-1.0.gir
```

Some extra requirement to amend LD_LIBRARY_PATH and addition of Graphene-1.0.gir.

### graphene 1.4.0 & 1.8.0

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
meson setup --prefix=$CEUADMIN/graphene/1.8.0 ..
cd ..
ninja -C _build
ninja -C _build test
ninja -C _build install
```

### cups 2.3.6

```bash
wget -qO- https://github.com/apple/cups/archive/refs/tags/v2.3.6.tar.gz | \
tar xfz -
cd cups-2.3.6
module load ceuadmin/libiconv/1.17
configure --prefix=$CEUADMIN/cups/2.3.6 --with-cups-user
make
make install
```

but it fails to install since root permission is required.
