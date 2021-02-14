---
sort: 32
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
