# Software notes

This document contains information on software noted from work (analogous to https://github.com/jinghuazhao/software-notes):

ANNOVAR, DosageConverter, HESS, PhenoScanner, poppler, PRSice, pspp, R, rjags, rstan, SAIGE, VEP,

Whenever appropriate, it is assumed that there is `export HPC_WORK=/rds/user/$USER/hpc-work` in .bashrc.

## ANNOVAR

Web page: http://annovar.openbioinformatics.org/en/latest/

Registered [here](http://download.openbioinformatics.org/annovar_download_form.php) with the following information,
```
User Name: Jing Hua Zhao
User Email: jhz22@medschl.cam.ac.uk
User Institution: University of Cambridge
User IP: 131.111.185.49
User Host: global-185-49.nat-2.net.cam.ac.uk
```
then
```bash
wget http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz
tar xvfz annovar.latest.tar.gz
ls *pl | sed 's/*//g' | parallel -C' ' 'ln -sf ${HPC_WORK}/annovar/{} ${HPC_WORK}/bin/{}'
```

## DosageConverter

```bash
## assuming you use hpc-work/ with a subdirectory called bin/
cd /rds/user/$USER/hpc-work/
git clone https://github.com/Santy-8128/DosageConvertor
cd DosageConverter
pip install cget --user
module load cmake-3.8.1-gcc-4.8.5-zz55m7x
./install.sh
cd /rds/user/$USER/hpc-work/bin/
ln -s /rds/user/$USER/hpc-work/DosageConvertor/release-build/DosageConvertor
## testing
DosageConvertor  --vcfDose  test/TestDataImputedVCF.dose.vcf.gz \
                 --info     test/TestDataImputedVCF.info \
                 --prefix   test \
                 --type     mach

gunzip -c test.mach.dose.gz | wc -l

DosageConvertor  --vcfDose  test/TestDataImputedVCF.dose.vcf.gz \
                 --info     test/TestDataImputedVCF.info \
                 --prefix   test \
                 --type     plink

gunzip -c test.plink.dosage.gz | wc -l
```
so the MaCH dosage file is individual x genotype whereas PLINK dosage file is genotype x individual.

## HESS

This section is extracted from https://github.com/jinghuazhao/software-notes.

HESS (Heritability Estimation from Summary Statistics) is now available from https://github.com/huwenboshi/hess and has a web page at

https://huwenboshi.github.io/hess-0.5/#hess

To prepare for the software, one can proceeds with
```bash
python -m pip install pysnptools --user
```
Now we set up for analysis of height
```bash
#!/bin/bash

export HEIGHT=https://portals.broadinstitute.org/collaboration/giant/images/0/01/GIANT_HEIGHT_Wood_et_al_2014_publicrelease_HapMapCeuFreq.txt.gz

wget -qO- $HEIGHT | \
awk 'NR>1' | \
sort -k1,1 | \
join -13 -21 snp150.txt - | \
awk '($9!="X" && $9!="Y" && $9!="Un"){if(NR==1) print "SNP CHR BP A1 A2 Z N"; else print $1,$2,$3,$4,$5,$7/$8,$10}' > height.tsv.gz

#  SNP - rs ID of the SNP (e.g. rs62442).
#  CHR - Chromosome number of the SNP. This should be a number between 1 and 22.
#  BP - Base pair position of the SNP.
#  A1 - Effect allele of the SNP. The sign of the Z-score is with respect to this allele.
#  A2 - The other allele of the SNP.
#  Z - The Z-score of the SNP.
#  N - Sample size of the SNP.
```
where snp150.txt from UCSC is described at the SUMSTATS repository, [https://github.com/jinghuazhao/SUMSTATS](https://github.com/jinghuazhao/SUMSTATS).
```bash
for chrom in $(seq 22)
do
    python hess.py \
        --local-hsqg height \
        --chrom $chrom \
        --bfile 1kg_eur_1pct/1kg_eur_1pct_chr${chrom} \
        --partition nygcresearch-ldetect-data-ac125e47bf7f/EUR/fourier_ls-chr${chrom}.bed \
        --out step1
done
python hess.py --prefix step1 --reinflate-lambda-gc 1 --tot-hsqg 0.8 0.2 --out step2
```
It is preferable to use `miniconda` since it associates with faster libraries.
```bash
module load miniconda2-4.3.14-gcc-5.4.0-xjtq53h
conda install pandas
```

## PhenoScanner

Here are examples loading command-line interface (CLI),
```bash
module load ceuadmin/phenoscanner
phenoscanner --help
phenoscanner --snp=rs123 -c All -x EUR -r 0.8
phenoscanner -s T -c All -x EUR -p 0.0000001 --r2 0.6 -i INF1.merge.snp -o INF1
```
and R package,
```bash
install.packages("devtools")
library(devtools)
install_github("phenoscanner/phenoscanner")
library(phenoscanner)
example(phenoscanner)
```
Note that `module load phenoscanner` is enabled from ~/.bashrc:
```
export MODULEPATH=${MODULEPATH}:/usr/local/Cluster-Config/modulefiles/ceuadmin/
```
via `source ~/.bashrc` or a new login.

## poppler

Official page: [https://poppler.freedesktop.org/](https://poppler.freedesktop.org/).

We work on the latest version, 0.84.0.
```bash
module load xz/5.2.2
wget https://poppler.freedesktop.org/poppler-0.84.0.tar.xz
tar xf poppler-0.84.0.tar.xz
cd poppler-0.84.0
mkdir build
cd build
module load gcc/5
module load openjpeg-2.1-gcc-5.4.0-myd2p3o
cmake ..
make
make install
```
Note it is necessary to change prefix, cc and c++ to gcc and g++ in line with gcc/5, e.g.,
```
CMAKE_INSTALL_PREFIX:PATH=/rds/user/$USER/hpc-work
CMAKE_C_COMPILER:FILEPATH=/usr/local/software/master/gcc/5/bin/gcc
CMAKE_CXX_COMPILER:FILEPATH=/usr/local/software/master/gcc/5/bin/g++
```
which could be done by editing CMakeCache.txt and/or calling `ccmake .`. After these we have 
the followihg utilities: 
pdfattach, pdfdetach,  pdffonts,  pdfimages,  pdfinfo,  pdfseparate,  pdftocairo,  pdftohtml,  pdftoppm,  pdftops,  pdftotext,  pdfunite, 
and following libraries: libpoppler.so, libpoppler-cpp.so, libpoppler-glibc.so, libpoppler-qt5.so.

## PRSice

Web page: https://github.com/choishingwan/PRSice, https://choishingwan.github.io/PRS-Tutorial/ and http://www.prsice.info/.

```bash
cd $HPC_WORK
git clone https://github.com/choishingwan/PRSice
cd PRSice
mkdir build
cd build
module load cmake/3.9
cmake ..
make
ln -sf $HPC_WORK/PRSice/bin/PRSice $HPC_WORK/bin/PRSice
```

## pspp

Official page: [https://www.gnu.org/software/pspp/](https://www.gnu.org/software/pspp/).

```bash
module load pspp/1.2.0
pspp example.sps
```
where [example.sps](files/example.sps) is the documentation example. Nevertheless `psppire` is not yet functioning.

However, it is possible to compile it directly by using

* gtksourceview 4.0.3 (4.4.0 is more demanding with Python 3.5, meson, Vala, etc.) and use PKG_CONFIG_PATH when appropriate
* spread-sheet-widget-0.3
* fribidi-1.0.8
* GTKSOURVIEW_CFLAGS and GTKSOURVIEW_LIBS in the configuration.

```bash
export PREFIX=/rds/user/$USER/hpc-work
export GTKSOURCEVIEW_CFLAGS=-I${PREFIX}/includegtksourceview-4
export GTKSOURCEVIEW_LIBS="-L${PREFIX}/lib -lgtksourceview-4"
./configure --prefix=${PREFIX}
make
make install
```
note that it is necessary to comment on the statement `kludge = gtk_source_view_get_type ();` from `src/ui/gui/widgets.c`
and to remove the `PREFIX=` speficiation in the Perl part of compiling, i.e,
```
cd perl-module
/usr/bin/perl Makefile.PL PREFIX=/rds/user/$USER/hpc-work OPTIMIZE="-g -O2 -I/rds-d4/user/$USER/hpc-work/include/fribidi -I/usr/include/cairo -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng15 -I/usr/include/uuid -I/usr/include/libdrm -I/usr/include/pango-1.0 -I/usr/include/harfbuzz  "
```

Now we can execute [plot.sps](files/plot.sps)
```bash
psppire plot.ps &
```

More documentation examples are in the [examples](files/examples) directory.

## R

To compile all the PDF documentations, load texlive.
```bash
module load texlive
cd R-3.6.2
export prefix=/rds-d4/user/$USER/hpc-work
./configure --prefix={prefix} \
            --enable-R-shlib CPPFLAGS=-I${prefix}/include LDFLAGS=-L${prefix}/lib
make
make install
```
Package reinstallation could be done with `update.packages(checkBuilt = TRUE, ask = FALSE)`.

## rjags

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

## rstan

It is necessary to have `¬/.R/Makevars` the following lines,
```
CXX14 = g++ -std=c++1y -fPIC
```
to do away with the error message ``C++14 standard requested but CXX14 is not defined`.

In case `ggplot2` installed with `gcc 5.2.0` it is also necessary to preceed with `module load gcc/5`.

## SAIGE 0.35.8.2

```bash
module load boost-1.58.0-gcc-5.4.0-onpiqcr
```
then one can use `library(SAIGE)` inside R.

## VEP

There are several sources to install under csd3: GitHub, R and docker.

### --- GitHub ---

Office page: [https://www.ensembl.org/info/docs/tools/vep/index.html](https://www.ensembl.org/info/docs/tools/vep/index.html).

```bash
cd $HPC_WORK
git clone https://github.com/Ensembl/ensembl-vep.git
cd ensembl-vep
mkdir .vep
ln -sf $HPC_WORK/ensembl-vep/.vep $HOME/.vep
module load htslib/1.4
perl INSTALL.pl
./vep -i examples/homo_sapiens_GRCh37.vcf -o examples/homo_sapiens_GRC37.txt --force_overwrite --offline
```
Note in particular that by default, the cache files will be installed at $HOME which would exceed the quota (<40GB) of an ordinary user, 
and as before the destination was redirected. The installation also interactively asks for cache files, FASTA files and plugins.

> The FASTA file should be automatically detected by the VEP when using --cache or --offline.
> If it is not, use "--fasta $HOME/.vep/homo_sapiens/98_GRCh37/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa"

The following script can set up symbolic links to the executables
```bash
for f in convert_cache.pl filter_vep haplo variant_recoder vep; 
do ln -sf $HPC_WORK/ensembl-vep/$f $HPC_WORK/bin/$f; done
```
Without the htslib/1.4 module, the `--NO_HTSLIB` option is needed but "Cannot use format gff without Bio::DB::HTS::Tabix module installed". 
Bio::DB:HTS is in https://github.com/Ensembl/Bio-DB-HTS and change can be made to the `Makefile` of htslibs for a desired location, to be
used by `Build.PL` via its command line parameters.

### --- R ---

```r
BiocManager::install("ensemblVEP")
```

### --- docker ---

See `docker/Dockerfile ` from the GitHub directory above, or https://github.com/Ensembl/ensembl-vep.

### --- Virtual Machine ---

See http://www.ensembl.org/info/data/virtual_machine.html which we would not pursue here.

Detailed instructions are available from here, http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#installer.
