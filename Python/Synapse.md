---
sort: 12
---

# Synapse

Web: <https://www.synapse.org> ([GitHub](https://github.com/Sage-Bionetworks/))\
Token: <https://www.synapse.org/#!PersonalAccessTokens:>\
Help forum: <https://www.synapse.org/#!SynapseForum:default>

## CSD3 modules

From 7/5/2025, one can now use the dedicated Synapse module `ceuadmin/Synapse/4.8.0`.

For data reformatting, module `ceuadmin/htslib/1.20` is ready to use.

## Setup and usage

The very slim setup is done as follows,

```bash
module load python/3.9.12/gcc/pdcqf4o5
python -m venv 4.8.0
source 4.8.0/bin/activate
pip install synapseclient
pip install synapse
pip cache purge
synapse get -r syn51761394
```

where the last line is for the Fenland SomaLogic pGWAS, <https://www.synapse.org/#!Synapse:syn51761394/wiki/622766>.

---

# Legacy materials

While Synapse itself is well-developed and used as above, the reformatting section below has been updated.

## CSD3 modules

As will be seen below, it is available as companion of both snakemake and Anaconda, namely,

```bash
module load ceuadmin/snakemake
# or anaconda/3.2019-10
module load ceuadmin/gatk
# or 2023.09-0
module load ceuadmin/Anaconda3
```

In all cases, a configure file ~/.synapseConfig can be used with the following specifications,

```
[authentication]
username=<user name>
password=<password>
[endpoints]
repoEndpoint=https://repo-prod.prod.sagebase.org/repo/v1
authEndpoint=https://repo-prod.prod.sagebase.org/auth/v1
fileHandleEndpoint=https://repo-prod.prod.sagebase.org/file/v1
```

which does away with -u -p options (see below).

Synapse also accepts token, e.g., `export SYNAPSE_AUTH_TOKEN=$(cat ~/doc/ukb-ppp-download).`

## 1. Miniconda

### 1.1 Python packages

```bash
module load ceuadmin/snakemake
conda install --prefix ${CEUADMIN}/snakemake/7.19.1 -c conda-forge requests[version='<3'] pandas[version='<1.5'] pysftp jinja2 markupsafe
pip install synapseclient
pip install synapse
```

where we borrow the setup for snakemake to save space. Whenever appropriate, the `synapseclient` can be upgraded.

```bash
pip install --upgrade synapseclient
```

e.g.,

```
UPGRADE AVAILABLE

A more recent version of the Synapse Client (3.2.0) is available. Your version (3.1.1) can be upgraded by typing:
    pip install --upgrade synapseclient

Python Synapse Client version 3.2.0 release notes

https://python-docs.synapse.org/build/html/news.html
```

For GitHub installation, it is recommended that `git clone git@github.com:Sage-Bionetworks/synapsePythonClient.git` to avoid time out.

### 1.2 Command-line tool

This is described pragmatically as follows.

```bash
synapse get -r syn51364943
```

One can specify token, `synapse -p ${SYNAPSE_AUTH_TOKEN} get -r syn51364943`.

### 1.3 Python script

```python
import synapseclient
import synapseutils

syn = synapseclient.Synapse()
syn.login('synapse_username','password')
files = synapseutils.syncFromSynapse(syn, 'syn51364943')
```

To specify token, use `sys.login(authToken=)`; i.e.,

```bash
import os
token = os.environ['token']
syn.logtin(authToken=token)
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
conda install --prefix /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10 \
              -c conda-forge requests[version='<3'] pandas[version='<1.5'] pysftp jinja2 markupsafe
pip install synapseclient
pip install synapse
```

### 2.2 R packages

Web: <https://r-docs.synapse.org/>

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

- In line with requirement of package `rjson` in need of R >= 4.0.0 and built under R 4.3.1 as implemented in module `ceuadmin/R`, One may also install the Python virtual environment as required by package `reticulate`.
- To facilitate installation of the R package(s), we download them and make changes as needed.
- The change to `configure` is necessary, since by default it uses root directories (a user does not have permission) but all Python packages have been installed.

synapser 1.2.0.143 is similar, but calls for `conda install --yes --prefix /usr/local/Cluster-Apps/ceuadmin/snakemake/7.19.1 -c conda-forge pandas pysftp jinja2 markupsafe`.

### 2.3 Command-line tool

It is the same syntax as above.

### 2.4 R script

```r
library(synapser)
library(synapserutils)

synLogin('synapse_username', 'password'", rememberMe=TRUE)
files <- synapserutils::syncFromSynapse('syn51364943')
```

We can also use token,

```bash
  export token=$(cat /home/$USER/doc/ukb-ppp-download)
  Rscript -e '
    library(synapserutils)
    ukb_ppp_download_token <- Sys.getenv("token")
    sysLogin(authToken=ukb_ppp_download_token)
    files <- synapserutils::syncFromSynapse("syn51365301")
  '
```

