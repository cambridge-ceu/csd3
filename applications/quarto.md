---
sort: 44
---

# quarto

Web page <https://quarto.org/> ([Guide](https://quarto.org/docs/guide/))

It is an open-source scientific and technical publishing system; the Linux version is able to run a script in TypeScript, R, Python, or Lua.

## Installation

### 1.7.13

```bash
wget -qO- https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.13/quarto-1.7.13-linux-rhel7-amd64.tar.gz | \
tar xfz -
mv quarto-1.7.13/ 1.7.13
module load ceuadmin/R
wget https://raw.githubusercontent.com/quarto-dev/quarto-web/refs/heads/main/docs/presentations/revealjs/demo/index.qmd
wget https://raw.githubusercontent.com/quarto-dev/quarto-web/refs/heads/main/docs/presentations/revealjs/demo/actors.js
wget https://raw.githubusercontent.com/quarto-dev/quarto-web/refs/heads/main/docs/presentations/revealjs/demo/styles.css
quarto render index.qmd --to html
module load ceuadmin/chrome
chrome index.html &
```

After installation therevealjs demo files are downloaded and rendered as [a web page](files/quarto).

A whole repository is furnished as follows,

```bash
git clone https://raw.githubusercontent.com/quarto-dev/quarto-web
cd docs/presentations/revealjs/demo
```

### 1.4.549

This fixed the problem on GLIBC_2.18 as in 1.3.450.

```bash
wget -qO- https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.549/quarto-1.4.549-linux-rhel7-amd64.tar.gz | \
tar xvfz -
```

giving quarto-1.4.549/ with `bin/quarto`, among others.

### 1.3.450

It requires CentOS 8 (icelake, or login-q-\*); otherwise it fails with message: `GLIBC_2.18` not found.

To enter icelake, simply issue `ssh login-q-1`, say. Now, we obtain the package as usual,

```bash
wget -qO- https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.tar.gz | \
tar xvfz -
```

For R, we take advantage of the module,

```bash
module load R/4.3.1-icelake
```

but saw this error message,

```
$ R
> dyn.load("/usr/local/Cluster-Apps/R/4.3.1-icelake/lib64/R/modules//R_X11.so")
Error in dyn.load("/usr/local/Cluster-Apps/R/4.3.1-icelake/lib64/R/modules//R_X11.so") :
  unable to load shared object '/usr/local/Cluster-Apps/R/4.3.1-icelake/lib64/R/modules//R_X11.so':
  /rds/user/jhz22/hpc-work/lib/libgnutls.so.30: undefined symbol: mpn_copyi, version HOGWEED_6
> dyn.load("/usr/local/Cluster-Apps/R/4.3.1-icelake/lib64/R/library/grDevices/libs//cairo.so")
Error in dyn.load("/usr/local/Cluster-Apps/R/4.3.1-icelake/lib64/R/library/grDevices/libs//cairo.so") :
  unable to load shared object '/usr/local/Cluster-Apps/R/4.3.1-icelake/lib64/R/library/grDevices/libs//cairo.so':
  /rds/user/jhz22/hpc-work/lib/libgnutls.so.30: undefined symbol: mpn_copyi, version HOGWEED_6
>
```

It turns out `gnutls` relies on `nettle` and in turn on `libhogweed`; the `/usr/lib64/hogweed.so.2` conflicts with `libhogweed.so.6`.

### nettle

Web: <https://ftp.gnu.org/gnu/nettle>

Our script is slightly more involved as follows,

```bash
./configure --prefix=$HPC_WORK LDFLAGS=-L$HPC_WORK/lib64 LIBS=-lhogweed --disable-openssl \
            --with-lib-path=/usr/local/Cluster-Apps/ceuadmin/gmp/6.2.1/lib \
            --with-include-path=/usr/local/Cluster-Apps/ceuadmin/gmp/6.2.1/include
make
make install
```

### gnutls

Web: <https://www.gnutls.org/>

The syntax for configuration is as follows,

```bash
./configure --prefix=$HPC_WORK --with-included-unistring --with-nettle-mini --enable-ssl3-support \
            CFLAGS=-I$HPC_WORK/include LDFLAGS=-L$HPC_WORK/lib LIBS=-lhogweed LIBS=-lunbound LIBS=-ltspi \
            --enable-sha1-support --disable-guile
make
make install
```

It is necessary to edit `lib/pkcs11_privkey.c` to make `ck_rsa_pkcs_pss_params` definition explicit. Then there is error with guile so we use --disable-guile.

### jupyter

Web: <https://jupyter.org/>

```bash
module load python/3.8.11/gcc/pqdmnzmw
python3 -m pip install jupyter --target=${PWD}/python
export PYTHONPATH=${PWD}/python:$PYTHONPATH
```

### R

To enable `rmarkdown`, we need to get around issue of no Internet on icelake with the following before entering `login-q-1`,

```r
packages <- c("base64enc","bslib","cachem","cli","digest",
              "ellipsis","evaluate","fastmap","fontawesome","fs",
              "glue","htmltools","jquerylib","jsonlite","knitr",
              "lifecycle","memoise","mime","R6","rappdirs",
              "rlang","rmarkdown","sass","stringi","stringr",
              "tinytex","vctrs","xfun","yaml")
download.packages(packages,".")
install.packages(dir(pattern="tar.gz"),lib="R",repos=NULL)
```

somewhat repetitive nonetheless successful since some are package dependencies.

