<a href="https://www.top500.org/"><img src="https://www.top500.org/static//images/Top500_logo.png" align="right"></a>

# CSD3 applications

![CI](https://github.com/rundocs/jekyll-rtd-theme/workflows/CI/badge.svg?branch=develop)
![jsDelivr](https://data.jsdelivr.com/v1/package/gh/rundocs/jekyll-rtd-theme/badge)

## The collection covers system and other software.

```mermaid
graph LR;
csd3 --> system["THE SYSTEM"]
csd3 --> cardio["CARDIO"]
csd3 --> applications["APPLICATIONS"]
csd3 --> wr["WRITING RELATED"]
system --> System
system --> Login
system --> sysdot["..."]
system --> Contacts
cardio --> cp["CSD3 partition"]
cardio --> lm["Legacy materials"]
applications --> ABCtoolbox
applications --> appdot["..."]
applications --> R["R packages"]
R --> brms
R --> Rdot["..."]
R --> xlsx
applications --> R/xlsx
wr --> fr["Front matter"]
wr --> wrdot["..."]
wr --> td["Test documentation"]
```

{% include list.liquid all=true %}
