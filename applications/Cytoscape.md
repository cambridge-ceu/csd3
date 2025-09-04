---
sort: 20
---

# Cytoscape

Web: [https://cytoscape.org/](https://cytoscape.org/).

GitHub: [https://github.com/cytoscape/cytoscape](https://github.com/cytoscape/cytoscape).

## Installation

To start, we experiment with the latest version.

```bash
export HPC_WORK=/rds/user/${USER}/hpc-work
cd ${HPC_WORK}
wget https://github.com/cytoscape/cytoscape/releases/download/3.9.1/Cytoscape_3_9_1_unix.sh
module load openjdk-11.0.2-gcc-5.4.0-3dxltae
bash Cytoscape_3_9_1_unix.sh
cd bin
ln -s ${HPC_WORK}/Cytoscape_v3.9.1/cytoscape.sh
cytoscape.sh
```

To press `<tab>` for a list of commands and press `<ctrl-d>` or `osgi:shutdown` to quit the session. One might as well create a `cytoscape.sh` to load the module automatically such that

```bash
#!/usr/bin/bash

module load openjdk-11.0.2-gcc-5.4.0-3dxltae
${HPC_WORK}/bin/Cytoscape_v3.9.1/cytoscape.sh $@
```

There might be message `karaf: There is a Root instance already running with name Cytoscape 3.9.0 and pid 78872`, then simply,

```bash
export CHECK_ROOT_INSTANCE_RUNNING=false
cytoscape.sh
```

## RCy3

Web: [https://cytoscape.org/RCy3/](https://cytoscape.org/RCy3/).

Bioconductor: [https://bioconductor.org/packages/release/bioc/html/RCy3.html](https://bioconductor.org/packages/release/bioc/html/RCy3.html).

We can first start `RStudio` and then `Cytoscape`, so that the R session detects the Cytoscape session. In the following script, the `enhancedGraphics` and `STRINGapp` apps are also installed.

```r
if (!"RCy3" %in% installed.packages())
{
  install.packages("BiocManager")
  BiocManager::install("RCy3")
}
library(RCy3)
cytoscapePing()
# You are connected to Cytoscape!
cytoscapeVersionInfo()
#     apiVersion cytoscapeVersion
#           "v1"          "3.9.1"
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
installApp("enhancedGraphics")
installApp('STRINGapp')
exportImage("test.pdf",type="PDF",overwriteFile=TRUE)
exportNetwork("test.cyjs","cyjs")
exportNetwork("test.sif","SIF")
exportVisualStyles("test.json","JSON")
saveSession("test.cys")
```

It is necessary to start `cytoscape.sh` followed by `R` command-line interface which is less resource-demanding compared to `RStudio`.

At the end of script, the network image, data as well as style and Cytoscape session are exported.

## cytoscape.js

Web: [https://js.cytoscape.org/](https://js.cytoscape.org/).

### Installation

```bash
npm install cytoscape
```

The tutorial example from [cytoscape](https://blog.js.cytoscape.org/2016/05/24/getting-started/) is adapted as [cytoscape.html](files/cytoscape.html). A more sophisticated example is the [Wine & Cheese Map](http://www.wineandcheesemap.com/) (explained [here](https://blog.js.cytoscape.org/2020/05/11/layouts/#the-problem-of-large-graphs), [GitHub](https://github.com/cytoscape/wineandcheesemap)) showing interactive use of layouts.

The use of Cytoscape JSON (cyjs) and style (json) file is described at [https://github.com/cytoscape/cyjs-sample/wiki](https://github.com/cytoscape/cyjs-sample/wiki).

### RCyjs

The R package is installed with

```r
Rscript -e 'BiocManager::install("RCyjs")'
```

and the toy example from the package vignette,

```r
nodes <- c("A", "T")
g <- graphNEL(nodes, edgemode="directed")
g <- graph::addEdge("A", "T", g)
rcy <- RCyjs(title="RCyjs vignette")
setGraph(rcy, g)
layout(rcy, "grid")
fit(rcy, padding=200)
setDefaultStyle(rcy)
```

## Example applicaiton

Jostins, L., et al., Host–microbe interactions have shaped the genetic architecture of inflammatory bowel disease. Nature, 2012. 491(7422): p. 119-124.
([pdf](https://rdcu.be/c5Zhp), [Cytoscape files](https://static-content.springer.com/esm/art%3A10.1038%2Fnature11582/MediaObjects/41586_2012_BFnature11582_MOESM91_ESM.zip))

## References

Gustavsen, J.A., Pai, S., Isserlin, R., Demchak, B. & Pico, A.R. RCy3: Network biology using Cytoscape from within R. F1000Research 8, 1774:1-21 (2019).

Ideker, T. et al. Integrated genomic and proteomic analyses of a systematically perturbed metabolic network. Science 292, 929-34 (2001).
