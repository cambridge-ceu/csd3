---
sort: 25
---

# RMariaDB

## 1.3.0

```
MariaTypes.cpp:43:8: error: 'MYSQL_TYPE_JSON' was not declared in this scope; did you mean 'MYSQL_TYPE_BLOB'?
   43 |   case MYSQL_TYPE_JSON:
      |        ^~~~~~~~~~~~~~~
      |        MYSQL_TYPE_BLOB
make: *** [MariaTypes.o] Error 1
ERROR: compilation failed for package ‘RMariaDB’
* removing ‘/rds/project/jmmh2/rds-jmmh2-public_databases/software/R/RMariaDB’
* restoring previous ‘/rds/project/jmmh2/rds-jmmh2-public_databases/software/R/RMariaDB’
```

We simply delete lines 43-44, since line 44 is also the default (`return MY_STR;`).

```bash
Rscript -e 'download.packages("RMariaDB",".")'
tar xfz RMariaDB_1.3.0.tar.gz
sed -i '43,44d' RMariaDB/src/MariaTypes.cpp
R CMD INSTALL RMariaDB
rm -rf RMariaDB*
```