### 2.5 Anaconda3/2023.09-0

Web: <https://www.anaconda.com/download#downloads>

This updates Anaconda3 including Python 3.11.

```bash
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
bash Anaconda3-2023.09-0-Linux-x86_64.sh
conda install scikit-learn-intelex
python -m sklearnex my_application.py
conda config --set auto_activate_base false
eval "$(/rds/project/jmmh2/rds-jmmh2-public_databases/software/Anaconda3-2023.09-0/bin/conda shell.bash hook)"
/rds/project/jmmh2/rds-jmmh2-public_databases/software/Anaconda3-2023.09-0/bin/conda init
conda activate
python --version
pip install synapseclient
pip install synapse
```

into location `~/rds/public_databases/software/Anaconda3-2023.09-0`. A module as such is loaded with `module load Anaconda3/2023.09-0`.

## 3. Synapse Infrastructure

Web: <https://help.synapse.org/docs/Synapse-Infrastructure.2835382273.html>

[Synapse.org](synapse.org/) is hosted in Amazon Web Service (AWS) in the US-EAST-1 (aka the Standard) region.

[www.synapse.org](www.synapse.org/) is the web-based user interface for users to manage data, projects, profiles and teams,

[repo-prod.prod.sagebase.org](repo-prod.prod.sagebase.org/) is the endpoint for [Synapse Programmatic Clients](https://help.synapse.org/docs/API-Clients-and-Documentation.1985446128.html).

> This table lists the IP addresses [Synapse.org](synapse.org/) uses. These IP addresses are dedicated and granted to Synapse by AWS. Your IT department may need to add these IP addresses to an “allow list” to allow you to connect to Synapse. Make sure to include ALL addresses.

| Host Name                                                                                       | IP Address     |
| ----------------------------------------------------------------------------------------------- | -------------- |
| [www.synapse.org](www.synapse.org/) (web UI)                                                    | &nbsp;         |
| &nbsp;                                                                                          | 34.234.4.162   |
| &nbsp;                                                                                          | 34.233.95.87   |
| &nbsp;                                                                                          | 54.166.5.127   |
| &nbsp;                                                                                          | 54.226.68.127  |
| &nbsp;                                                                                          | 3.215.225.38   |
| &nbsp;                                                                                          | 44.194.89.171  |
| [repo-prod.prod.sagebase.org](repo-prod.prod.sagebase.org/) (endpoint for programmatic clients) | &nbsp;         |
| &nbsp;                                                                                          | 52.45.221.235  |
| &nbsp;                                                                                          | 52.7.75.49     |
| &nbsp;                                                                                          | 3.234.175.106  |
| &nbsp;                                                                                          | 3.88.97.84     |
| &nbsp;                                                                                          | 44.194.236.113 |
| &nbsp;                                                                                          | 54.205.219.117 |

## 4. Application to Biobank Pharma Proteomics Project (UKB-PPP)

- Synapse page, <https://www.synapse.org/#!Synapse:syn51364943>
- pGWAS summary statistics, <https://www.synapse.org/#!Synapse:syn51365301>
- Twitter post, <https://twitter.com/chrisdwhelan/status/1658865452368515072>

### 4.1 Downloads

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

An equivalent script for Olink Explore 3072, not using `cardio`, is as follows,

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

### 4.2 Reformat

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
#SBATCH --partition icelake

#SBATCH --export ALL
#SBATCH --array=1-2940
#SBATCH --output=_reformat_%A_%a.o
#SBATCH --error=_reformat_%A_%a.e

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl
module load ceuadmin/htslib/1.20

export sun23=~/rds/results/public/proteomics/UKB-PPP/sun23
export UKB_PPP="UKB-PPP pGWAS summary statistics"
export UKB_PPP_reformatted="${UKB_PPP} (reformatted)"
export population="European (discovery)"
export prefix=discovery
export src="${sun23}/${UKB_PPP}/${population}"
export dst="${sun23}/${UKB_PPP_reformatted}"

if [ ! -f "${dst}/${population}.lst" ]; then
   ls "${src}" | grep -v MANIFEST | xargs -l -I {} basename {} .tar > "${dst}/${population}.lst"
fi

if [ ! -d "${dst}/${population}" ]; then
   mkdir -p "${dst}/${population}"
fi

export protein=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]' "${dst}/${population}.lst")

tar xf "${src}/${protein}.tar"
(
  chmod -x ${protein}/*
  zcat ${protein}/*gz | head -1
  for chr in {1..22} X
  do
    zcat ${protein}/${prefix}_chr${chr}_*.gz | sed '1d'
  done
) | \
tr ' ' '\t' | \
bgzip -f > "${dst}/${population}/${protein}.bgz"
rm -rf ${protein}
tabix -S1 -s1 -b2 -e2 -f "${dst}/${population}/${protein}.bgz"
```

where we finally use the file extension name `.bgz` (by `bgzip`) to differentiate from the usual `.gz` (by `gzip`).
