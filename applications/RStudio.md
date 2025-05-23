---
sort: 53
---

# RStudio

Web: <https://posit.co/> ([GitHub](https://github.com/rstudio/rstudio), [IDE trouble-shooting](https://support.posit.co/hc/en-us/articles/200488508-RStudio-Desktop-IDE-Will-Not-Start), [Latest builds](https://dailies.rstudio.com/rstudio/), [Posit signed builds](https://posit.co/code-signing/))

<font color="red"><b>5/2/2025 Update</b></font>

Module `ceuadmin/rstudio/2025.04.0-278` is now available.

<font color="red"><b>9/9/2024 Update</b></font>

Module `rstudio/2024.04.2+764` now works with R 4.4.1 (from its standard location).

## CSD3 modules

We first check its availability,

```bash
module avail rstudio
```

and we get

```
------------------------------------------------- /usr/local/Cluster-Config/modulefiles --------------------------------------------------
rstudio/0.99/rstudio-0.99    rstudio/1.3.1093             rstudio-server/2023.06.0-421
rstudio/1.1.383              rstudio-server/2021.09.0-351 rstudio-server/2023.09.1-494
```

and

```
----------------------------- /usr/local/software/spack/spack-modules/icelake-20211027/linux-centos8-icelake -----------------------------
rstudio/1.4.1717/gcc/intel-oneapi-mkl/dlvykrma

------------------------------------------------- /usr/local/Cluster-Config/modulefiles --------------------------------------------------
rstudio-server/2021.09.0-351  rstudio-server/2023.09.1-494  rstudio/1.1.383
rstudio-server/2023.06.0-421  rstudio/0.99/rstudio-0.99     rstudio/1.3.1093
```

on cclake and icelake, respectively. The two desktop modules do not work on icelake, and on cclake we could use

```bash
module load rstudio/1.1.383
rstudio
```

This module actually works quite well with `ceuadmin/R/latest`, to be able to render WebGL as required by R/plotly. Nevertheless, the module fails the following test,

```r
suppressMessages(library(dplyr))
INF <- "/rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/INF"
d <- read.csv(file.path(INF,"work","INF1.merge.cis.vs.trans"),as.is=TRUE) %>%
     mutate(log10p=-log10p)
r <- qtl3dplotly(d,zmax=300)
r
```

in that it crashes on the last call trying to display `r`.

Moreover, `rstudio/1.3.1093` cannot be loaded and a fix is available as `ceuadmin/rstudio/1.3.1093` which is also able to work with `ceuadmin/R/latest` but not WebGL.

<font color="red"><b>10/5/2024 Update</b></font>

Module `2023.09.2-508/` is added which works with `ceuadmin/R/4.4.0-icelake`. We have `module avail ceuadmin/rstudio`

```
-------------------------------------------------- /usr/local/Cluster-Config/modulefiles --------------------------------------------------
ceuadmin/rstudio/1.3.1093              ceuadmin/rstudio/2023.09.2-508         ceuadmin/rstudio/2023.09.2-508-icelake
```

<font color="red"><b>9/5/2024 Update</b></font>

Module `2023.09.2-508-icelake/` works with `ceuadmin/R/4.4.0-icelake` which is a significant update from `rstudio/1.1.383`.

<font color="red"><b>2/5/2024 Update</b></font>

Module `ceuadmin/rstudio/2024.04.0-735-icelake` is now available, which can work with R/4.3.3 on CSD3.

<font color="red"><b>4/3/2024 Update</b></font>

Module `ceuadmin/rstudio/2023.12.1+402` is now available, which can work with R/4.2.2 on CSD3.

<font color="red"><b>22/3/2023 Update</b></font>

Module `ceuadmin/rstudio/2023.03.0+386` is now available; there is no need to load gcc/6 and ceuadmin/R/4.2.2. There is also `rstudio-default`.

<font color="red"><b>31/12/2022 Update</b></font>

module `ceuadmin/rstudio/2022.12.0+353` is now available. Since there are issues with libstdc++.so[^libstdc], it loads gcc/6 and ceuadmin/R/4.2.2.

We now use a modified call. The original command is available as `rstudio-default`, with which we see error,

