---
sort: 47
---

# qt

Web: <https://wiki.qt.io/Main>

### 6.8.2

GitHub: <https://github.com/qt/qt5> ([instructions](https://wiki.qt.io/Building_Qt_6_from_Git))

```bash
export root=/rds/project/rds-4o5vpvAowP0/software
cd $root
git clone https://github.com/qt/qt5 qt6
cd qt6
git switch 6.8.2
module load ninja/1.10.2/gcc/s36yvrfz
module load node-js/14.15.1/gcc/5dha4niw
module load python/3.8.11/gcc/pqdmnzmw
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

Notes

- litehtml,  <https://github.com/litehtml/litehtml>, is here <https://doc.qt.io/qt-6/qtassistant-attribution-litehtml.html>.
- qlitehtml, <git clone https://gitee.com/suomier/qlitehtml.git>

From <https://account.qt.io/>, we obtain and start with

```bash
./qt-online-installer-linux-x64-4.8.1.run
```

and login to extract to qt-6.8.2.

## 5.15.13

See entry for RStudio.