Add ${PWD} to `R_LIBS`. Furthermore, to allow for generality, python and R directories are symbollically linked.

### ceuadmin/quarto

The cumbersome steps above have been wrapped in the named module.

```bash
module load ceuadmin/quarto
```

```
Loading ceuadmin/quarto/1.3.450-icelake
  Loading requirement: libmd/1.0.3/gcc/pwhyd3ij libbsd/0.11.3/gcc/tpfgc3ec expat/2.4.1/gcc/qkcdojqk ncurses/6.2/gcc/givuz2aq
    readline/8.1/gcc/bumlt4j6 gdbm/1.21/gcc/owivzl33 libiconv/1.16/gcc/4miyzf3w libxml2/2.9.12/gcc/eizlvpgn gettext/0.21/gcc/qnrcglqo
    libffi/3.3/gcc/6f53tcd4 sqlite/3.36.0/gcc/nvjhfk62 tcl/8.6.11/gcc/n7xje3xl inputproto/2.3.2/gcc/f3ah2nfx kbproto/1.0.7/gcc/vmr33qom
    libpthread-stubs/0.4/gcc/hk2rtxtr xproto/7.0.31/gcc/d6patqa5 libxau/1.0.8/gcc/svcqvn56 libxdmcp/1.1.2/gcc/bpi3jojs
    xcb-proto/1.14.1/gcc/xanx7ixn libxcb/1.14/gcc/ebmzubym xextproto/7.3.0/gcc/aahfrcpd xtrans/1.3.5/gcc/snbqxol5 libx11/1.7.0/gcc/oovez2cu
    font-util/1.3.2/gcc/im7lvzz3 libpng/1.6.37/gcc/bkdpz5q4 freetype/2.11.0/gcc/jdz5khbp util-linux-uuid/2.36.2/gcc/wjrz5f3u
    fontconfig/2.13.93/gcc/7fyscyaq renderproto/0.11.1/gcc/2akuvanz libxrender/0.9.10/gcc/5e3iug2k libxft/2.3.2/gcc/ucporpzv
    libxext/1.3.3/gcc/eq7cyrku scrnsaverproto/1.2.2/gcc/sbkbtjzo libxscrnsaver/1.2.2/gcc/6hjlwbjv tk/8.6.11/gcc/i5j46nlm
    python/3.8.11/gcc/pqdmnzmw R/4.3.1-icelake
```

```bash
quarto check
```

```
[✓] Checking versions of quarto binary dependencies...
      Pandoc version 3.1.1: OK
      Dart Sass version 1.55.0: OK
[✓] Checking versions of quarto dependencies......OK
[✓] Checking Quarto installation......OK
      Version: 1.3.450
      Path: /usr/local/Cluster-Apps/ceuadmin/quarto/1.3.450-icelake/bin

[✓] Checking basic markdown render....OK

[✓] Checking Python 3 installation....OK
      Version: 3.8.11
      Path: /usr/local/software/spack/spack-views/rhel8-icelake-20211027_2/python-3.8.11/gcc-11.2.0/pqdmnzmwkrtp4e3gjibmcxho7g6ekpat/bin/python3
      Jupyter: 5.3.1
      Kernels: python3

[✓] Checking Jupyter engine render....OK

[✓] Checking R installation...........OK
      Version: 4.3.1
      Path: /usr/local/Cluster-Apps/R/4.3.1-icelake/lib64/R
      LibPaths:
        - /usr/local/Cluster-Apps/ceuadmin/quarto/R
        - /usr/local/Cluster-Apps/R/4.3.1-icelake/lib64/R/library
        - /rds/project/jmmh2/rds-jmmh2-public_databases/software/R
        - /rds/project/jmmh2/rds-jmmh2-public_databases/software/R-4.3.1/library
      knitr: 1.43
      rmarkdown: 2.23

[✓] Checking Knitr engine render......OK
```

### texlive

This is necessary for rendering PDF, which is enabled as usual,

```bash
module load texlive/2015
```

## Usage

```bash
module load ceuadmin/quarto
quarto --help
```

```
  Usage:   quarto
  Version: 1.3.450

  Description:

    Quarto CLI

  Options:

    -h, --help     - Show this help.
    -V, --version  - Show the version number for this program.

  Commands:

    render          [input] [args...]     - Render files or projects to various document types.
    preview         [file] [args...]      - Render and preview a document or website project.
    serve           [input]               - Serve a Shiny interactive document.
    create          [type] [commands...]  - Create a Quarto project or extension
    create-project  [dir]                 - Create a project for rendering multiple documents
    convert         <input>               - Convert documents to alternate representations.
    pandoc          [args...]             - Run the version of Pandoc embedded within Quarto.
    run             [script] [args...]    - Run a TypeScript, R, Python, or Lua script.
    add             <extension>           - Add an extension to this folder or project
    install         [target...]           - Installs an extension or global dependency.
    publish         [provider] [path]     - Publish a document or project. Available providers include:
    check           [target]              - Verify correct functioning of Quarto installation.
    help            [command]             - Show this help or the help of a sub-command.
```

We can prooceed with a [`test.qmd`](https://github.com/cambridge-ceu/csd3/tree/master/applications/files/test.qmd) with
`quarto render test.qmd` to obtain `test.html`. It is also possible to obtain other formats, e.g., `quarto render test.qmd --to docx`.

We can also invoke `RStutio`, which embeds `quarto`, e.g., `module load ceuadmin/rstudio; rstudio` and render the document there.