```
[102106:0323/213152.555182:ERROR:bus.cc(398)] Failed to connect to the bus: Could not parse server address: Unknown address type (examples of valid types are "tcp" and on UNIX "unix")
```

<font color="red"><b>27/11/2022 Update</b></font>`module load rstudio/1.3.1093` fails with error messages <font color="blue"><b> and a way forward is as follows,

```bash
# of primary importance
export QT_QPA_PLATFORM=xcb
export QT_PLUGIN_PATH=/usr/lib64/qt5/plugins
# effective by default
export QTDIR=/usr/lib64/qt-3.3
export QTINC=/usr/lib64/qt-3.3/include
export QTLIB=/usr/lib64/qt-3.3/lib
export QT_GRAPHICSSYSTEM_CHECKED=1
# gcc/6 is necessary here, since it is used to build R
# We also take advantage of R's TeX-awareness
module load gcc/6 texlive
rstudio --no-sandbox
```

A fix is provided which is available from `module load ceuadmin/rstudio/1.3.1093`.

The 2022.07.2+576 release is packaged and can be loaded with `module load ceuadmin/rstudio/2022.07.2+576; rstudio`.

<font color="red"><b>26/3/2022 Update</b></font> `module load rstudio/1.3.1093` <font color="blue"><b>now functions well, which enables R packages such as `R/heatmaply`.</b></font>

However, in November 2022 this fails with messages:

```
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, wayland-egl, wayland, wayland-xcomposite-egl, wayland-xcomposite-glx, xcb.

Aborted
```

Additional information could also be seen from `export QT_DEBUG_PLUGINS=1` and run `rstudio` again.

The error messages above can be bypassed with

```bash
export QT_PLUGIN_PATH=/usr/lib64/qt5/plugins
module load rstudio/1.3.1093
```

and also see below[^legacy]. Another environmental variable is QT_QPA_PLATFORM_PLUGIN_PATH, which should point to the `plugins/platforms` directory when a particular QT module is loaded.

## Building from source (incomplete)

Version 2022.12.0+353 dependencies from `rstudio --version-json` are as follows,

```json
{
  "node": "16.14.2",
  "v8": "10.2.154.15-electron.0",
  "uv": "1.43.0",
  "zlib": "1.2.11",
  "brotli": "1.0.9",
  "ares": "1.18.1",
  "modules": "106",
  "nghttp2": "1.45.1",
  "napi": "8",
  "llhttp": "6.0.4",
  "openssl": "1.1.1",
  "cldr": "40.0",
  "icu": "70.1",
  "tz": "2021a3",
  "unicode": "14.0",
  "electron": "19.1.3",
  "chrome": "102.0.5005.167",
  "rstudio": "2022.12.0+353"
}
```

### brotli 1.0.9

```bash
wget -qO- https://github.com/google/brotli/archive/v1.0.9/brotli-1.0.9.tar.gz | tar xfz -
bootstrap
./configure --prefix=${HPC_WORK}
make
make install
```

### icu 70.1

```bash
module load gcc/6
wget -qO- https://github.com/unicode-org/icu/releases/download/release-70-1/icu4c-70_1-src.tgz | tar xfz -
cd icu/source
./configure --prefix=${HPC_WORK}
gmake
gmake install
```

The --enable-static option is also available.

### electron 19.1.3

