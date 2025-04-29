---
sort: 11
---

# CAVIAR/eCAVIAR

Web: [https://github.com/fhormoz/caviar](https://github.com/fhormoz/caviar)

## Installation

It is now hosted at GitHub and the installation is straightforward.

```bash
git clone https://github.com/fhormoz/caviar.git
cd caviar/CAVIAR-C++
make
```

## Testing

Based on `sample_data/` we can run through the following script,

```bash
CAVIAR -l sample_data/50_LD.txt -z CAVIAR-C++/sample_data/50_Z.txt -o 50
CAVIAR -l sample_data/DDB1.top100.sig.SNPs.ld -z CAVIAR-C++/sample_data/DDB1.top100.sig.SNPs.ZScores -o 100
eCAVIAR -l sample_data/GWAS.ADGC.MC.AD.IGAP.stage1.hg19.chr.11.121344805.121517613.CHRPOSREFALT.LD.ld \
        -l sample_data/eQTL.CARDIOGENICS.MC.AD.IGAP.stage1.hg19.chr.11.121344805.121517613.CHRPOSREFALT.LD.ld \
        -z sample_data/GWAS.MC.AD.IGAP.stage1.hg19.chr.11.121344805.121517613.CHRPOSREFALT.Z.txt \
        -z eQTL.CARDIOGENICS.MC.AD.IGAP.stage1.hg19.chr.11.121344805.121517613.CHRPOSREFALT.ILMN_1810712.NM_015313.1.ARHGEF12.Z.txt \
        -o 75
```

## References

Hormozdiari, F., et al., Identifying Causal Variants at Loci with Multiple Signals of Association. _Genetics_, 2014. 198(2): p. 497-508.

Hormozdiari, F., et al., Colocalization of GWAS and eQTL Signals Detects Target Genes. _Am J Hum Genet_, 2016. 99(6): p. 1245-1260.
