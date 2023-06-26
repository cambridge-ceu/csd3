---
sort: 43
---

# SMR

Web: https://cnsgenomics.com/software/smr/

```bash
wget https://cnsgenomics.com/software/smr/download/smr_1.03_src.zip
unzip -v smr_1.03_src.zip
mkdir smr
cd smr
unzip ../smr_1.03_src.zip
rm -rf __MACOSX/
mv smr_1.03_src/ ../..
cd ..
rmdir smr
cd ../smr_1.03_src/
module load eigen/latest
module load zlib/1.2.8
make
./smr_linux
```

One may also use the R code for plotting,

```bash
wget https://cnsgenomics.com/software/smr/download/plot.zip
unzip plot.zip
```

The documentation example is done in R as follows,

```r
source("plot_SMR.r")
SMRData = ReadSMRData("ILMN_1719097.ILMN_1719097.txt")
SMRLocusPlot(data=SMRData, smr_thresh=8.4e-6, heidi_thresh=0.05, plotWindow=1000, max_anno_probe=16)
```
