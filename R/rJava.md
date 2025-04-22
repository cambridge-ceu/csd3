---
sort: 31
---

# rJava

One may see the messages

```
...
checking whether JNI programs can be compiled... configure: error: Cannot compile a simple JNI program. See config.log for details.
...
ERROR: configuration failed for package ‘rJava’
```

so quit R and run

```bash
R CMD javareconf -e
Rscript -e 'install.packages("rJava")'
```

It might well be that the procedure above fails to work -- a further attempt is to download rJava locally.

```bash
Rscript -e 'download.packages("rJava",".")'
tar xvfz rJava_1.0-6.tar.gz
R CMD INSTALL rJava
```

Under R 4.3.2, we see error

```
/usr/bin/ld: cannot find -lintl
collect2: error: ld returned 1 exit status
make[2]: *** [libjri.so] Error 1
make[2]: Leaving directory `/rds/user/jhz22/hpc-work/work/RtmpwlPJIa/R.INSTALL1d07e7874480b/rJava/jri/src'
make[1]: *** [src/JRI.jar] Error 2
make[1]: Leaving directory `/rds/user/jhz22/hpc-work/work/RtmpwlPJIa/R.INSTALL1d07e7874480b/rJava/jri'
make: *** [jri] Error 2
ERROR: compilation failed for package ‘rJava’
* removing ‘/rds/project/jmmh2/rds-jmmh2-public_databases/software/R/rJava’
* restoring previous ‘/rds/project/jmmh2/rds-jmmh2-public_databases/software/R/rJava’
```

which is fixed with

```bash
module load ceuadmin/gettext/0.20
Rscript -e 'install.packages("rJava")'
```

With Bioconductor package `Rcpi` the `rJava.so` could not be loaded but can be installed inside R, namely.

```
> BiocManager::install("Rcpi")
```
