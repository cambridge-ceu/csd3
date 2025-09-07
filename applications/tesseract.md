---
sort: 78
---

# tesseract

Web: <https://tesseract-ocr.github.io/>

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
# more on hocr: configs is a symbolic link
# ls -l /usr/local/Cluster-Apps/ceuadmin/tesseract/5.5.0/share/tessdata_best-4.1.0/configs
# /usr/local/Cluster-Apps/ceuadmin/tesseract/5.5.0/share/tessdata_best-4.1.0/configs -> tessconfigs/configs
mkdir /usr/local/Cluster-Apps/ceuadmin/tesseract/5.5.0/share/tessdata_best-4.1.0/tessconfigs/configs
echo "hocr" > /usr/local/Cluster-Apps/ceuadmin/tesseract/5.5.0/share/tessdata_best-4.1.0/configs/hocr
echo "tessedit_create_hocr 1" > /usr/local/Cluster-Apps/ceuadmin/tesseract/5.5.0/share/tessdata_best-4.1.0/tessconfigs/configs/hocr
```

## Testing

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

## Tesseract + OCRmyPDF + ghostscript for Vector-based text

A variety of experiments are conducted below,

```bash
module load ceuadmin/tesseract
source ~/rds/software/py3.11/bin/activate
pip install ocrmypdf
# ==> ucam.hocr
tesseract ucam.png ucam -l eng --psm 3 -c tessedit_create_hocr=1
# ==> ucam.pdf
tesseract ucam.png ucam -l eng --psm 3 -c tessedit_create_pdf=1
module load ceuadmin/libiconv ceuadmin/poppler/0.84.0
pdffonts ucam.pdf
# alpha channel on png
convert ucam.png -alpha remove -alpha off ucam_noalpha.png
convert ucam_noalpha.png ucam_noalpha.pdf
ocrmypdf --tesseract-config hocr -l eng ucam_noalpha.pdf ucam_ocr.pdf
# 
module load ceuadmin/ghostscript/
## 1st attempt
ocrmypdf --force-ocr -l eng \
         A\ Companion\ to\ Analysis-A\ Second\ First\ and\ First\ Second\ Course\ in\ Analysis.pdf temp_ocr.pdf && \
gs -o out.pdf -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress temp_ocr.pdf
## 2nd attempt
gs -o rasterized.pdf -sDEVICE=pdfwrite -dFILTERTEXT -dFILTERIMAGE \
   -dColorImageDownsampleType=/Average -dColorImageResolution=300 \
   -dGrayImageDownsampleType=/Average -dGrayImageResolution=300 \
   -dMonoImageDownsampleType=/Subsample -dMonoImageResolution=300 \
    A\ Companion\ to\ Analysis-A\ Second\ First\ and\ First\ Second\ Course\ in\ Analysis.pdf temp_ocr.pdf 
ocrmypdf -l eng rasterized.pdf out.pdf
## 3rd attempt
module load ceuadmin/jbig2enc/0.30
module load ceuadmin/pngquant/3.0.3
pdftoppm -r 300 A\ Companion\ to\ Analysis-A\ Second\ First\ and\ First\ Second\ Course\ in\ Analysis.pdf  page -png
img2pdf page-*.png -o image_only.pdf
ocrmypdf --jbig2-lossless -l eng image_only.pdf out.pdf
```

We see that

```
name                                 type              encoding         emb sub uni object ID
------------------------------------ ----------------- ---------------- --- --- --- ---------
GlyphLessFont                        CID TrueType      Identity-H       yes no  yes      3  0
```

and jbig2enc leads to smarter text compression and pngquant for color image compression.
