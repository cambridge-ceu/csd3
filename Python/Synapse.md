---
sort: 6
---

# Synapse

Web: <https://www.synapse.org> ([GitHub](https://github.com/Sage-Bionetworks/))

## 1. Miniconda

### 1.1 Python packages

```bash
module load ceuadmin/snakemake
pip3 install synapseclient
```

where we borrow the setup for snakemake to save space. Whenever appropriate, the `synapseclient` can be upgraded.

```bash
pip install --upgrade synapseclient
```

### 1.2 Command-line tool

This is described pragmatically as follows.

```bash
synapse get -r syn51364943
```

### 1.3 Python script

```python
import synapseclient
import synapseutils
 
syn = synapseclient.Synapse()
syn.login('synapse_username','password')
files = synapseutils.syncFromSynapse(syn, 'syn51364943')
```

## 2. Anaconda

### 2.1 Python packages

This is required for R packages `synapser` and `synapserutils`, so we take advantage of `anaconda` as for `gatk`.

```bash
module load anaconda/3.2019-10
conda activate /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10
# information: not to update conda but install synapseclient/synpase all over again
# conda update -n base -c defaults conda
# conda init bash
/usr/local/software/anaconda/3.2019-10/bin/conda install --prefix /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10 \
                                                         -c conda-forge requests[version='<3'] pandas[version='<1.5'] pysftp jinja2 markupsafe
pip install synapseclient
pip install synapse
```

### 2.2 R packages

```bash
module load ceuadmin/R
Rscript -e '
  options(repos=c("http://ran.synapse.org", "http://cran.fhcrc.org"))
  download.packages(c("synapser","synapserutils"), ".")
'
tar xvfz synapser_1.1.0.119.tar.gz
cd synapser; comment on "Rscript --vanilla tools/installPythonClient.R $PWD_FROM_R" in `configure`; cd -
R CMD INSTALL synapser
R CMD INSTALL synapserutils_1.0.0.15.tar.gz
```

Several notes are worthwhile,

* In line with requirement of package `rjson` in need of R >= 4.0.0 and built under R 4.3.1 as implemented in module `ceuadmin/R`, One may also install the Python virtual environment as required by package `reticulate`.
* To facilitate installation of the R package(s), we download them and make changes as needed.
* The change to `configure` is necessary, since by default it uses root directories (a user does not have permission) but all Python packages have been installed.

### 2.3 Command-line tool

It is the same syntax as above.

### 2.4 R script

```r
library(synapser)
library(synapserutils)
 
synLogin('synapse_username', 'password')
files <- synapserutils::syncFromSynapse('syn51364943')
```

## 3. Application to Biobank Pharma Proteomics Project (UKB-PPP)

* Synapse page, <https://www.synapse.org/#!Synapse:syn51364943>
* pGWAS summary statistics, <https://www.synapse.org/#!Synapse:syn51365301>
* Twitter post, <https://twitter.com/chrisdwhelan/status/1658865452368515072>

### 3.1 Downloads

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

An equivalent script for Olink Explore 3072, not using `cardio`,  is as follows,

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

synapse login -u <username> -p <user password> --remember-me
synapse get -r syn51365301
```

which requests a large memory from `cclake-himem` and requires a cache created as follows,

```
mkdir /rds/project/jmmh2/rds-jmmh2-results/public/proteomics/UKB-PPP/synapseCache
ln -fs /rds/project/jmmh2/rds-jmmh2-results/public/proteomics/UKB-PPP/synapseCache ~/.synapseCache
```

for by default, the `~/.synapseCache` would have a maximum of <50Gb (or a 55Gb limit) which is quickly overflowed.

### 3.2 Reformat

This step will facilitate practical use, and is illustrated with the European (discovery) data.

The Olink Explore 1536 is done as follows,

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

On reflection, it is somewhat clumsy so we adopt a fuzzy approach to handle Olink Explore 3072 and again not use the decommissioned `cardio`,

```bash
#!/usr/bin/bash

#SBATCH --job-name=_reformatted
#SBATCH --mem=28800
#SBATCH --time=12:00:00

#SBATCH --account PETERS-SL3-CPU
#SBATCH --partition cclake-himem

#SBATCH --export ALL
#SBATCH --array=1-2940
#SBATCH --output=_reformat_%A_%a.o
#SBATCH --error=_reformat_%A_%a.e

export sun23=~/rds/results/public/proteomics/UKB-PPP/sun23
export UKB_PPP="UKB-PPP pGWAS summary statistics"
export UKB_PPP_reformatted="${UKB_PPP} (reformatted)"
export discovery="European (discovery)"
export src="${sun23}/${UKB_PPP}/${discovery}"
export dst="${sun23}/${UKB_PPP_reformatted}"

if [ ! -f "${dst}/${discovery}.lst" ]; then
   ls "${src}" | grep -v MANIFEST | xargs -l -I {} basename {} .tar > "${dst}/${discovery}.lst"
fi

if [ ! -d "${dst}/${discovery}" ]; then
   mkdir -p "${dst}/${discovery}"
fi

export protein=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]' "${dst}/${discovery}.lst")

tar xf "${src}/${protein}.tar"
(
  chmod -x ${protein}/*
  zcat ${protein}/*gz | head -1
  for chr in {1..22} X
  do
    zcat ${protein}/discovery_chr${chr}_*.gz | sed '1d'
  done
) | \
tr ' ' '\t' | \
bgzip -f > "${dst}/${discovery}/${protein}.bgz"
rm -rf ${protein}
tabix -S1 -s1 -b2 -e2 -f "${dst}/${discovery}/${protein}.bgz"
```

where we finally use the file extension name `.bgz` (by `bgzip`) to differentiate the usual `.gz` (by `gzip`).
