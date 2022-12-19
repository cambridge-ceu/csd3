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

The 2022.07.2+576o release is packaged and can be loaded with `module load ceuadmin/rstudio/2022.07.2+576; rstudio`.

## 2022.12.0-353

We have the following error message,

```
/usr/local/Cluster-Apps/ceuadmin/rstudio/2022.12.0+353/resources/app/bin/rsession: /lib64/libstdc++.so.6: version `CXXABI_1.3.8' not found (required by /rds-d4/user/jhz22/hpc-work/lib/libicuuc.so.50)
/usr/local/Cluster-Apps/ceuadmin/rstudio/2022.12.0+353/resources/app/bin/rsession: /lib64/libstdc++.so.6: version `CXXABI_1.3.8' not found (required by /rds-d4/user/jhz22/hpc-work/lib/libicui18n.so.50)

```

We only need to remove ${HPC_WORK}/lib/libicu* -- it can be installed as follows,

```bash
wget -qO- https://github.com/unicode-org/icu/releases/download/release-50-2/icu4c-50_2-src.tgz | tar xfz -
cd icu/source
./configure --prefix=${HPC_WORK}
gmake
gmake install
```

## Building from source (incomplete)

Some notes are kept here,

```bash
# https://gitlab.freedesktop.org/glvnd/libglvnd/-/tags

wget -qO- https://github.com/jbeder/yaml-cpp/archive/refs/tags/yaml-cpp-0.7.0.tar.gz | tar xvfz -
cd yaml-cpp-yaml-cpp-0.7.0/
mkdir build
cd build
make
cmake .. -DCMAKE_INSTALL_PREFIX=$HPC_WORK -DBUILD_SHARED_LIBS=On
make
make install

module load gcc/6 ceuadmin/gmp/6.2.1 qt-5.9.1-gcc-5.4.0-3qinlch cmake-3.19.7-gcc-5.4-5gbsejo

git clone https://github.com/rstudio/rstudio
cd rstudio
mkdir build
cd build
cmake .. -DRSTUDIO_TARGET=Electron -DRSTUDIO_PACKAGE_BUILD=1 -DCMAKE_INSTALL_PREFIX=$HPC_WORK
cmake -DRSTUDIO_TARGET=Desktop -DRSTUDIO_PACKAGE_BUILD=1 -DCMAKE_INSTALL_PREFIX=$HPC_WORK \
      -DQT_QMAKE_EXECUTABLE=/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/qt-5.9.1-3qinlchrl6vimsn3suwivchqme5do36l/bin ..
```

Note that `yaml-cpp` is now a ceuadmin module.

[^legacy]: ## Legacy notes

    This is with respect to the latest version under Debian,

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

    ### Failure to start R

    The error message is shown below,

    ### R Session Startup Failure Report

    #### RStudio Version

    RStudio 2021.09.2+382, "Ghost Orchid" (fc9e2179, 2022-01-04) for CentOS 7

    Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.12.8 Chrome/69.0.3497.128 Safari/537.36

    #### Error message

    [No error available]

    #### Process Output

    The R session exited with code 1.

    Error output:

    ```
    /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/R/rstudio-2021.09.2+382/bin/rsession: /usr/lib64/libstdc++.so.6: version `CXXABI_1.3.8' not found (required by /rds-d4/user/jhz22/hpc-work/lib/libicuuc.so.50)
    /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/R/rstudio-2021.09.2+382/bin/rsession: /usr/lib64/libstdc++.so.6: version `CXXABI_1.3.8' not found (required by /rds-d4/user/jhz22/hpc-work/lib/libicui18n.so.50)
    ```

    Standard output:

    ```
    [No output emitted]
    ```

    #### Logs

    _/home/jhz22/.local/share/rstudio/log/rsession-jhz22.log_

    ```
    2022-01-13T17:06:06.694306Z [rsession-jhz22] ERROR R.getOption: rstudio.errors.suppressed made from non-main thread; LOGGED FROM: SEXPREC* rstudio::r::options::getOption(const string&) src/cpp/r/ROptions.cpp:83
    2022-01-13T17:06:06.758853Z [rsession-jhz22] ERROR evaluateExpression called from thread other than main; LOGGED FROM: rstudio::core::Error rstudio::r::exec::{anonymous}::evaluateExpressionsUnsafe(SEXP, SEXP, SEXPREC**, rstudio::r::sexp::Protect*, rstudio::r::exec::{anonymous}::EvalType) src/cpp/r/RExec.cpp:140
    2022-01-13T17:06:06.758853Z [rsession-jhz22] ERROR evaluateExpression called from thread other than main; LOGGED FROM: rstudio::core::Error rstudio::r::exec::{anonymous}::evaluateExpressionsUnsafe(SEXP, SEXP, SEXPREC**, rstudio::r::sexp::Protect*, rstudio::r::exec::{anonymous}::EvalType) src/cpp/r/RExec.cpp:140
    ```

    This is easily fixed with the usual setup for R, e.g,.

    ```bash
    module load gcc/6
    module load pcre/8.38
    module load texlive
    ```

[^qt5]: ## qt/5

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
