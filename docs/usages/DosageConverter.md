---
sort: 8
---

## DosageConverter

```bash
## assuming you use hpc-work/ with a subdirectory called bin/
cd /rds/user/$USER/hpc-work/
git clone https://github.com/Santy-8128/DosageConvertor
cd DosageConverter
pip install cget --user
module load cmake-3.8.1-gcc-4.8.5-zz55m7x
./install.sh
cd /rds/user/$USER/hpc-work/bin/
ln -s /rds/user/$USER/hpc-work/DosageConvertor/release-build/DosageConvertor
## testing
DosageConvertor  --vcfDose  test/TestDataImputedVCF.dose.vcf.gz \
                 --info     test/TestDataImputedVCF.info \
                 --prefix   test \
                 --type     mach

gunzip -c test.mach.dose.gz | wc -l

DosageConvertor  --vcfDose  test/TestDataImputedVCF.dose.vcf.gz \
                 --info     test/TestDataImputedVCF.info \
                 --prefix   test \
                 --type     plink

gunzip -c test.plink.dosage.gz | wc -l
```

so the MaCH dosage file is individual x genotype whereas PLINK dosage file is genotype x individual.
