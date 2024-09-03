---
sort: 31
---

# rtracklayer

Under cclake, modules `ceuadmin/rtmpdump/2.3` and `curl-7.63.0-gcc-5.4.0-4uswlql` are both required, since `librtmp.so.0` is needed for `RCurl 1.98-1.14` and the latter for `rtracklayer 1.64.0`.

Quoting from <https://cambridge-ceu.github.io/csd3/systems/setup.html#fn:rtmpdump>, the details are as follows,

```bash
wget -qO- https://rtmpdump.mplayerhq.hu/download/rtmpdump-2.3.tgz |\
tar xvfz -
cd rtmpdump-2.3
sed -i 's|/usr/local|/usr/local/Cluster-Apps/ceuadmin/rtmpdump/2.3|' Makefile
sed -i 's|/usr/local|/usr/local/Cluster-Apps/ceuadmin/rtmpdump/2.3|' librtmp/Makefile
make
make install
Rscript -e 'install.packages("RCurl")'
Rscript -e 'BiocManager::install("rtracklayer")'
```
