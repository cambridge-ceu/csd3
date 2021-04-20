---
sort: 5
---

# bcftools

Web: [http://www.htslib.org/download/](http://www.htslib.org/download/)

On CSD3, `module list bcftools` gives a list of versions but none can query data from the web.

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
