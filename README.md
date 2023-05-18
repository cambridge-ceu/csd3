<a href="https://www.top500.org/"><img src="https://www.top500.org/static//images/Top500_logo.png" align="right"></a>

# CSD3 applications

![CI](https://github.com/rundocs/jekyll-rtd-theme/workflows/CI/badge.svg?branch=develop)
![jsDelivr](https://data.jsdelivr.com/v1/package/gh/rundocs/jekyll-rtd-theme/badge)

## The collection covers system and other software.

```mermaid
graph LR;
jekyll-rtd-theme --> csd3
csd3 --> system["THE SYSTEM"]
csd3 --> cardio["CARDIO"]
csd3 --> applications["APPLICATIONS"]
csd3 --> Python["Python packages"]
csd3 --> R["R packages"]
system --> System
system --> sysdot["..."]
system --> Acknowledgement
cardio --> cp["CSD3 partition"]
cardio --> lm["Legacy materials"]
applications --> ABCtoolbox
applications --> appdot["..."]
applications --> vsc["Visual Studio Code"]
Python --> PhySO
Python --> Pythondot["..."]
Python --> snakemake
R --> brms
R --> Rdot["..."]
R --> xlsx
```

{% include list.liquid all=true %}
