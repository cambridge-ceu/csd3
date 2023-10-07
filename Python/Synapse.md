---
sort: 6
---

# Synapse

Web: <https://www.synapse.org> ([GitHub](https://github.com/Sage-Bionetworks/))

## Command-line tool

### Installation

```bash
module load ceuadmin/snakemake
pip3 install synapseclient
```

where we borrow the setup for snakemake to save space. Whenever appropriate, the `synapseclient` can be upgrade,

```bash
pip install --upgrade synapseclient
```

### Usage

This is described pragmatically as follows.

```bash
synapse get -r syn51364943
```

Closely related are the Python

```python
import synapseclient
import synapseutils
 
syn = synapseclient.Synapse()
syn.login('synapse_username','password')
files = synapseutils.syncFromSynapse(syn, 'syn51364943')
```

and R counterparts.


```bash
export R_HOME=/rds/project/jmmh2/rds-jmmh2-public_databases/software/R-4.3.1
```

To fine-tune installation, it is handy to download the package(s) as well

```r
src <- c("http://ran.synapse.org", "http://cran.fhcrc.org")
download.packages(c("synapser","synapserutils"), repos=src, ".")
install.packages(c("synapser","synapserutils"), repos=src)
```

In line with requirement of package `rjson` in need of R >= 4.0.0 and built under R 4.3.1,

Upon success,

```r
library(synapser)
library(synapserutils)
 
synLogin('synapse_username', 'password')
files <- synapserutils::syncFromSynapse('syn51364943')
```

## Application to Biobank Pharma Proteomics Project (UKB-PPP)

* Synapse page, <https://www.synapse.org/#!Synapse:syn51364943> (pGWAS summary statistics, <https://www.synapse.org/#!Synapse:syn51365301>)
* Twitter post, <https://twitter.com/chrisdwhelan/status/1658865452368515072>

### SLURM script

This is for Olink Explore 1536,

```bash
#!/usr/bin/bash

#SBATCH --job-name=_syn51364943
#SBATCH --mem=28800
#SBATCH --time=12:00:00

#SBATCH --account CARDIO-SL0-CPU
#SBATCH --partition cardio
#SBATCH --qos=cardio

#SBATCH --export ALL
#SBATCH --output=_syn51364943.o
#SBATCH --error=_syn51364943.e

module load ceuadmin/snakemake/7.19.1
synapse login -u <username> -p <user password> --remember-me
synapse get -r syn51364943
```

An equivalent script for Olink Explore 3072, not using cardio,  is as follows,

```bash
#!/usr/bin/bash

#SBATCH --job-name=_syn51365301
#SBATCH --mem=28800
#SBATCH --time=12:00:00

#SBATCH --account PETERS-SL3-CPU
#SBATCH --partition cclake-himem

#SBATCH --export ALL
#SBATCH --output=_syn51365301.o
#SBATCH --error=_syn51365301.e

. /etc/profile.d/modules.sh
module purge
module load rhel7/default-ccl
module load ceuadmin/snakemake/7.19.1

synapse login -u jhz -p jhz22@Synapse --remember-me
synapse get -r syn51365301
```

which requests a large memory from `cclake-himem` and requires a cache created as follows,

```
mkdir /rds/project/jmmh2/rds-jmmh2-results/public/proteomics/UKB-PPP/synapseCache
ln -fs /rds/project/jmmh2/rds-jmmh2-results/public/proteomics/UKB-PPP/synapseCache ~/.synapseCache
```

### Merging and indexing

This step will facilitate practical use, and is illustrated with the European (discovery) data.

```bash
#!/usr/bin/bash

#SBATCH --job-name=_reformatted
#SBATCH --mem=28800
#SBATCH --time=12:00:00

#SBATCH --account CARDIO-SL0-CPU
#SBATCH --partition cardio
#SBATCH --qos=cardio

#SBATCH --export ALL
#SBATCH --array=1-1472
#SBATCH --output=_%A_%a.o
#SBATCH --error=_%A_%a.e

export sun22=~/rds/results/public/proteomics/UKB-PPP/sun22
export UKB_PPP=UKB-PPP\ pGWAS\ summary\ statistics
export UKB_PPP_reformatted=${UKB_PPP}\ \(reformatted\)
export discovery=European\ \(discovery\)
export src="${sun22}/${UKB_PPP}/${discovery}"
export dst="${sun22}/${UKB_PPP_reformatted}"

if [ ! -f "${dst}/${discovery}.lst" ]; then
   ls "${src}" | grep -v MANIFEST | xargs -l -I {} basename {} .tar > "${dst}/${discovery}.lst"
fi

function dup_list()
{
cat << 'EOL'
CKMT1A_CKMT1B_P12532_OID20721_v1_Inflammation
DEFA1_DEFA1B_P59665_OID20344_v1_Cardiometabolic
DEFB4A_DEFB4B_O15263_OID21373_v1_Oncology
EBI3_IL27_Q14213_Q8NEV9_OID21389_v1_Oncology
FUT3_FUT5_P21217_Q11128_OID21013_v1_Neurology
IL12A_IL12B_P29459_P29460_OID21327_v1_Oncology
LGALS7_LGALS7B_P47929_OID21406_v1_Oncology
MICB_MICA_Q29980_Q29983_OID20593_v1_Inflammation
EOL
}

export protein=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]' "${dst}/${discovery}.lst")
export protein_tar=$(echo ${protein} | sed 's/_/:/g')

export dup=$(dup_list | grep ${protein})
if [ ${dup} != "" ]; then
   export protein_tar=$(echo ${protein} | sed 's/_/:/2' | rev | sed 's/_/:/;s/_/:/;s/_/:/' | rev)
fi

cd "${dst}/${discovery}"
tar xf "${src}/${protein}.tar"
(
  chmod -x ${protein}/*
  zcat ${protein}/*gz | head -1
  for chr in {1..22} X
  do
    zcat ${protein}/discovery_chr${chr}_${protein_tar}.gz | sed '1d'
  done
) | \
tr ' ' '\t' | \
bgzip -f > "${dst}/${discovery}/${protein}.gz"
rm -rf ${protein}
tabix -S1 -s1 -b2 -e2 -f "${dst}/${discovery}/${protein}.gz"
```

where eight compound proteins are handled specifically.
