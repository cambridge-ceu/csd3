# CSD3 -- Cambridge Service for Data Driven Discovery

<a href="https://www.top500.org/"><img src="https://www.top500.org/static//images/Top500_logo.png" align="right"></a>

![CI](https://github.com/rundocs/jekyll-rtd-theme/workflows/CI/badge.svg?branch=develop)
![jsDelivr](https://data.jsdelivr.com/v1/package/gh/rundocs/jekyll-rtd-theme/badge)

This repository details use of many software for generic purpose and genetic analysis; over time they largely become entries of the [ceuadmin modules](systems/ceuadmin.md) which are ready to use.

```mermaid
graph LR;
jekyll-rtd-theme --> csd3
csd3 --> system[<a href="https://cambridge-ceu.github.io/csd3/systems/" style="font-size: 25px;font-size:90%">THE SYSTEM</a>]
csd3 --> Python[<a href="https://cambridge-ceu.github.io/csd3/Python/" style="font-size: 25px;font-size:90%">Python packages</a>]
csd3 --> R[<a href="https://cambridge-ceu.github.io/csd3/R/" style="font-size: 25px;font-size:90%">R packages</a>]
csd3 --> applications[<a href="https://cambridge-ceu.github.io/csd3/applications/" style="font-size: 25px;font-size:90%">APPLICATIONS</a>]
csd3 --> cardio[<a href="https://cambridge-ceu.github.io/csd3/cardio//" style="font-size: 25px;font-size:90%">APPLICATIONS</a>CARDIO</a>]
system --> System
system --> sysdot["..."]
system --> Acknowledgement
system --> setup["A. Setup"]
applications --> ABCtoolbox
applications --> appdot["..."]
applications --> vsc["Visual Studio Code"]
applications --> vep["B. ensmebl-vep"]
Python --> gwas2vcf
Python --> Pythondot["..."]
Python --> Synase
R --> brms
R --> Rdot["..."]
R --> xlsx
```

{% include list.liquid all=true %}
