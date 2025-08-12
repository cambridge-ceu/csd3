---
sort: 50
---

# qt

Web: <https://wiki.qt.io/Main>

## 6.8.2

### Personal account

Fom <https://account.qt.io/> we login, obtain and start

```bash
./qt-online-installer-linux-x64-4.8.1.run
```

to extract to qt-6.8.2. It turns out this is the best option!

Our working directory below is as follows,

```bash
export root=/rds/project/rds-4o5vpvAowP0/software
cd $root
module load gcc/11.2.0/gcc/rjvgspag
module load ninja/1.10.2/gcc/s36yvrfz
module load ceuadmin/node/18.20.5
source $root/py3.11/bin/activate
pip install html5lib
```

By default, QtWebEngine/QtPdf requires >gcc/10.0, Python3/html5lib 1.1, and node >14.19.

### Official release

This turns to be easier than GitHub (see below) especially as the latter is problematic with `qttools`.

```bash
wget -qO- https://download.qt.io/official_releases/qt/6.8/6.8.2/single/qt-everywhere-src-6.8.2.tar.xz | \
tar xJf -
cd qt-everywhere-src-6.8.2/
./configure --prefix=. -skip qtdoc -skip qttranslations -skip qttools
cmake --build . --parallel 4
cmake --install .
```

### GitHub

Web: <https://github.com/qt/qt5> ([instructions](https://wiki.qt.io/Building_Qt_6_from_Git))

```bash
git clone https://github.com/qt/qt5 qt6
cd qt6
git switch 6.8.2
./init-repository
git submodule update --init --recursive
./configure -prefix $PWD/qtbase
cd $root
mkdir qt6-build
cd qt6-build
../qt6/configure -prefix $CEUADMIN/qt/6.8.2
../qt6/configure --prefix=. -skip qtdoc -skip qttranslations -skip qttools
cmake --build . --parallel 4
cmake --install .
```

and download `qlitehtml` directly from <https://download.qt.io/archive/qt/6.8/6.8.2/submodules/> followed by changes in qttools/config, etc., as `https://github.com/playground/qlitehtml` is no longer available.

Since it is expected to be amended in the process, the following script is used to clearn partial configuration files,

```bash
rm -f config.status config.log Makefile
rm -rf CMakeCache.txt CMakeFiles/
rm -rf autom4te.cache
```

## 5.15.13

This was done initially for RStudio.

Web: <https://doc.qt.io/qt-5/configure-options.html>, <https://github.com/qt>

The following are side notes on installation of Qt5 according to <https://forums.linuxmint.com/viewtopic.php?t=306738>, though no longer necessary for reasons above.

```bash
git clone git://code.qt.io/qt/qt5.git
cd qt5
git checkout 5.15
perl init-repository
export LLVM_INSTALL_DIR=${HPC_WORK}/llvm
cd -
mkdir qt_build
cd qt_build
../qt5/configure -prefix /usr/local/Cluster-Apps/ceuadmin/qt/6.8.2 -developer-build -opensource -no-sql-mysql -sqlite \
                 -nomake examples -nomake tests -Wno-unused-function -Wno-pragmas -Wno-unused-result -Wno-attributes
gmake
```

The `Makefile` thus generated records the information at its header.

```
/rds/project/jmmh2/rds-jmmh2-public_databases/software/qt_build_5.15.13/qtbase/bin/qmake -o Makefile /rds/project/jmmh2/rds-jmmh2-public_databases/software/qt5/qt.pro -- -opensource -prefix /usr/local/Cluster-Apps/ceuadmin/qt/5.15.13 -developer-build -opensource -nomake examples -nomake tests -Wno-unused-function -Wno-pragmas -Wno-unused-result -Wno-attributes
```

With error `qglobal_p.h: No such file or directory` (5.15.7), according to <https://github.com/alexzorin/lpass-ui/issues/1> we get around with

```bash
ln -sf /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/qt5/qtbase/include/QtCore/5.15.7/QtCore/private /rds/user/jhz22/hpc-work/include/QtCore
```

The installation directory is visible/specified in `qtbase/bin/qt.conf`, namely,

```
[EffectivePaths]
Prefix=..
[DevicePaths]
Prefix=/usr/local/Cluster-Apps/ceuadmin/qt/5.15.13
[Paths]
Prefix=/usr/local/Cluster-Apps/ceuadmin/qt/5.15.13
HostPrefix=/usr/local/Cluster-Apps/ceuadmin/qt/5.15.13
Sysroot=
SysrootifyPrefix=false
TargetSpec=linux-g++
HostSpec=linux-g++
[EffectiveSourcePaths]
Prefix=/rds/project/jmmh2/rds-jmmh2-public_databases/software/qt5/qtbase
```

It requires ninja, `module load ninja;ninja --versions` gives 1.10.0 while `source py27/bin/activate;pip install ninja` uses 1.11.1.
