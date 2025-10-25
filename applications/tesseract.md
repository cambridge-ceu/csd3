---
sort: 80
---

# tesseract

Web: <https://tesseract-ocr.github.io/>

Note: Chrome/Edge/Firefox extension `OCR Image Reader` calls `tesseract.js`

## Installation

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
# Languages
wget -qO- https://github.com/tesseract-ocr/tessdata_best/archive/refs/tags/4.1.0.tar.gz | \
tar xvfz -
export TESSDATA_PREFIX="/usr/local/Cluster-Apps/ceuadmin/tesseract/5.5.0/share/tessdata_best-4.1.0"
cd $TESSDATA_PREFIX
ln -s /usr/local/Cluster-Apps/ceuadmin/tesseract/5.5.0/share/tessdata/configs
# Modern Greek
wget https://github.com/tesseract-ocr/tessdata_best/raw/main/ell.traineddata
# Ancient Greek
wget https://github.com/tesseract-ocr/tessdata_best/raw/main/grc.traineddata
# Equation detection
wget https://github.com/tesseract-ocr/tessdata_best/raw/main/equ.traineddata
```

## Testing

A list of languages can be viewed and used for OCR from image,

```bash
module load ceuadmin/tesseract
tesseract --list-langs
# ==> ucam.txt
tesseract ucam.jpeg ucam -l eng
# ==> ucam.hocr
tesseract ucam.png ucam -l eng --psm 3 -c tessedit_create_hocr=1
# ==> ucam.pdf
tesseract ucam.png ucam -l eng --psm 3 -c tessedit_create_pdf=1
module load ceuadmin/libiconv ceuadmin/poppler/0.84.0
pdffonts ucam.pdf
```

The last command gives,

```
$ pdffonts ucam.pdf
name                                 type              encoding         emb sub uni object ID
------------------------------------ ----------------- ---------------- --- --- --- ---------
GlyphLessFont                        CID TrueType      Identity-H       yes no  yes      3  0
```

## Tesseract + OCRmyPDF + ghostscript / img2pdf

Several experiments are conducted below,

```bash
source ~/rds/software/py3.11/bin/activate
pip install ocrmypdf
# alpha channel on png
convert ucam.png -alpha remove -alpha off ucam_noalpha.png
convert ucam_noalpha.png ucam_noalpha.pdf
ocrmypdf --tesseract-config hocr -l eng+ell ucam_noalpha.pdf ucam_ocr.pdf
# ghostscript, img2pdf
module load ceuadmin/ghostscript/9.56.1
module load ceuadmin/jbig2enc/0.30
module load ceuadmin/pngquant/3.0.3
## 1st attempt
ocrmypdf -j 5 --force-ocr --optimize 3 --tesseract-timeout 300  -l eng+ell \
         Formulas\ and\ Theorems\ for\ the\ Special\ Functions\ of\ Mathematical\ Physics\,\ 3e.pdf temp_ocr.pdf
gs -o out.pdf -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress temp_ocr.pdf
pdffonts temp_ocr.pdf
## 2nd attempt
pdftoppm -r 450 Formulas\ and\ Theorems\ for\ the\ Special\ Functions\ of\ Mathematical\ Physics\,\ 3e.pdf page -png
img2pdf page-*.png -o image_only.pdf
ocrmypdf -j 5 --force-ocr --optimize 3 --tesseract-timeout 300 -l eng+ell image_only.pdf out2.pdf
```

where and jbig2enc leads to smarter text compression and pngquant for color image compression. We see that

```
## 1st attempt
$ ocrmypdf -j 5 --force-ocr --optimize 3 --tesseract-timeout 300  -l eng+ell \
          Formulas\ and\ Theorems\ for\ the\ Special\ Functions\ of\ Mathematical\ Physics\,\ 3e.pdf temp_ocr.pdf
Scanning contents     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 516/516 0:00:00
Start processing 5 pages concurrently                                                                                               ocr.py:96
...

OCR                   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 516/516 0:00:00
Postprocessing...                                                                                                                  ocr.py:144
PDF/A conversion      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 516/516 0:00:00
Some input metadata could not be copied because it is not permitted in PDF/A. You may wish to examine the output PDF's XMP    _metadata.py:63
metadata.
Linearizing           ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 100/100 0:00:00
Recompressing JPEGs   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 1/1 0:00:00
Deflating JPEGs       ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 1/1 0:00:00
PNGs                  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━   0% 0/0 -:--:--
JBIG2                 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 514/514 0:00:00
Image optimization ratio: 1.19 savings: 16.1%                                                                               _pipeline.py:1002
Total file size ratio: 2.06 savings: 51.4%                                                                                  _pipeline.py:1005
Output file is a PDF/A-2B (as expected)                                                                                        _common.py:474
GPL Ghostscript 9.56.1 (2022-04-04)
Copyright (C) 2022 Artifex Software, Inc.  All rights reserved.
This software is supplied under the GNU AGPLv3 and comes with NO WARRANTY:
see the file COPYING for details.
Processing pages 1 through 516.
$ gs -o out.pdf -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress temp_ocr.pdf
$ pdffonts temp_ocr.pdf
name                                 type              encoding         emb sub uni object ID
------------------------------------ ----------------- ---------------- --- --- --- ---------
NVDUUB+GlyphLessFont                 CID TrueType      Identity-H       yes yes yes   2034  0
ZJFOCW+GlyphLessFont                 CID TrueType      Identity-H       yes yes yes   1631  0
PHSYEO+GlyphLessFont                 CID TrueType      Identity-H       yes yes yes   1734  0
QXKYDM+GlyphLessFont                 CID TrueType      Identity-H       yes yes yes   1838  0
EHRHOZ+GlyphLessFont                 CID TrueType      Identity-H       yes yes yes   1943  0
ORTKYM+GlyphLessFont                 CID TrueType      Identity-H       yes yes yes   2133  0
## 2nd attempt
$ ocrmypdf -j 5 --force-ocr --optimize 3 --tesseract-timeout 300 -l eng+ell image_only.pdf out2.pdf
Scanning contents     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 526/526 0:00:00
Start processing 5 pages concurrently                                                                                               ocr.py:96    3 [tesseract] read_params_file: Can't open txt                                                                           tesseract.py:257
...
OCR                   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 526/526 0:00:00
Postprocessing...                                                                                                                  ocr.py:144
PDF/A conversion      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 526/526 0:00:00
Linearizing           ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 100/100 0:00:00
Recompressing JPEGs   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 4/4 0:00:00
Deflating JPEGs       ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 4/4 0:00:00
PNGs                  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━   0% 0/0 -:--:--
JBIG2                 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━   0% 0/0 -:--:--
Image optimization ratio: 1.01 savings: 0.7%                                                                                _pipeline.py:1002
Total file size ratio: 0.98 savings: -1.6%                                                                                  _pipeline.py:1005
Output file is a PDF/A-2B (as expected)                                                                                        _common.py:474
```

out.pdf keeps all the bookmarks, and is smaller in contrast to out2.pdf with no bookmarks and much larger. In both cases we can check the pdf, e.g.,

```bash
pdffonts out.pdf
pdftotext out.pdf - | less
```

Nevertheless according to `pdffonts temp_ocr.pdf`, one might as well not to use ghostscript at all.
