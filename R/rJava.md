---
sort: 22
---

# R/rJava

One may see the messages

```
...
checking whether JNI programs can be compiled... configure: error: Cannot compile a simple JNI program. See config.log for details.
...
ERROR: configuration failed for package ‘rJava’
```

so quit R and run

```bash
R CMD javareconf
Rscript -e 'install.packages("rJava")'
```

It might well be that the procedure above fails to work -- a further attempt is to download rJava locally.

```bash
Rscript -e 'download.packages("rJava",".")'
tar xvfz rJava_1.0-6.tar.gz
R CMD INSTALL rJava
```

With Bioconductor package `Rcpi` the `rJava.so` could not be loaded but can be installed inside R, namely.

```
> BiocManager::install("Rcpi")
```
