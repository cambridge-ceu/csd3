---
sort: 6
---

# bcftools

Web: [http://www.htslib.org/download/](http://www.htslib.org/download/)

On CSD3, `module list bcftools` gives a list of versions but none can query data from the web.

## 1.20

```bash
wget -qO- https://github.com/samtools/htslib/archive/refs/tags/1.20.tar.gz | \
tar xfz -
export PERL5LIB=
cd htslib-1.20/
autoreconf -i
configure --prefix=$CEUADMIN/bcftools/1.20
make
make install
cd -
wget https://github.com/samtools/bcftools/releases/download/1.20/bcftools-1.20.tar.bz2 | \
tar xjf -
cd bcftools-1.20/
configure --prefix=$CEUADMIN/bcftools/1.20
make
make install
bcftools --version
```

## 1.12

However, the installation is straightforward.

```bash
wget -qO- https://github.com/samtools/bcftools/releases/download/1.12/bcftools-1.12.tar.bz2 | \
tar xjf -
cd bcftools-1.12/
./configure --prefix=${HPC_WORK}
make
make install
bcftools --version
```

According to documentation, the configuration could slightly be more complicated with

```bash
export BCFTOOLS_PLUGINS=${HPC_WORK}/bcftools-1.12/plugins
autoheader && autoconf && ./configure --enable-libgsl --enable-perl-filters --prefix=/usr/local/Cluster-Apps/ceuadmin/bcftools/1.12
make
make install
```

The data query example as in `tabix` is quoted here.

```bash
bcftools query -f '%ID\t%ALT\t%REF\t%AF\t[%ES]\t[%SE]\t[%LP]\t[%SS]\t%CHROM\t%POS\n' -r 1:1-1000000 \
               https://gwas.mrcieu.ac.uk/files/ebi-a-GCST010776/ebi-a-GCST010776.vcf.gz
```

A number of other options can be used together with -r or -R.

We can also obtain data with the header (-H)

```bash
export f=ebi-a-GCST010776
bcftools query -f '%ID\t%ALT\t%REF\t%AF\t[%ES]\t[%SE]\t[%LP]\t[%SS]\t%CHROM\t%POS\n' \
               -H \
               -r 1:1-1000000 \
               https://gwas.mrcieu.ac.uk/files/${f}/${f}.vcf.gz | \
               sed "s/\[[0-9]*\]//g;s/^[\#] //;s/${f}://g" > chr1:1-1000000.dat
```
