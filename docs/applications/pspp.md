---
sort: 24
---

# pspp

Official page: [https://www.gnu.org/software/pspp/](https://www.gnu.org/software/pspp/).

```bash
module load pspp/1.2.0
pspp example.sps
```

where [example.sps](files/example.sps) is the documentation example. Nevertheless `psppire` is not yet functioning.

However, it is possible to compile it directly by using

- gtksourceview 4.0.3 (4.4.0 is more demanding with Python 3.5, meson, Vala, etc.) and use PKG_CONFIG_PATH when appropriate
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

More documentation examples are in the [examples](files/examples) directory.

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