Web: [https://releases.electronjs.org/release/v19.1.3](https://releases.electronjs.org/release/v19.1/3)

```bash
npm install electron@v19.1.3
```

Note that a symbolic `node_modules` will be replaced with a physical `node_modules/`.

### libuv 1.43.0

```bash
wget -qO- https://dist.libuv.org/dist/v1.43.0/libuv-v1.43.0.tar.gz | tar xfz -
cd libuv-v1.43.0/
autogen.sh
./configure --prefix=$HPC_WORK
make
make install
```

### yaml-cpp

```bash
wget -qO- https://github.com/jbeder/yaml-cpp/archive/refs/tags/yaml-cpp-0.7.0.tar.gz | tar xvfz -
cd yaml-cpp-yaml-cpp-0.7.0/
mkdir build
cd build
make
cmake .. -DCMAKE_INSTALL_PREFIX=$HPC_WORK -DBUILD_SHARED_LIBS=On
make
make install
```

Note that `brotli`, `icu`, `libuv`, `yaml-cpp` are now ceuadmin modules while `nghttp2` is available from <https://src.fedoraproject.org/repo/pkgs/nghttp2/nghttp2-1.45.1.tar.xz/> and chromium from <https://chromium.googlesource.com/chromium/src.git/+/refs/tags/102.0.5005.167>

An attempt with qt is as follows,

```bash
# https://gitlab.freedesktop.org/glvnd/libglvnd/-/tags

module load gcc/6 ceuadmin/gmp/6.2.1 qt-5.9.1-gcc-5.4.0-3qinlch cmake-3.19.7-gcc-5.4-5gbsejo

git clone https://github.com/rstudio/rstudio
cd rstudio
mkdir build
cd build
cmake .. -DRSTUDIO_TARGET=Electron -DRSTUDIO_PACKAGE_BUILD=1 -DCMAKE_INSTALL_PREFIX=$HPC_WORK
cmake -DRSTUDIO_TARGET=Desktop -DRSTUDIO_PACKAGE_BUILD=1 -DCMAKE_INSTALL_PREFIX=$HPC_WORK \
      -DQT_QMAKE_EXECUTABLE=/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/qt-5.9.1-3qinlchrl6vimsn3suwivchqme5do36l/bin ..
```

[^legacy]: **openssl**

    This is with respect to a version under Debian though the Fedora distribution should be used,

    ```bash
    wget -qO- https://download1.rstudio.org/desktop/xenial/amd64/rstudio-1.4.1106-amd64-debian.tar.gz | tar xfz -
    cd rstudio-1.4.1106
    bin/rstudio
    ```

    However it requires openssl.so.1.0.0, which in turn requires specific installation to get away with `No version informaiton for openssl.so.1.0.0`, with `openssl.ld`, according to https://stackoverflow.com/questions/18390833/no-version-information-available, as follows

    ```
    OPENSSL_1.0.0 {
        global:
        *;
    };
    ```

    and

    ```bash
    wget -qO- https://www.openssl.org/source/old/1.0.0/openssl-1.0.0s.tar.gz | tar xfz -
    cd openssl-1.0.0s
    ./config --prefix=${HPC_WORK} shared -Wl,--version-script=${HPC_WORK}/openssl-1.0.0s/openssl.ld
    make
    make install
    ```

    We can proceed after setting `export QT_PLUGIN_PATH=/usr/lib64/qt5/plugins` as above. It is certainly more desirable to do this only once, as follows,

    ```bash
    echo "export QT_PLUGIN_PATH=/usr/lib64/qt5/plugins" >> ~/.bashrc
    ```

    and invoke with `source ~/.bashrc` from current session or automatically from the next onwards.

    It also calls NSPR, which is installed as follows,

    ```bash
    wget -qO-  https://archive.mozilla.org/pub/nspr/releases/v4.35/src/nspr-4.35.tar.gz | \
    tar xfz -
    cd nspr-4.35/nspr
    configure --prefix=${HPC_WORK}
              --with-mozilla \
              --with-pthreads \
              $([ $(uname -m) = x86_64 ] && echo --enable-64bit) &&
    make
    ```
[^libstdc]: **libstdc++**

    A version which satisfies this can be furnished as follows,

    ```bash
    module load gcc-4.9.4-gcc-4.8.5-3sdjf2c
    strings  /usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-4.8.5/gcc-4.9.4-3sdjf2ct5necl5qb26ymnu5ptekysdye/lib64/libstdc++.so.6 | \
    grep GLIBCXX_3.4.20
    ```

    Information can be see from <https://stackoverflow.com/questions/44773296/libstdc-so-6-version-glibcxx-3-4-20-not-found>

    Fedora packages are available from <https://pkgs.org/download/libstdc++.so.6(GLIBCXX_3.4.20)(64bit)> and
    <https://rpmfind.net/linux/rpm2html/search.php?query=libstdc%2B%2B.so.6(GLIBCXX_3.4.20)(64bit)>, e.g.,

    ```bash
    rpm2cpio libstdc++-11.3.1-2.fc34.x86_64.rpm | cpio -idnum
    strings /lib64/libstdc++.so.6 | grep GLIBCXX
    ```
