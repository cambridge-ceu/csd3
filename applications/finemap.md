---
sort: 24
---

# finemap

Web: [http://www.christianbenner.com/](http://www.christianbenner.com/)

The software include ldstore and finemap.

## Installation

```bash
wget -qO- http://www.christianbenner.com/ldstore_v2.0_x86_64.tgz | \
tar xvfz -
wget -qO- http://www.christianbenner.com/finemap_v1.4_x86_64.tgz | \
tar xvfz -
```

Note that the latest version (1.4) drops options and columns related to causal grouping.

## Testing

```bash
# LDSTORE
cd ldstore_v2.0_x86_64/
ldstore_v2.0_x86_64 --in-files example/data --write-bdose --bdose-version 1.1
ldstore_v2.0_x86_64 --in-files example/data --write-bcor --read-bdose
ldstore_v2.0_x86_64 --in-files example/data --bcor-to-text
# change default
ldstore_v2.0_x86_64 --bcor-to-text --bcor-file example/data.bcor --ld-file example/data.ld
# finamap
cd finemap_v1.4_x86_64
finemap_v1.4_x86_64 --sss --in-files example/master 2>&1 | tee test.log
```

## Python library

```bash
module load python/3.8
virtualenv py38
source py38/bin/activate
pip install https://files.pythonhosted.org/packages/a8/fd/f98ab7dea176f42cb61b80450b795ef19b329e8eb715b87b0d13c2a0854d/ldstore-0.1.9.tar.gz
```

with Python scripts below,

```python
from ldstore.bcor import bcor
myBcor = bcor('example/data.bcor')
myBcor.getFname()
myBcor.getFsize()
myBcor.getMeta().loc[ range( 5 ) ]
myBcor.getNumOfSNPs()
myBcor.getNumOfSamples()
```

We have

```
>>> from ldstore.bcor import bcor
>>> myBcor = bcor('example/data.bcor')
>>> myBcor.getFname()
'example/data.bcor'
>>> myBcor.getFsize()
7723
>>> myBcor.getMeta().loc[ range( 5 ) ]
  rsid  position chromosome allele1 allele2
0  rs1         1         01       A       G
1  rs2         2         01       A       G
2  rs3         3         01       A       G
3  rs4         4         01       A       G
4  rs5         5         01       A       G
>>> myBcor.getNumOfSNPs()
55
>>> myBcor.getNumOfSamples()
5363
>>>
```

## References

Benner C, Spencer CC, Havulinna AS, Salomaa V, Ripatti S, Pirinen M. FINEMAP: efficient variable selection using summary data from genome-wide association studies. Bioinformatics. 2016 May 15;32(10):1493-501. doi: 10.1093/bioinformatics/btw018. Epub 2016 Jan 14. PMID: 26773131; PMCID: PMC4866522.

Benner C, Havulinna AS, Järvelin MR, Salomaa V, Ripatti S, Pirinen M. Prospects of Fine-Mapping Trait-Associated Genomic Regions by Using Summary Statistics from Genome-wide Association Studies. Am J Hum Genet. 2017 Oct 5;101(4):539-551. doi: 10.1016/j.ajhg.2017.08.012. Epub 2017 Sep 21. PMID: 28942963; PMCID: PMC5630179.
