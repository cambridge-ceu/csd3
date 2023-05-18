---
sort: 4
---

# Synapse

Web: <https://www.synapse.org> ([GitHub](https://github.com/Sage-Bionetworks/))

## Command-line tool

### Installation

```bash
module load ceuadmin/snakemake
pip3 install synapseclient
```

where we borrows the setup for snakemake to save space.

### Usage

This is described pragmatically as follows.

```bash
synapse get -r syn51364943
```

Closely related are the Python and R counterparts.

```python
import synapseclient 
import synapseutils 
 
syn = synapseclient.Synapse() 
syn.login('synapse_username','password') 
files = synapseutils.syncFromSynapse(syn, ' syn51364943 ')
```

```r
library(synapser) 
library(synapserutils) 
 
synLogin('synapse_username', 'password') 
files <- synapserutils::syncFromSynapse('syn51364943') 
```

## Application to UKB-PPP data

### Twitter post, <https://twitter.com/chrisdwhelan/status/1658865452368515072>

### pGWAS summary statistics

URL: <https://www.synapse.org/#!Synapse:syn51365301>

### UK Biobank Pharma Proteomics Project (UKB-PPP)

URL: <https://www.synapse.org/#!Synapse:syn51364943>

### SLURM script

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
