---
sort: 44
---

# PRSice

Web page: <https://github.com/choishingwan/PRSice> and <https://choishingwan.github.io/PRSice/>.

## Installation

```bash
cd $HPC_WORK
git clone https://github.com/choishingwan/PRSice
cd PRSice
mkdir build
cd build
module load cmake/3.9
cmake ..
make
ln -sf $HPC_WORK/PRSice/bin/PRSice $HPC_WORK/bin/PRSice
wget https://github.com/choishingwan/PRS-Tutorial/raw/master/resources/GIANT.height.gz
wget -qO- https://github.com/choishingwan/PRS-Tutorial/raw/master/resources/EUR.zip | jar xv
```

The last two commands download/unpack the documentation example, which is described here, <https://choishingwan.github.io/PRS-Tutorial/>, whose scripts are partly extracted [here](files/pgs.sh).

## Module

```bash
module load ceuadmin/PRSice
```
