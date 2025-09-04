---
sort: 77
---

# tesseract

Web: <https://tesseract-ocr.github.io/>

```bash
module load ceuadmin/leptonica/1.85.0
module load ceuadmin/libgcrypt
module load ceuadmin/autoconf
wget -qO- https://github.com/tesseract-ocr/tesseract/archive/refs/tags/5.5.0.tar.gz | \
tar xvfz -
cd tesseract-5.5.0/
./autogen.sh
./configure --prefix=$CEUADMIN/tesseract/5.5.0 CXXFLAGS="-std=c++17" LDFLAGS="-lstdc++fs"
make && make install
```

It is necessary to set up the languages,

```bash
wget -qO- https://github.com/tesseract-ocr/tessdata_best/archive/refs/tags/4.1.0.tar.gz | \
tar xvfz -
export TESSDATA_PREFIX="/usr/local/Cluster-Apps/ceuadmin/tesseract/5.5.0/share/tessdata_best-4.1.0"
tesseract --list-langs
tesseract lang.jpeg lang -l eng
```

where the last line extract text from `lang.jpeg` into `lang.txt`.

Note further that Chrome/Edge/Firefox extension `OCR Image Reader` calls `tesseract.js`
