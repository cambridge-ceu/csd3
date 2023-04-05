---
sort: 32
---

# PhySO

Web: <https://github.com/WassimTenachi/PhySO>.

## Installation

The download is as usual.

```bash
git clone https://github.com/WassimTenachi/PhySO
```

It takes more than usual resources, which is necessary to get around with SLURM.

```bash
cat << 'EOL' > ~/PhySO.sb
#!/usr/bin/bash

#SBATCH --account CARDIO-SL0-CPU
#SBATCH --partition cardio
#SBATCH --qos=cardio
#SBATCH --mem=28800
#SBATCH --time=12:00:00
#SBATCH --job-name=PhySO
#SBATCH --output=PhySO.o
#SBATCH --error=PhySO.e

export CEUADMIN=/usr/local/Cluster-Apps/ceuadmin

. /etc/profile.d/modules.sh
module load miniconda3/4.5.1
conda activate $CEUADMIN/PhySO

function create()
{
 # This step is doable from a login node
 conda create -y -p $CEUADMIN/PhySO python=3.8
 # The following statements are all automatic recommendations
 ## conda update -n base -c defaults conda
 ## user
 echo ". /usr/local/Cluster-Apps/miniconda3/4.5.1/etc/profile.d/conda.sh" >> ~/.bashrc
 ## All users
 sudo ln -s /usr/local/Cluster-Apps/miniconda3/4.5.1/etc/profile.d/conda.sh /etc/profile.d/conda.sh
 echo "conda activate" >> ~/.bashrc
}

conda install -p $CEUADMIN/PhySO --file requirements.txt
conda install -p $CEUADMIN/PhySO --file requirements_display1.txt
pip install -e
EOL
```

where we have made it available from `/usr/local/Cluster-Apps/ceuadmin` with all the steps to be generated into ~/PhySO.sb, called with `sbatch`.

Tests of package loading and units follow suit from the documentation.

## By-products

It is noticeable that `PyTORCH` is also made available as a dependency.
