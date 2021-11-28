---
sort: 11
---

# Cytoscape

Web: [https://cytoscape.org/](https://cytoscape.org/).

GitHub: [https://github.com/cytoscape/cytoscape](https://github.com/cytoscape/cytoscape).

## Installation

To start, we experiment with the latest version.

```bash
export HPC_WORK=/rds/user/${USER}/hpc-work
cd ${HPC_WORK}
wget https://github.com/cytoscape/cytoscape/releases/download/3.9.0/Cytoscape_3_9_0_unix.sh
module load openjdk-11.0.2-gcc-5.4.0-3dxltae
bash Cytoscape_3_9_0_unix.sh
cd bin
ln -s ${HPC_WORK}/Cytoscape_v3.9.0/cytoscape.sh
cytoscape.sh
```

To press `<tab>` for a list of commands and press `<ctrl-d>` or `osgi:shutdown` to quit the session.

## RCy3

We can first start `RStudio` and then `Cytoscape`, so that an R session can detect the Cytoscape session.

```bash
library(RCy3)
cytoscapePing()
# You are connected to Cytoscape!
cytoscapeVersionInfo()
#     apiVersion cytoscapeVersion
#           "v1"          "3.9.0"
browseVignettes("RCy3")
# from the first vignette
nodes <- data.frame(id=c("node 0","node 1","node 2","node 3"),
           group=c("A","A","B","B"), # categorical strings
           score=as.integer(c(20,10,15,5)), # integers
           stringsAsFactors=FALSE)
edges <- data.frame(source=c("node 0","node 0","node 0","node 2"),
           target=c("node 1","node 2","node 3","node 3"),
           interaction=c("inhibits","interacts","activates","interacts"),  # optional
           weight=c(5.1,3.0,5.2,9.9), # numeric
           stringsAsFactors=FALSE)
createNetworkFromDataFrames(nodes,edges, title="my first network", collection="DataFrame Example")
```

Additional vignettes are listed at [https://bioconductor.org/packages/release/bioc/html/RCy3.html](https://bioconductor.org/packages/release/bioc/html/RCy3.html).

### Reference

Gustavsen, J.A., Pai, S., Isserlin, R., Demchak, B. & Pico, A.R. RCy3: Network biology using Cytoscape from within R. F1000Research 8, 1774:1-21 (2019).
