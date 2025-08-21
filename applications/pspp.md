---
sort: 54
---

# pspp

Official page: [https://www.gnu.org/software/pspp/](https://www.gnu.org/software/pspp/) ([News](https://www.gnu.org/software/pspp/NEWS)).

## 2.0.1

To compfile from source, we copy `ceuadmin/[gettext/0.20, libiconv/1.17, libxml2/2.9.10]` to ${HPC_WORK} together with the prerequistes,

```bash
module load ceuadmin/gtksourceview/4.0.3
module load ceuadmin/spread-sheet-widget
```

then it proceeds smoothly. The module `ceuadmin/pspp/2.0.1` still needs `ceuadmin/libiconv/1.17` loaded first though.

### flatpak

The installation was successful as before but the required storage is too much / kernel is too high.

## 2.0.0

```bash
module load ceuadmin/libiconv/1.17
module load ceuadmin/automake/1.16.5
mkdir $CEUADMIN/pspp/2.0.0
cd $CEUADMIN/pspp/2.0.0
wget -qO- https://ftp.gnu.org/gnu/pspp/pspp-2.0.0.tar.gz | tar xvfz -
cd pspp-2.0.0
./configure --prefix=/usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0
make
make install
```

We still make change in Makefile on the line (adding `--force --no-validate`)

> MAKEINFO = ${SHELL} '/usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0/pspp-2.0.0/build-aux/missing' makeinfo --force --no-validate

The operation on perl is still necessary

```
cd perl-module && /usr/bin/perl Makefile.PL    OPTIMIZE="-g -O2 -DGCC_LINT \
   -I/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/zlib-1.2.11-lnf7bswyozdhprbg7jo6n5ha5633ftj2/include \
   -I/rds/user/jhz22/hpc-work/include/libpng15 -I/rds/user/jhz22/hpc-work/include \
   -I/rds-d4/user/jhz22/hpc-work/include/fribidi -I/usr/include/cairo -I/usr/include/glib-2.0 \
   -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/uuid -I/usr/include/libdrm \
   -I/usr/include/pango-1.0 -I/usr/include/harfbuzz   -Wno-error"    LD="`/usr/bin/perl -e 'use Config::Perl::V;print Config::Perl::V::myconfig()->{config}{ld};'` -lreadline -ltinfo"
gcc -c  -I"/usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0/pspp-2.0.0" -I"/usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0/pspp-2.0.0/src" -I"/usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0/pspp-2.0.0/gl" -I"/usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0/pspp-2.0.0/gl" -I"/usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0/pspp-2.0.0" -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -g -O2 -DGCC_LINT    -I/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/zlib-1.2.11-lnf7bswyozdhprbg7jo6n5ha5633ftj2/include    -I/rds/user/jhz22/hpc-work/include/libpng15 -I/rds/user/jhz22/hpc-work/include    -I/rds-d4/user/jhz22/hpc-work/include/fribidi -I/usr/include/cairo -I/usr/include/glib-2.0    -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/uuid -I/usr/include/libdrm    -I/usr/include/pango-1.0 -I/usr/include/harfbuzz   -Wno-error   -DVERSION=\"2.0.0\" -DXS_VERSION=\"2.0.0\" -fPIC "-I/usr/lib64/perl5/CORE" -std=gnu99 -Wno-implicit-function-declaration PSPP.c
cd -
```

### flatpak

The use of flatpak is possible with these operations,

```bash
# root privilege is required
# echo 20000 > /proc/sys/user/max_user_namespaces
# https://wiki.archlinux.org/title/Bubblewrap

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo --user
mkdir -p $CEUADMIN/pspp/2.0.0
export FLATPAK_USER_DIR=$CEUADMIN/pspp/2.0.0
flatpak install --user flathub org.gnu.pspp
flatpak list
flatpak run org.gnu.pspp
```

## 2.0.0-pre1ge32bec

The source is <https://benpfaff.org/~blp/pspp-master/20230624103130/source/pspp-2.0.0-pre1ge32bec.tar.gz>.

In `Makefile`, we replace `makeinfo` with `makeinfo --force --no-validate`,

The binaries thus produced can be merged into GNU binary build (with errors from GLIBCXX on its own):

<https://benpfaff.org/~blp/pspp-master/20230624103130/x86_64/pspp-2.0.0-pre1ge32bec-x86_64-build20230624103419.tar.gz>

We proceed with `module load ceuadmin/pspp/2.0.0-pre1ge32bec`.

Direct use of binary distribution is implicit with these modules,

```bash
module load ceuadmin/gettext/0.21 ceuadmin/readline/8.0
module load automake-1.15.1-gcc-5.4.0-kqipzs7 cairo/1.16.0
module load gcc/6 gtkplus-2.24.31-gcc-5.4.0-2a7zfti
module load libtool-2.4.6-gcc-6.2.0-sqmr7cn
module load pango-1.40.3-gcc-5.4.0-32phpcz
```

provided that GLIBCxx could be sorted out, i.e.,

```
bin/pspp: /usr/lib64/libc.so.6: version `GLIBC_2.34' not found (required by bin/pspp)
bin/pspp: /usr/lib64/libc.so.6: version `GLIBC_2.33' not found (required by /usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0-pre1ge32bec/lib/pspp/libpspp-2.0.0-pre1ge32bec.so)
bin/pspp: /usr/lib64/libm.so.6: version `GLIBC_2.29' not found (required by /usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0-pre1ge32bec/lib/pspp/libpspp-2.0.0-pre1ge32bec.so)
bin/pspp: /usr/lib64/libc.so.6: version `GLIBC_2.25' not found (required by /usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0-pre1ge32bec/lib/pspp/libpspp-core-2.0.0-pre1ge32bec.so)
bin/pspp: /usr/lib64/libc.so.6: version `GLIBC_2.26' not found (required by /usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0-pre1ge32bec/lib/pspp/libpspp-core-2.0.0-pre1ge32bec.so)
bin/pspp: /usr/lib64/libc.so.6: version `GLIBC_2.32' not found (required by /usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0-pre1ge32bec/lib/pspp/libpspp-core-2.0.0-pre1ge32bec.so)
bin/pspp: /usr/lib64/libc.so.6: version `GLIBC_2.33' not found (required by /usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0-pre1ge32bec/lib/pspp/libpspp-core-2.0.0-pre1ge32bec.so)
bin/pspp: /usr/lib64/libc.so.6: version `GLIBC_2.34' not found (required by /usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0-pre1ge32bec/lib/pspp/libpspp-core-2.0.0-pre1ge32bec.so)
bin/pspp: /usr/lib64/libm.so.6: version `GLIBC_2.29' not found (required by /usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0-pre1ge32bec/lib/pspp/libpspp-core-2.0.0-pre1ge32bec.so)
bin/pspp: /usr/lib64/libpq.so.5: no version information available (required by /usr/local/Cluster-Apps/ceuadmin/pspp/2.0.0-pre1ge32bec/lib/pspp/libpspp-core-2.0.0-pre1ge32bec.so)
```

## 1.6.0

A couple of Perl modules are required and can be made available as follows,

```bash
perl -MCPAN -e shell
install Config::Perl::V
install Memory::Usage
```

Assuming `libreadline` is installed from [https://ftp.gnu.org/gnu/readline/](https://ftp.gnu.org/gnu/readline/), the installation then proceeds with

```bash
module load libiconv-1.15-gcc-5.4.0-ymwv5vs
module load gettext-0.19.8.1-gcc-5.4.0-zaldouz
module load texinfo-6.3-gcc-5.4.0-gszsfum

wget -qO- https://ftp.nluug.nl/pub/gnu/pspp/pspp-1.6.0.tar.gz | \
tar xvfz -
cd pspp-1.6.0
configure --prefix=$HPC_WORK LDFLAGS="-lreadline -ltinfo" --with-gnu-ld
make
```

Near the end we see complaints about Perl module and we specifically run the following code

```bash
cd perl-module && /usr/bin/perl Makefile.PL \
   OPTIMIZE="-g -O2 -DGCC_LINT \
   -I/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/zlib-1.2.11-lnf7bswyozdhprbg7jo6n5ha5633ftj2/include \
   -I/rds/user/jhz22/hpc-work/include/libpng15 -I/rds/user/jhz22/hpc-work/include \
   -I/rds-d4/user/jhz22/hpc-work/include/fribidi -I/usr/include/cairo -I/usr/include/glib-2.0 \
   -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/uuid -I/usr/include/libdrm \
   -I/usr/include/pango-1.0 -I/usr/include/harfbuzz   -Wno-error" \
   LD="`/usr/bin/perl -e 'use Config::Perl::V;print Config::Perl::V::myconfig()->{config}{ld};'` -lreadline -ltinfo"
cd -
make
make install
```

where we drop `PREFIX=/rds/user/jhz22/hpc-work` after `Makefile.PL` and furnish the installation with another `make/make install`.

Note that the Windows version is available from [https://caeis.etech.fh-augsburg.de/downloads/windows/pspp-win-daily/1.6.0-ge6b96c/](https://caeis.etech.fh-augsburg.de/downloads/windows/pspp-win-daily/1.6.0-ge6b96c/).

The software package is available with `module load ceuadmin/pspp/1.6.0`.

Once the GUI is started, we can open `/usr/local/Cluster-Apps/ceuadmin/pspp/2.0.1/share/pspp/examples/regress_categorical.sps`

```spss
set decimal=dot.

title 'Demonstrate REGRESSION procedure'.
/*      run this syntax file with the command:
/*                 pspp example.stat
/*
/*      Output is written to the file "pspp.list".

data list / v0 1-2 (A) v1 v2 3-22 (10).
begin data.
b  7.735648 -23.97588
b  6.142625 -19.63854
a  7.651430 -25.26557
c  6.125125 -16.57090
a  8.245789 -25.80001
c  6.031540 -17.56743
a  9.832291 -28.35977
c  5.343832 -16.79548
a  8.838262 -29.25689
b  6.200189 -18.58219
end data.

list.

freq /variables=v0 v1 v2.

regression /variables= v1 v2 /statistics defaults /dependent=v2 /method=enter.
```

and excute thee code.

## 1.4.1

Version 1.4.1 requires spread-sheet-widget 0.6 and we follow the following steps,

```bash
wget http://alpha.gnu.org/gnu/ssw/spread-sheet-widget-0.7.tar.gz
tar xvfz spread-sheet-widget-0.7.tar.gz
cd spread-sheet-widget-0.7
./configure --prefix=$HPC_WORK
make
make install
export PREFIX=/rds/user/$USER/hpc-work
export GTKSOURCEVIEW_CFLAGS=-I${PREFIX}/include/gtksourceview-4
export GTKSOURCEVIEW_LIBS="-L${PREFIX}/lib -lgtksourceview-4"
wget http://mirror.lyrahosting.com/gnu/pspp/pspp-1.4.1.tar.gz
tar xvfz pspp-1.4.1.tar.gz
cd pspp-1.4.1
./configure --prefix=${PREFIX}
```

Again we removed PREFIX= in call to perl-module/Makefile.PL.

Finally, the LD = flag was not set in perl-module/Makefile and we use LD = 'gcc'.

---

The package seems really attractive with its support for over 1 billion cases and 1 billion variables, while giving the appeal of data visualisation in SPSS. The following is an example code generated by the package to read/list GREAT annotation.

```pspp
GET DATA
  /TYPE=TXT
  /FILE="IL12B-all.tsv"
  /ARRANGEMENT=DELIMITED
  /DELCASE=LINE
  /FIRSTCASE=2
  /DELIMITERS="\t"
  /VARIABLES=
    Ontology A21
    ID A10
    Desc A158
    BinomRank F3.0
    BinomP F12.7
    BinomBonfP F9.0
    BinomFdrQ F10.2
    RegionFoldEnrich F9.5
    ExpRegions F12.7
    ObsRegions F1.0
    GenomeFrac F12.8
    SetCov F5.2
    HyperRank F3.0
    HyperP F12.7
    HyperBonfP F9.0
    HyperFdrQ F9.2
    GeneFoldEnrich F9.5
    ExpGenes F12.7
    ObsGenes F2.0
    TotalGenes F5.0
    GeneSetCov F6.3
    TermCov F12.7
    Regions A193
    Genes A98.
VARIABLE LEVEL Ontology (SCALE).
VARIABLE ALIGNMENT Ontology (RIGHT).
VARIABLE WIDTH Ontology (8).
VARIABLE LEVEL ID (SCALE).
VARIABLE ALIGNMENT ID (RIGHT).
VARIABLE WIDTH ID (8).
VARIABLE LEVEL Desc (SCALE).
VARIABLE ALIGNMENT Desc (RIGHT).
VARIABLE WIDTH Desc (8).
VARIABLE LEVEL Regions (SCALE).
VARIABLE ALIGNMENT Regions (RIGHT).
VARIABLE WIDTH Regions (8).
VARIABLE LEVEL Genes (SCALE).
VARIABLE ALIGNMENT Genes (RIGHT).
VARIABLE WIDTH Genes (8).
list.
```

## 1.2.0

```bash
module load pspp/1.2.0
pspp example.sps
```

where [example.sps](files/example.sps) is the documentation example. Nevertheless `psppire` is not yet functioning.

However, it is possible to compile it directly by using

- gtksourceview[^gsv] 4.0.3 (4.4.0 is more demanding with Python 3.5, meson, Vala, etc.) and use PKG_CONFIG_PATH when appropriate

  ```bash
  ./configure --prefix=$HPC_WORK CFLAGS=-I$HPC_work/include LDFLAGS=-L$HPC_WORK/lib LIBS=-lintl --enable-static
  make
  make install
  ```

  See [https://www.gnu.org/software/gettext/FAQ.html](https://www.gnu.org/software/gettext/FAQ.html) for any error messages.

- spread-sheet-widget-0.3
- fribidi-1.0.8
- GTKSOURVIEW_CFLAGS and GTKSOURVIEW_LIBS in the configuration.

```bash
export PREFIX=/rds/user/$USER/hpc-work
export GTKSOURCEVIEW_CFLAGS=-I${PREFIX}/include/gtksourceview-4
export GTKSOURCEVIEW_LIBS="-L${PREFIX}/lib -lgtksourceview-4"
./configure --prefix=${PREFIX}
make
make install
```

note that it is necessary to comment on the statement `kludge = gtk_source_view_get_type ();` from `src/ui/gui/widgets.c`
and to remove the `PREFIX=` specification in the Perl part of compiling, i.e,

```
cd perl-module
/usr/bin/perl Makefile.PL PREFIX=/rds/user/$USER/hpc-work OPTIMIZE="-g -O2 -I/rds-d4/user/$USER/hpc-work/include/fribidi -I/usr/include/cairo -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng15 -I/usr/include/uuid -I/usr/include/libdrm -I/usr/include/pango-1.0 -I/usr/include/harfbuzz  "
```

Now we can execute [plot.sps](files/plot.sps)

```bash
psppire plot.ps &
```

More documentation examples are in the [examples](https://github.com/cambridge-ceu/csd3/tree/master/applications/files/examples) directory.

[^gsv]: gtksourceview 4.6.0 installation

    ```bash
    source py37/bin/activate
    python -m pip install meson==0.63.3
    python -m pip install --force-reinstall  ninja==1.10.0
    wget -qO- https://github.com/GNOME/gtksourceview/archive/refs/tags/4.6.0.tar.gz | tar xfz -
    cd gtksourceview-4.6.0
    mkdir build
    meson configure --prefix=$CEUADMIN/gtksourcereview/4.6.0 --default-library=both
    meson build
    cd build
    ninja install
    ```

    where ninja releases are seen from [https://github.com/ninja-build/ninja/releases](https://github.com/ninja-build/ninja/releases). One may need to insert -L$HPC_WORK/lib -I$HPC_WORK/include to the command manually.
