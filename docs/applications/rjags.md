---
sort: 29
---

# R/rjags

Web page: [https://sourceforge.net/projects/mcmc-jags/files/rjags/](https://sourceforge.net/projects/mcmc-jags/files/rjags/).

It is known for sometime for its difficulty to install; here is what was done

```bash

# Cardio
export PKG_CONFIG_PATH=/scratch/$USER/lib/pkgconfig

R CMD INSTALL rjags_4-6.tar.gz --configure-args='CPPFLAGS="-fPIC" LDFLAGS="-L/scratch/$USER/lib -ljags"
--with-jags-prefix=/scratch/$USER
--with-jags-libdir=/scratch/$USER/lib
--with-jags-includedir=/scratch/$USER/include'

# csd3
export hpcwork=/rds-d4/user/$USER/hpc-work
export PKG_CONFIG_PATH=${hpcwork}/lib/pkgconfig

wget https://cran.r-project.org/src/contrib/rjags_4-10.tar.gz
R CMD INSTALL rjags_4-10.tar.gz --configure-args='CPPFLAGS="-fPIC" LDFLAGS="-L${hpcwork}/lib -ljags"
--with-jags-prefix=${hpcwork}
--with-jags-libdir=${hpcwork}/lib
--with-jags-includedir=${hpcwork}/include'
```
