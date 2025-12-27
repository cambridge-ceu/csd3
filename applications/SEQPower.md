---
sort: 74
---

# SEQPower

Web: <https://bioinformatics.org/spower/>

To start, manually install simuPOP/1.1.7 (<http://sourceforge.net/projects/simupop/files/simupop/1.1.7/simuPOP-1.1.7-src.tar.gz>) as with specific versions of Python packages (notably numpy, numexpr, statsmodels), and follow these steps,

```bash
git clone https://github.com/gaow/SEQPower.git
cd SEQPower
module load gcc/5
source ~/rds/software/py2.7/bin/activate
python setup.py build
python setup.py install
```

The Python package list is as follows,

```
Package         Version
--------------- -------------
cstatgen        rev44
distribute      0.7.3
funcsigs        1.0.2
mock            3.0.5
numexpr         2.7.1
numpy           1.16.6
pandas          0.24.2
patsy           0.5.6
pip             20.3.4
pysam           0.20.0
pysqlite        2.8.3
python-dateutil 2.9.0.post0
pytz            2025.2
scipy           1.2.3
SEQPower        1.1.0.post100
setuptools      44.1.1
simuPOP         1.1.7
six             1.17.0
statsmodels     0.10.2
tables          3.5.2
wheel           0.37.1
```

Sample definitions are provided from <http://bioinformatics.org/spower/download/data/SRV/sfs.tar.gz>, e.g.,

```bash
spower LOGIT Kryukov2009European1800.sfs --sample_size 1000 --OR_rare_detrimental 1.5 --method CFisher \
       -r 1000 -j 4 -l 1 -o exercise
spower LOGIT Kryukov2009European1800.sfs \
--def_rare 0.01 --def_neutral -0.0001 0.0001 --moi A \
--proportion_detrimental 1 --proportion_protective 0 \
--OR_rare_detrimental 1.5 --OR_common_detrimental 1 --baseline_effect 0.01 \
--sample_size 1000 --p1 0.5 --limit 1 \
--alpha 0.05 \
--method \
"KBAC --name K1 --mafupper 0.01 --maflower 0 --alternative 1 --moi additive --permutations 1000 --adaptive 0.1" \
--replicates 1000 \
--jobs 4 -o exercise-simul
```
