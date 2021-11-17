---
sort: 47
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

## RStudio 1.4

This is also the latest version

```bash
wget -qO- https://download1.rstudio.org/desktop/xenial/amd64/rstudio-1.4.1106-amd64-debian.tar.gz | tar xfz -
cd rstudio-1.4
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
