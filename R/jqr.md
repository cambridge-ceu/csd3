---
sort: 8
---

# R/jqr

## 1.2.3

Under R 4.3.0, we see error as follows,

```
* installing *source* package ‘jqr’ ...
** package ‘jqr’ successfully unpacked and MD5 sums checked
** using staged installation
Using PKG_CFLAGS=
Using PKG_LIBS=-ljq
--------------------------- [ANTICONF] --------------------------------
Configuration failed because libjq was not found. Try installing:
 * deb: libjq-dev (Debian, Ubuntu).
 * rpm: jq-devel (Fedora, EPEL)
 * csw: libjq_dev (Solaris)
 * brew: jq (OSX)
If  is already installed set INCLUDE_DIR and LIB_DIR manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=...'
-------------------------- [ERROR MESSAGE] ---------------------------
<stdin>:1:16: fatal error: jq.h: No such file or directory
compilation terminated.
--------------------------------------------------------------------
ERROR: configuration failed for package ‘jqr’
* removing ‘/rds/user/jhz22/hpc-work/R/jqr’
* restoring previous ‘/rds/user/jhz22/hpc-work/R/jqr’

The downloaded source packages are in
        ‘/rds/user/jhz22/hpc-work/work/RtmpRfkrxq/downloaded_packages’
Warning message:
In install.packages("jqr") :
  installation of package ‘jqr’ had non-zero exit status

```

Since we have already had `libjq.so` installed at `/rds/user/jhz22/hpc-work/lib`, see <https://cambridge-ceu.github.io/csd3/applications/DNAnexus.html>; we would need change the default configuration,

```bash
Rscript -e 'download.packages("jqr",".")'
tar xvfz jqr_1.2.3.tar.gz
cd jqr
mv configure configure.save
cat <(
cat <<'EOL'
PKG_CPPFLAGS=-I/rds/user/jhz22/hpc-work/include
PKG_LIBS=-L/rds/user/jhz22/hpc-work/lib -ljq
EOL
) <(awk 'NR>2' src/Makevars.in) > src/Makevars
cd -
R CMD INSTALL jqr
```

where the body of `Makevars` is duplicated from `Makevars.in` adding location of `jq.h` and `jq.so`.