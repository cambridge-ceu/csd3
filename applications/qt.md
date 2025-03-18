---
sort: 47
---

# qt

Web: <https://wiki.qt.io/Main>

## 6.8.2

### GitHub

Web: <https://github.com/qt/qt5> ([instructions](https://wiki.qt.io/Building_Qt_6_from_Git))

By default, QtWebEngine/QtPdf requires gcc/10.0 or above, and Python3/html2lib.

```bash
export root=/rds/project/rds-4o5vpvAowP0/software
cd $root
git clone https://github.com/qt/qt5 qt6
cd qt6
git switch 6.8.2
module load gcc/11.2.0/gcc/rjvgspag
module load ninja/1.10.2/gcc/s36yvrfz
module load node-js/14.15.1/gcc/5dha4niw
source ~/rds/public_databases/software/py3.11/bin/activate
pip install html2lib
./init-repository
git submodule update --init --recursive
./configure -prefix $PWD/qtbase
cd $root
mkdir qt6-build
cd qt6-build
../qt6/configure -prefix $CEUADMIN/qt/6.8.2
../qt6./configure --prefix=. -skip qtdoc -skip qttranslations -skip qttools
cmake --build . --parallel 4
cmake --install .
```

and download `qlitehtml` directly from <https://download.qt.io/archive/qt/6.8/6.8.2/submodules/>, as `https://github.com/playground/qlitehtml` is no longer available.

Since it is expected to be amended in the process, the following script is used to clearn partial configuration files,

```bash
rm -f config.status config.log Makefile
rm -rf CMakeCache.txt CMakeFiles/
rm -rf autom4te.cache
```

### Personal account

Fom <https://account.qt.io/> we login, obtain and start

```bash
./qt-online-installer-linux-x64-4.8.1.run
```

to extract to qt-6.8.2.

## 5.15.13

See entry for RStudio.
