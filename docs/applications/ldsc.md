---
sort: 5
---

# ldsc

Web: [https://github.com/bulik/ldsc](https://github.com/bulik/ldsc).

## Installation

We proceed as follows for installation into HPC_WORK=/rds/user/$USER/hpc-work,

```bash
module load python/2.7
virtualenv py27
source py27/bin/activate
cd ${HPC_WORK}
git clone https://github.com/bulik/ldsc
cd ldsc
pip install -r requirements.txt
wget https://data.broadinstitute.org/alkesgroup/LDSCORE/w_hm3.snplist.bz2 | \
bzip2 -d
```

The last two commands also gets the HapMap 3 SNP list. It is worthwhile to note that

- The ldsc documentation suggests Anaconda and on CSD3 we could use the miniconda/2 module, i.e, [https://cambridge-ceu.github.io/csd3/systems/software.html](https://cambridge-ceu.github.io/csd3/systems/software.html), but it is considerably more involved.
- We only need `module load python/2.7` and `source ${HOME}/py27/bin/activate` later on.

## Testing

We use the GIANT BMI data,

```bash
wget -qO- http://portals.broadinstitute.org/collaboration/giant/images/c/c8/Meta-analysis_Locke_et_al%2BUKBiobank_2018_UPDATED.txt.gz | \
gunzip -c > BMI.txt
python munge_sumstats.py --sumstats BMI.txt --a1 Tested_Allele --a2 Other_Allele --merge-alleles w_hm3.snplist --out ldsc --a1-inc
```

Note the munging procedure requests large resources and will be terminated by CSD3, so we better test with a slurm job instead.
