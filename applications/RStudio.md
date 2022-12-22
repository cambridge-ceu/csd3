---
sort: 43
---

# RStudio

Web: [https://www.rstudio.com/](https://www.rstudio.com/)

## CSD3 modules

We first check its availability,

```bash
module avail rstudio
```

and it obtains

```
---------------------------------------------------------- /usr/local/Cluster-Config/modulefiles -----------------------------------------------------------
rstudio/0.99/rstudio-0.99    rstudio/1.1.383              rstudio/1.3.1093             rstudio-server/2021.09.0-351
```

so we could use

```bash
module load rstudio/1.1.383
rstudio
```

<font color="red"><b>26/3/2022 Update</b></font> `module load rstudio/1.3.1093` <font color="blue"><b>now functions well, which enables R packages such as `R/heatmaply`.</b></font>

However, in November 2022 this fails with messages:

```
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, wayland-egl, wayland, wayland-xcomposite-egl, wayland-xcomposite-glx, xcb.

Aborted
```

Additional information could also be seen from `export QT_DEBUG_PLUGINS=1` and run `rstudio` again.

The error messages above can be bypassed with[^qt5]

```bash
export QT_PLUGIN_PATH=/usr/lib64/qt5/plugins
module load rstudio/1.3.1093
```

and also see below[^legacy]. Another environmental variable is QT_QPA_PLATFORM_PLUGIN_PATH, which should point to the `plugins/platforms` directory when a particular QT module is loaded.

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

The 2022.07.2+576 release is packaged and can be loaded with `module load ceuadmin/rstudio/2022.07.2+576; rstudio`. However, the libstdc++ issue[^libstdc] is not entirely resolved.

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

[^legacy]:

    ## openssl

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

[^qt5]:

    ## qt/5

    Web: <https://doc.qt.io/qt-5/configure-options.html>

    These are side notes on installation of Qt5 according to <https://forums.linuxmint.com/viewtopic.php?t=306738>, though no longer necessary for reasons above.

    ```bash
    git clone git://code.qt.io/qt/qt5.git
    cd qt5
    git checkout 5.15
    ./init-repository
    export LLVM_INSTALL_DIR=${HPC_WORK}/llvm
    cd -
    mkdir qt_build
    cd qt_build
    ../qt5/configure -prefix /usr/local/Cluster-Apps/ceuadmin/qt/5.15.7 -developer-build -opensource \
                 -nomake examples -nomake tests -Wno-unused-function -Wno-pragmas -Wno-unused-result -Wno-attributes
    make
    make install
    ```

    The `Makefile` thus generated records the information at its header.

    ```
    /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/qt_build/qtbase/bin/qmake -o Makefile /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/qt5/qt.pro -- -prefix /usr/local/Cluster-Apps/ceuadmin/qt/5.15.7 -developer-build -opensource -nomake examples -nomake tests -Wno-unused-function -Wno-pragmas -Wno-unused-result -Wno-attributes
    ```

    With error `qglobal_p.h: No such file or directory`, according to <https://github.com/alexzorin/lpass-ui/issues/1> we get around with

    ```bash
    ln -sf /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/qt5/qtbase/include/QtCore/5.15.7/QtCore/private /rds/user/jhz22/hpc-work/include/QtCore
    ```

    The installation directory is visible/specified in `qtbase/bin/qt.conf`, namely,

    ```
    [EffectivePaths]
    Prefix=..
    [DevicePaths]
    Prefix=/usr/local/Cluster-Apps/ceuadmin/qt/5.15.7
    [Paths]
    Prefix=/usr/local/Cluster-Apps/ceuadmin/qt/5.15.7
    HostPrefix=/usr/local/Cluster-Apps/ceuadmin/qt/5.15.7
    Sysroot=
    SysrootifyPrefix=false
    TargetSpec=linux-g++
    HostSpec=linux-g++
    [EffectiveSourcePaths]
    Prefix=/rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/qt5/qtbase
    ```

    It requires ninja, `module load ninja;ninja --versions` gives 1.10.0 while `source py27/bin/activate;pip install ninja` uses 1.11.1.

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

[^libstdc]:

    ## libstdc++

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
    ````
