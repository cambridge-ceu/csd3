---
sort: 37
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
