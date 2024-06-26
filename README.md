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
system --> System
system --> sysdot["..."]
system --> Acknowledgement
system --> setup["Appendix A. Setup"]
applications --> ABCtoolbox
applications --> appdot["..."]
applications --> vsc["Visual Studio Code"]
applications --> vep["Appendix B. ensmebl-vep"]
Python --> gwas2vcf
Python --> Pythondot["..."]
Python --> Synase
R --> brms
R --> Rdot["..."]
R --> xlsx
```

{% include list.liquid all=true %}
