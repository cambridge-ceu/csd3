---
sort: 35
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
rstudio/0.99/rstudio-0.99 rstudio/1.1.383           rstudio/1.3.1093
```

We intend to use the most recent version with `module load rstudio/1.3.1093; rstudio` but it fails with messages:

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
rstudio &
```

Another environmental variable is QT_QPA_PLATFORM_PLUGIN_PATH, which should point to the `plugins/platforms` directory when a particular QT module is loaded.

## RStudio 1.4

### Fedora 19/Red Hat 7

Version 1.4 allows for plots to be placed inside RStudio. We use the tarball as of 11/1/2022,

```bash
wget -qO- https://download1.rstudio.org/desktop/centos7/x86_64/rstudio-2021.09.2-382-x86_64-fedora.tar.gz | \
tar xfz -
cd rstudio-2021.09.2+382/
bin/rstudio
```

We could use `ln -sf ${PWD}/bin/rstudio ${HPC_WORK}/bin/rstudio` for instance to call later on.

### Failure to start R

The error message is shown below,

## R Session Startup Failure Report

### RStudio Version

RStudio 2021.09.2+382, "Ghost Orchid" (fc9e2179, 2022-01-04) for CentOS 7

Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.12.8 Chrome/69.0.3497.128 Safari/537.36

### Error message

[No error available]

### Process Output

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

### Logs

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

### --- Legacy notes

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

## qt/5

These are side notes on installation of Qt5 according to https://forums.linuxmint.com/viewtopic.php?t=306738, but no longer necessary for reasons above.

```bash
git clone git://code.qt.io/qt/qt5.git
cd qt5
git checkout 5.12
./init-repository
export LLVM_INSTALL_DIR=${HPC_WORK}/llvm
../qt5/configure -developer-build -opensource -nomake examples -nomake tests
make
```
