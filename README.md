# CSD3 -- Cambridge Service for Data Driven Discovery

<a href="https://www.top500.org/"><img src="https://www.top500.org/static//images/Top500_logo.png" align="right"></a>

![CI](https://github.com/rundocs/jekyll-rtd-theme/workflows/CI/badge.svg?branch=develop)
![jsDelivr](https://data.jsdelivr.com/v1/package/gh/rundocs/jekyll-rtd-theme/badge)

This repository details use of many software for generic purpose and genetic analysis; over time they largely become entries of the [ceuadmin modules](systems/ceuadmin.md) which are ready to use.

```mermaid
graph LR;
jekyll-rtd-theme --> csd3
csd3 --> system["THE SYSTEM"]
csd3 --> Python["Python packages"]
csd3 --> R["R packages"]
csd3 --> applications["APPLICATIONS"]
csd3 --> cardio["CARDIO (legacy materials)"]
system [<a href="https://cambridge-ceu.github.io/csd3/systems/" style="font-size: 25px;font-size:90%"></a>] --> System
system --> sysdot["..."]
system --> Acknowledgement
system --> setup["A. Setup"]
applications [<a href="https://cambridge-ceu.github.io/csd3/applications/" style="font-size: 25px;font-size:90%"></a>] --> ABCtoolbox
applications --> appdot["..."]
applications --> vsc["Visual Studio Code"]
applications --> vep["B. ensmebl-vep"]
Python [<a href="https://cambridge-ceu.github.io/csd3/Python/" style="font-size: 25px;font-size:90%"></a>] --> gwas2vcf
Python --> Pythondot["..."]
Python --> Synase
R [<a href="https://cambridge-ceu.github.io/csd3/R/" style="font-size: 25px;font-size:90%"></a>] --> brms
R --> Rdot["..."]
R --> xlsx
```

{% include list.liquid all=true %}
