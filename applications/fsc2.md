---
sort: 26
layout: default
---

# fsc2

Web: <https://cmpg.unibe.ch/software/fastsimcoal2/>

```bash
wget https://cmpg.unibe.ch/software/fastsimcoal2/downloads/fsc28_linux64.zip
unzip fsc28_linux64.zip
cd fsc28_linux64/
chmod +x fsc28
./fsc28
````

which gives command line options. When the module is built, one can use this script.

```bash
module load ceuadmin/fsc2/2.8.0
cd examples
fsc28 -i 1PopDNA.par -n 1 -d -e
module load ceadmin/R
wget https://cmpg.unibe.ch/software/fastsimcoal2/R/ParFileViewer.r
Rscript ParFileViewer.r 1PopDNA.par
Rscript ParFileViewer.r 3PopDNASFS.par
convert 3PopDNASFS.par.pdf 3PopDNASFS.png

```

where an R utility is used to visually inspect the validity of modeled scenarios, [3PopDNASFS.png](files/3PopDNASFS.png).

![](files/3PopDNASFS.png)

Excoffier L, et al. *fastsimcoal2: demographic inference under complex evolutionary scenarios*. *Bioinformatics* 37 (24):4882–4885, 2021.
