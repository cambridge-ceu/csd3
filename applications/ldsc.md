---
sort: 21
---

# ldsc

Web: [https://github.com/bulik/ldsc](https://github.com/bulik/ldsc) ([Google group](https://groups.google.com/g/ldsc_users/)).

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

- The ldsc documentation suggests Anaconda and on CSD3 we could use the miniconda/2 module, i.e, [https://cambridge-ceu.github.io/csd3/systems/software.html#python](https://cambridge-ceu.github.io/csd3/systems/software.html#python), but it is considerably more involved.
- We only need `module load python/2.7` and `source ${HOME}/py27/bin/activate` later on.

## Testing

We use the GIANT BMI data,

```bash
wget -qO- http://portals.broadinstitute.org/collaboration/giant/images/c/c8/Meta-analysis_Locke_et_al%2BUKBiobank_2018_UPDATED.txt.gz | \
gunzip -c > BMI.txt
python munge_sumstats.py --sumstats BMI.txt --a1 Tested_Allele --a2 Other_Allele --merge-alleles w_hm3.snplist --out BMI --a1-inc
```

Note the munging procedure requests large resources and will be terminated by CSD3, so we better test with a SLURM job instead.

## Analysis

### Heritability partition

We now complete the download on frequencies, baseline model LD scores, and regression weights and furnish this.

```bash
wget -qO- https://storage.googleapis.com/broad-alkesgroup-public/LDSCORE/1000G_Phase1_frq.tgz | tar xvfz -
wget -qO- https://storage.googleapis.com/broad-alkesgroup-public/LDSCORE/1000G_Phase1_baseline_ldscores.tgz | tar xvfz -
wget -qO- https://storage.googleapis.com/broad-alkesgroup-public/LDSCORE/weights_hm3_no_hla.tgz | tar xvfz -
```

Our batch file is as follows,

```
#!/usr/bin/bash

#SBATCH --job-name=BMI
#SBATCH --account CARDIO-SL0-CPU
#SBATCH --partition cardio
#SBATCH --qos=cardio
#SBATCH --mem=28800
#SBATCH --time=5-00:00:00
#SBATCH --output=/rds/user/jhz22/hpc-work/work/_BMI_%A_%a.out
#SBATCH --error=/rds/user/jhz22/hpc-work/work/_BMI_%A_%a.err
#SBATCH --export ALL

export TMPDIR=/rds/user/$USER/hpc-work/work

module load python/2.7
source ${HOME}/py27/bin/activate
cd ${HPC_WORK}/ldsc
python munge_sumstats.py --sumstats BMI.txt --a1 Tested_Allele --a2 Other_Allele --merge-alleles w_hm3.snplist --out BMI --a1-inc
python ldsc.py\
	--h2 BMI.sumstats.gz\
	--ref-ld-chr baseline/baseline.\
	--w-ld-chr weights_hm3_no_hla/weights.\
	--overlap-annot\
	--frqfile-chr 1000G_frq/1000G.mac5eur.\
	--out BMI_baseline
```

and our results are contained in the tab-delimited file named `BMI_baseline.result` -- note in particular the CNS enrichment P=8.30e-24.

### Cell type analysis

We carry on with the download,

```bash
wget -qO- https://storage.googleapis.com/broad-alkesgroup-public/LDSCORE/1000G_Phase1_cell_type_groups.tgz | \
tar xvfz -
```

and for CNS, we have

```bash
python ldsc.py\
        --h2 BMI.sumstats.gz\
        --w-ld-chr weights_hm3_no_hla/weights.\
        --ref-ld-chr cell_type_groups/CNS.,baseline/baseline.\
        --overlap-annot\
        --frqfile-chr 1000G_frq/1000G.mac5eur.\
        --out BMI_CNS\
        --print-coefficients
```

and our results are now contained in the tab-delimited file named `BMI_CNS.results`.

We next use the `--h2-cts` option with the Cahoy data analysis in a nutshell,

```bash
export cts_name=Cahoy
wget -qO- https://storage.googleapis.com/broad-alkesgroup-public/LDSCORE/LDSC_SEG_ldscores/${cts_name}_1000Gv3_ldscores.tgz | \
tar xfvz -
wget -qO- https://storage.googleapis.com/broad-alkesgroup-public/LDSCORE/1000G_Phase3_baseline_ldscores.tgz | \
tar xvfz -
ldsc.py\
    --h2-cts BMI.sumstats.gz \
    --ref-ld-chr 1000G_EUR_Phase3_baseline/baseline. \
    --out BMI_${cts_name} \
    --ref-ld-chr-cts $cts_name.ldcts \
    --w-ld-chr weights_hm3_no_hla/weights.
```

The output `BMI_Cahoy.cell_type_results.txt` is sufficiently small to include here,

| Name            | Coefficient            | Coefficient_std_error  | Coefficient_P_value  |
| --------------- | ---------------------- | ---------------------- | -------------------- |
| Neuron          | 4.4874060288359995e-09 | 2.48025909733557e-09   | 0.035206172355899706 |
| Oligodendrocyte | 8.067689953393081e-10  | 2.569340962599481e-09  | 0.376761120478732    |
| Astrocyte       | -4.036699628095808e-09 | 2.0886996416620756e-09 | 0.9733595763245972   |

In line with the finding above, we have a P=0.035 for neurons.

### Genetic correlation

We carry on to calculate the genetic correlation (rg) between BMI and height. First, we obtain the LD scores,

```bash
wget -qO- https://data.broadinstitute.org/alkesgroup/LDSCORE/eur_w_ld_chr.tar.bz2 | \
tar xjf -
```

followed by downloading and munging height GWAS summary statistics

```bash
wget -qO- http://portals.broadinstitute.org/collaboration/giant/images/0/01/GIANT_HEIGHT_Wood_et_al_2014_publicrelease_HapMapCeuFreq.txt.gz | \
gunzip -c > height.txt
python munge_sumstats.py --sumstats height.txt \
                         --snp MarkerName --a1 Allele1 --a2 Allele2 --merge-alleles w_hm3.snplist --p p --out height --a1-inc
```

but again it will be killed and we need a SLURM job as above. On CSD3, it took a staggering 14hr.

Our analysis then proceeds with

```bash
python ldsc.py \
      --rg BMI.sumstats.gz,height.sumstats.gz \
      --ref-ld-chr eur_w_ld_chr/ \
      --w-ld-chr eur_w_ld_chr/ \
      --out BMI_height
```

It took just under 16s and `BMI_height.log` contains the desired output quoted below

```
*********************************************************************
* LD Score Regression (LDSC)
* Version 1.0.1
* (C) 2014-2019 Brendan Bulik-Sullivan and Hilary Finucane
* Broad Institute of MIT and Harvard / MIT Department of Mathematics
* GNU General Public License v3
*********************************************************************
Call:
./ldsc.py \
--ref-ld-chr eur_w_ld_chr/ \
--out BMI_height \
--rg BMI.sumstats.gz,height.sumstats.gz \
--w-ld-chr eur_w_ld_chr/

Beginning analysis at Wed Aug  4 07:11:02 2021
Reading summary statistics from BMI.sumstats.gz ...
Read summary statistics for 1019865 SNPs.
Reading reference panel LD Score from eur_w_ld_chr/[1-22] ... (ldscore_fromlist)
Read reference panel LD Scores for 1290028 SNPs.
Removing partitioned LD Scores with zero variance.
Reading regression weight LD Score from eur_w_ld_chr/[1-22] ... (ldscore_fromlist)
Read regression weight LD Scores for 1290028 SNPs.
After merging with reference panel LD, 1014995 SNPs remain.
After merging with regression SNP LD, 1014995 SNPs remain.
Computing rg for phenotype 2/2
Reading summary statistics from height.sumstats.gz ...
Read summary statistics for 1217311 SNPs.
After merging with summary statistics, 1014995 SNPs remain.
993172 SNPs with valid alleles.

Heritability of phenotype 1
---------------------------
Total Observed scale h2: 0.2104 (0.0066)
Lambda GC: 2.7872
Mean Chi^2: 3.9573
Intercept: 1.0292 (0.0298)
Ratio: 0.0099 (0.0101)

Heritability of phenotype 2/2
-----------------------------
Total Observed scale h2: 0.342 (0.0176)
Lambda GC: 2.0007
Mean Chi^2: 2.9726
Intercept: 1.2239 (0.033)
Ratio: 0.1135 (0.0167)

Genetic Covariance
------------------
Total Observed scale gencov: 0.1517 (0.0047)
Mean z1*z2: 2.0178
Intercept: 0.738 (0.0148)

Genetic Correlation
-------------------
Genetic Correlation: 0.5656 (0.0081)
Z-score: 70.1339
P: 0.


Summary of Genetic Correlation Results
p1                  p2      rg      se        z    p  h2_obs  h2_obs_se  h2_int  h2_int_se  gcov_int  gcov_int_se
BMI.sumstats.gz  height.sumstats.gz  0.5656  0.0081  70.1339  0.0   0.342     0.0176  1.2239      0.033     0.738       0.0148

Analysis finished at Wed Aug  4 07:11:18 2021
Total time elapsed: 15.56s
```

and rg=0.57.
