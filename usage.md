# Usage notes

This document contains information for the following software:

[ANNOVAR](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#annovar), 
[DosageConverter](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#dosageconverter), 
[HESS](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#hess), 
[PhenoScanner](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#phenoscanner), 
[polyphen-2](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#polyphen-2), 
[poppler](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#poppler), 
[PRSice](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#prsice), 
[PRSoS](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#prsos), 
[pspp](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#pspp), 
[qpdf](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#qpdf), 
[R](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#r), 
[gnn](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#gnn), 
[LDlinkR](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#ldlinkr), 
[rgdal](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#rgdal), 
[rgeos](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#rgeos), 
[Rhdf5lib](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#Rhdf5lib), 
[rjags](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#rjags), 
[rstan](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#rstan), 
[SAIGE](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#saige-0366), 
[snpnet](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#snpnet), 
[VEP](https://github.com/cambridge-ceu/csd3/blob/master/usage.md#vep),

Whenever appropriate, it is assumed that the destination of software installation is ${HPC_WORK}, e.g., 
via `export HPC_WORK=/rds/user/$USER/hpc-work` in .bashrc.

## ANNOVAR

Web page: http://annovar.openbioinformatics.org/en/latest/

Registered from http://download.openbioinformatics.org/annovar_download_form.php with the following information,
```
User Name: 
User Email: 
User Institution: University of Cambridge
```
then copy the link received from email and issue commands from csd3,
```bash
cd ${HPC_WORK}
wget http://www.openbioinformatics.org/annovar/download/.../annovar.latest.tar.gz
tar xvfz annovar.latest.tar.gz
ls *pl | sed 's/*//g' | parallel -C' ' 'ln -sf ${HPC_WORK}/annovar/{} ${HPC_WORK}/bin/{}'
```
Additionally, one can download the ENSEMBL genes and whole-genome FASTA files to 
humandb/hg19_seq for CCDS/GENCODE annotation.
```bash
cd annovar
# ENSEMBL genes
annotate_variation.pl -buildver hg19 -downdb -webfrom annovar ensGene
annotate_variation.pl -build hg19 -out ex1 -dbtype ensGene example/ex1.avinput humandb/
# reference genome in FASTA
annotate_variation.pl -downdb -build hg19 seq humandb/hg19_seq/
# CCDS genes
annotate_variation.pl -downdb -build hg19 ccdsGene humandb
retrieve_seq_from_fasta.pl humandb/hg19_ccdsGene.txt -seqdir humandb/hg19_seq -format refGene \
                           -outfile humandb/hg19_ccdsGeneMrna.fa
annotate_variation.pl -build hg19 -out ex1 -dbtype ccdsGene example/ex1.avinput humandb/
# GENCODE genes
annotate_variation.pl -downdb wgEncodeGencodeBasicV19 humandb/ -build hg19
retrieve_seq_from_fasta.pl -format genericGene -seqdir humandb/hg19_seq/ \
                           -outfile humandb/hg19_wgEncodeGencodeBasicV19Mrna.fa humandb/hg19_wgEncodeGencodeBasicV19.txt
annotate_variation.pl -build hg19 -out ex1 -dbtype wgEncodeGencodeBasicV19 example/ex1.avinput humandb/
```
We can have region-based annotation as in http://annovar.openbioinformatics.org/en/latest/user-guide/region/,
```bash
# Conserved genomic elements
annotate_variation.pl -build hg19 -downdb phastConsElements46way humandb/
annotate_variation.pl -regionanno -build hg19 -out ex1 -dbtype phastConsElements46way example/ex1.avinput humandb/
annotate_variation.pl -regionanno -build hg19 -out ex1 -dbtype phastConsElements46way example/ex1.avinput humandb/ -normscore_threshold 400
# Transcription factor binding sites
annotate_variation.pl -build hg19 -downdb tfbsConsSites humandb/
annotate_variation.pl -regionanno -build hg19 -out ex1 -dbtype tfbsConsSites example/ex1.avinput humandb/
# Cytogenetic band
annotate_variation.pl -build hg19 -downdb cytoBand humandb/
annotate_variation.pl -regionanno -build hg19 -out ex1 -dbtype cytoBand example/ex1.avinput humandb/
# microRNA, snoRNA
annotate_variation.pl -build hg19 -downdb wgRna humandb/
annotate_variation.pl -regionanno -build hg19 -out ex1 -dbtype wgRna example/ex1.avinput humandb/
# previously reported structural variants
annotate_variation.pl -build hg19 -downdb dgvMerged humandb/
annotate_variation.pl -regionanno -build hg19 -out ex1 -dbtype dgvMerged example/ex1.avinput humandb/
# published GWAS
annotate_variation.pl -build hg19 -downdb gwasCatalog humandb/
annotate_variation.pl -regionanno -build hg19 -out ex1 -dbtype gwasCatalog example/ex1.avinput humandb/
```
Here is a more sophisticated example contrasting `table_annovar.pl` with `annotate_variation.pl`,
```bash
if [ ! -d test ]; then mkdir test; fi
annotate_variation.pl -buildver hg19 -downdb -webfrom annovar refGene test/
annotate_variation.pl -buildver hg19 -downdb -webfrom annovar exac03 test/
annotate_variation.pl -buildver hg19 -downdb -webfrom annovar avsnp147 test/
annotate_variation.pl -buildver hg19 -downdb -webfrom annovar dbnsfp30a test/

annotate_variation.pl -geneanno -dbtype refGene -buildver hg19 example/ex1.avinput test/
annotate_variation.pl -filter -dbtype exac03 -buildver hg19 example/ex1.avinput test/

table_annovar.pl example/ex1.avinput test/ -buildver hg19 -out myanno \
     -remove -protocol refGene,cytoBand,exac03,avsnp147,dbnsfp30a,gwasCatalog -operation g,r,f,f,f,r \
     -nastring . -csvout -polish -xref example/gene_xref.txt
table_annovar.pl example/ex1.avinput test/ -buildver hg19 --outfile ex1 \
     -protocol ensGene,refGene,ccdsGene,wgEncodeGencodeBasicV19,cytoBand,exac03,avsnp147,dbnsfp30a,gwasCatalog \
     -operation g,g,g,g,r,f,f,f,r \
     -csvout -polish -remove -nastring .
```
The second `table_annovar.pl` above works after symbolic links to relevant databases at humandb/ were created at test/.

It is handy to create a VCF file to be used by VEP (see below),
```bash
convert2annovar.pl -format annovar2vcf example/ex1.avinput > ex1.vcf
vep -i ex1.vcf -o ex1.vcfoutput --offline --force_overwrite
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
phenoscanner --snp=rs704 -c All -x EUR -r 0.8
phenoscanner -s T -c All -x EUR -p 0.0000001 --r2 0.6 -i INF1.merge.snp -o INF1
```
Note that `module load phenoscanner` is enabled from ~/.bashrc:
```
export MODULEPATH=${MODULEPATH}:/usr/local/Cluster-Config/modulefiles/ceuadmin/
```
via `source ~/.bashrc` or a new login. The R package works as follows,
```bash
install.packages("devtools")
library(devtools)
install_github("phenoscanner/phenoscanner")
library(phenoscanner)
example(phenoscanner)
```
When the query list is long, the call is made by chunks, e.g.,
```r
options(width=500)
require(phenoscanner)
rsid <- scan("swath-ms-invn.snp",what="")
batches <- split(rsid, ceiling(seq_along(rsid)/100))
s <- t <- list()
for(i in 1:length(batches))
{
  q <- phenoscanner(snpquery=batches[[i]], catalogue="pQTL", proxies = "EUR", pvalue = 1e-07, r2= 0.6, build=37)
  s[[i]] <- with(q,snps)
  t[[i]] <- with(q,results)
}
snps <- do.call(rbind,s)
results <- do.call(rbind,t)
r <- list(snps=snps,results=results)
```
i.e., each chunk has 100 SNPs and chunks are combined manually.

## polyphen-2

Official page: [http://genetics.bwh.harvard.edu/pph2/dokuwiki/start](http://genetics.bwh.harvard.edu/pph2/dokuwiki/start).

The setup can be furnished as follows,
```bash
cd $HPC_WORK
wget -qO- http://genetics.bwh.harvard.edu/pph2/dokuwiki/_media/polyphen-2.2.2r405c.tar.gz | tar xfz
wget -qO- ftp://genetics.bwh.harvard.edu/pph2/bundled/polyphen-2.2.2-databases-2011_12.tar.bz2 | tar xjf
wget -qO- ftp://genetics.bwh.harvard.edu/pph2/bundled/polyphen-2.2.2-alignments-mlc-2011_12.tar.bz2 | tar xjf
wget -qO- ftp://genetics.bwh.harvard.edu/pph2/bundled/polyphen-2.2.2-alignments-multiz-2009_10.tar.bz2 | tar xjf
ls  | sed 's/\*//g' | parallel -C' ' 'ln -sf $HPC_WORK/polyphen-2.2.2/bin/{} $HPC_WORK/bin/{}'
cd polyphen-2.2.2
# set up BLAST/nrdb/PDB as decribed below
cd src
make
make install
cd -
configure
cd bin
rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./
cd -
```
The MLC/MULTIZ databases need to be extracted to $HOME and symbolically linked if the number of files exceed 1 million
(limit on RDS). Then these are necessary,
```bash
cd $HPC_WORK/polyphen-2.2.2
ln -s $HOME/polyphen-2.2.2/precompiled
cd ucsc/hg19/multiz
ln -s $HOME/polyphen-2.2.2/ucsc/hg19/multiz/precomputed
```
The availability of MLC/MULTIZ databases make the annotation considerably faster.

The command `configure` creates files at config/ which can be changed maunaually. There is also
[user's guide](http://genetics.bwh.harvard.edu/pph2/dokuwiki/_media/hg0720.pdf). The line `rsync` obtains
programs such as `twoBitToFa` as required by the example below.

BLAST and nrdb can be set up as follows,
```bash
rmdir blast
ln -sf /usr/local/Cluster-Apps/blast/2.4.0 blast
cd nrdb
wget -qO- ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/uniref/uniref100/uniref100.fasta.gz | \
gunzip -c > uniref100.fasta
../update/format_defline.pl uniref100.fasta >uniref100-formatted.fasta
../blast/bin/makeblastdb -in uniref100-formatted.fasta -dbtype prot -out uniref100 -parse_seqids
rm -f uniref100.fasta uniref100-formatted.fasta
```
and for PDB
```bash
rsync -rltv --delete-after --port=33444 \
      rsync.wwpdb.org::ftp/data/structures/divided/pdb/ wwpdb/divided/pdb/
rsync -rltv --delete-after --port=33444 \
      rsync.wwpdb.org::ftp/data/structures/all/pdb/ wwpdb/all/pdb/
```
Our test is then,
```bash
cd $HPC_WORK/polyphen-2.2.2
run_pph.pl sets/test.input 1>test.pph.output 2>test.pph.log
run_weka.pl test.pph.output >test.humdiv.output
run_weka.pl -l models/HumVar.UniRef100.NBd.f11.model test.pph.output >test.humvar.output

sdiff test.humdiv.output sets/test.humdiv.output
sdiff test.humvar.output sets/test.humvar.output
```
Now we turn to an genomic SNPs query examples with snps.pph.list containing the following line,

> chr1:154426970 A/C

to be called by `mapsnps.pl` and others.
```bash
mapsnps.pl -g hg19 -m -U -y snps.pph.input snps.pph.list 1>snps.pph.features 2>snps.log
run_pph.pl snps.pph.input 1>snps.pph.output 2>snps.pph.log
run_weka.pl snps.pph.output >snps.humdiv.output
run_weka.pl -l models/HumVar.UniRef100.NBd.f11.model snps.pph.output >snps.humvar.output
```
for [.pph.input](files/snps.pph.input), [.pph.features](files/snps.pph.features), [.pph.output](files/snps.pph.output), [.humvar.output](files/snps.humvar.output) and [.humdiv.output](files/snps.humdiv.output).

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

Web page: https://github.com/choishingwan/PRSice and http://www.prsice.info/.

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
wget https://github.com/choishingwan/PRS-Tutorial/raw/master/resources/GIANT.height.gz
wget -qO- https://github.com/choishingwan/PRS-Tutorial/raw/master/resources/EUR.zip | jar xv
```
The last two commands download/unpack the documentation example, which is described here, https://choishingwan.github.io/PRS-Tutorial/, whose scripts are partly extracted [here](files/pgs.sh).

## PRSoS

Web page: https://github.com/MeaneyLab/PRSoS.

```bash
git clone https://github.com/MeaneyLab/PRSoS.git
cd PRSoS
pip install –r requirements.txt
~/.local/bin/spark-submit --master local[*] PRSoS.py examples/example.vcf examples/gwasfile.txt test_output
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
and to remove the `PREFIX=` specification in the Perl part of compiling, i.e,
```
cd perl-module
/usr/bin/perl Makefile.PL PREFIX=/rds/user/$USER/hpc-work OPTIMIZE="-g -O2 -I/rds-d4/user/$USER/hpc-work/include/fribidi -I/usr/include/cairo -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng15 -I/usr/include/uuid -I/usr/include/libdrm -I/usr/include/pango-1.0 -I/usr/include/harfbuzz  "
```

Now we can execute [plot.sps](files/plot.sps)
```bash
psppire plot.ps &
```

More documentation examples are in the [examples](files/examples) directory.

## qpdf

Web page: https://sourceforge.net/projects/qpdf/.

```bash
cd $HPC_WORK
wget -qO- https://sourceforge.net/projects/qpdf/files/qpdf/9.1.0/qpdf-9.1.0.tar.gz | \
tar xvfz -
cd qpdf-9.1.0
./configure --prefix=$HPC_WORK
make
make install
```

## R

To compile all the PDF documentations, load texlive.
```bash
module load pcre/8.38
module load texlive
wget https://cran.r-project.org/src/base/R-4/R-4.0.0.tar.gz
tar xvfz R-4.0.0.tar.gz
cd R-4.0.0
export prefix=/rds-d4/user/$USER/hpc-work
./configure --prefix=${prefix} \
            --with-pcre1 \
            --enable-R-shlib CPPFLAGS=-I${prefix}/include LDFLAGS=-L${prefix}/lib
make
make install
```
Package reinstallation could be done with `update.packages(checkBuilt = TRUE, ask = FALSE)`.

## gnn

It requires libgsl, so
```bash
module load gsl/2,4
```

## LDlinkR

Issue `install.packages("LDlinkR")` from R but requires registration at [https://ldlink.nci.nih.gov/?tab=apiaccess](https://ldlink.nci.nih.gov/?tab=apiaccess).

## rgdal

We have .R/Makevars as follows,
```bash
CC=gcc
CXX=g++ -std=gnu++11
PKG_CXXFLAGS= -std=c++11
CFLAGS = -std=c99 -I/usr/include -g -O2 -Wall -pedantic -mtune=native -Wno-ignored-attributes -Wno-deprecated-declarations -Wno-parentheses -Wimplicit-function-declaration
CXXFLAGS = -std=c++11
```
the proceed with
```bash
module load gcc/5
module load geos-3.6.2-gcc-5.4.0-vejexvy
module load gdal-2.3.1-gcc-5.4.0-m7j7nw6
module load proj-5.0.1-gcc-5.4.0-cpqxtzr
Rscript -e "install.packages('sf')"
# R 3.6.3 also requires
module load json-c-0.13.1-gcc-5.4.0-ffamohj
module load libgeotiff-1.4.2-gcc-5.4.0-2emzhxh
module load libpng-1.6.29-gcc-5.4.0-3qwhidp
module load cfitsio-3.450-gcc-5.4.0-colpo6h
module load zlib/1.2.11
module load mpich-3.2-gcc-5.4.0-idlluti
Rscript -e "install.packages('rgdal')"
```
Under R 3.6.3, there are complaints about `-std=c++11` when installing `sf` but one can gets around with 
```bash
module load geos-3.6.2-gcc-5.4.0-vejexvy
module load gcc/6
Rscript -e "install.packages('sf')"
```
Finally, gdal could also be installed with proj 6 available,
```bash
module load geos-3.6.2-gcc-5.4.0-vejexvy
./configure --with-proj=$HPC_WORK --without-sqlite3 --prefix=$HPC_WORK
```
Then `proj_api.h` should have a statement
```c
#define ACCEPT_USE_OF_DEPRECATED_PROJ_API_H 1
```

## rgeos

This requires geos to be loaded,
```bash
module load geos-3.6.2-gcc-5.4.0-vejexvy
```

## Rhdf5lib

This is useful for hdf5 file handling, but BiocManager::install() gives error `cp: cannot stat ‘hdf5/c++/src/.libs/libhdf5_cpp.a’: No such file or directory
` so we proceed manually,
```bash
module load gcc/6
cd $HOME
wget https://bioconductor.org/packages/3.11/bioc/src/contrib/Rhdf5lib_1.10.0.tar.gz
tar xfz Rhdf5lib_1.10.0.tar.gz
cd Rhdf5lib
./configure
mv configure configure.sav
cd src
tar xfz hdf5small_cxx_hl_1.10.6.tar.gz
cd hdf5
./configure --prefix=$HPC_WORK --enable-build-all --enable-cxx CFLAGS=-fPIC
make
make install
mv configure configure.sav
cd $HOME
R CMD INSTALL Rhdf5lib
```

## rjags

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

## rstan

Official page: [https://mc-stan.org/users/interfaces/rstan](https://mc-stan.org/users/interfaces/rstan) and also [https://cran.r-project.org/package=rstan](https://cran.r-project.org/package=rstan).

It is necessary to have `¬/.R/Makevars` the following lines,
```
CXX14 = g++ -std=c++1y -fPIC
```
to do away with the error message ``C++14 standard requested but CXX14 is not defined`.

In case `ggplot2` installed with `gcc 5.2.0` it is also necessary to preceed with `module load gcc/5`.

## SAIGE 0.36.6

GitHub page: [https://github.com/weizhouUMICH/SAIGE](https://github.com/weizhouUMICH/SAIGE).

The following is based on source from GitHub (so with the possibility to git pull),
```bash
module load cmake/3.9 gcc/5
module load python/2.7
virtualenv py27
source py27/bin/activate
pip install cget
git clone https://github.com/weizhouUMICH/SAIGE
R CMD INSTALL SAIGE
```
Now we see `.../SAIGE.so: undefined symbol: sgecon_`. One can get away with it by renaming `configure` to `configure.sav` (so avoid repeated downloads) and amend the last `g++ ... -o SAIGE.so` with `-L$HPC_WORK/lib64 -llapack` and then rerun `R CMD INSTALL SAIGE`. After successful installation, we can try `cd SAIGE/extdata; bash cmd.sh`.

One of the third party software is `bgenix` (BE careful with a buggy `cat-bgen`!), whose `wscript` uses Python 2 syntax so it is necessary to stick to python/2.7 explicitly since gcc/5 automatically loads python 3.
```
cd SAIGE
cd thirdParty
cd bgen
./waf configure --prefix=$HPC_WORK
./waf
./waf install
build/test/unit/test_bgen
build/apps/bgenix -g example/example.16bits.bgen -list
cd ../../..
```
See [https://github.com/weizhouUMICH/SAIGE/issues/98](https://github.com/weizhouUMICH/SAIGE/issues/98).

## snpnet

GitHub page: [https://github.com/rivas-lab/snpnet](https://github.com/rivas-lab/snpnet).

A number of software needs to be set up with the current version.
```bash
module load lz4-1.8.1.2-intel-17.0.4-celw56p
wget https://github.com/facebook/zstd/releases/download/v1.4.4/zstd-1.4.4.tar.gz
tar xfz zstd-1.4.4.tar.gz
cd zstd-1.4.4
make
make install prefix=$HPC_WORK
# gcc/6 is required for pgenlibr
module load gcc/6
```
File `dotCall64/Makevars` needs to be modified, but can be difficult (e.g., reinstallation of gettext, https://ftp.gnu.org/gnu/gettext/gettext-0.20.tar.gz), then
```
PKG_CFLAGS = $(SHLIB_OPENMP_CFLAGS) -I../inst/include/ -DDOTCAL64_PRIVATE -I$HPC_WORK/include
PKG_LIBS = $(SHLIB_OPENMP_CFLAGS) -L$HPC_WORK/lib -lintl
```
Finally, we can proceed
```r
devtools::install_github("junyangq/glmnetPlus")
devtools::install_github("chrchang/plink-ng", subdir="/2.0/cindex")
devtools::install_github("chrchang/plink-ng", subdir="/2.0/pgenlibr")
devtools::install_github("rivas-lab/snpnet")
```

## sojo

GitHub page: [https://github.com/zhenin/sojo](https://github.com/zhenin/sojo).
```r
install.packages("sojo", repos = "http://R-Forge.R-project.org")
# Swedish twin registry
download.file("https://www.dropbox.com/s/ty1udfhx5ohauh8/LD_chr22.rda?raw=1", 
destfile = paste0(find.package('sojo'), "/LD_chr22.rda"))
load(file = paste0(find.package('sojo'), "/LD_chr22.rda"))
# 1000Genomes
download.file("https://data.broadinstitute.org/alkesgroup/LDSCORE/1000G_Phase3_plinkfiles.tgz", 
destfile = paste0(find.package('sojo'), "/1000G_Phase3_plinkfiles.tgz"))
untar(paste0(find.package('sojo'), "/1000G_Phase3_plinkfiles.tgz"),exdir=find.package('sojo'))
require(sojo)
data(sum.stat.discovery)
hpc_work <- Sys.getenv("HPC_WORK")
path.plink <- paste0(hpc_work,"/bin/plink")
path.1kG <- paste0(find.package('sojo'),"/1000G_EUR_Phase3_plink")
snps <- sum.stat.discovery$SNP
write.table(snps, file = paste0(snps[1],"_snp_list.txt"), quote = F, row.names = F, col.names = F)
chr <- 22
system(paste0(path.plink," -bfile ", path.1kG,"/1000G.EUR.QC.",chr," --r square --extract ", snps[1], "_snp_list.txt --out ", snps[1], " --noweb"))
system(paste0(path.plink," -bfile ", path.1kG,"/1000G.EUR.QC.",chr," --freq --extract ", snps[1], "_snp_list.txt --out ", snps[1], " --noweb"))
LD_1kG <- as.matrix(read.table(paste0(snps[1], ".ld")))
maf_1kG <- read.table(paste0(snps[1], ".frq"), header = T)
snp_ref_1kG <- maf_1kG[,"A2"]
names(snp_ref_1kG) <- maf_1kG[,"SNP"]
colnames(LD_1kG) <- rownames(LD_1kG) <- maf_1kG$SNP
res <- sojo(sum.stat.discovery, LD_ref = LD_mat, snp_ref = snp_ref, nvar = 20)
matplot(log(res$lambda.v), t(as.matrix(res$beta.mat)), lty = 1, type = "l", 
    xlab = expression(paste(log, " ", lambda)), ylab = "Coefficients", main = "Summary-level LASSO")
data(sum.stat.validation)
res.valid <- sojo(sum.stat.discovery, sum.stat.validation, LD_ref = LD_mat, snp_ref = snp_ref, nvar = 20)
```

## VEP

Official page: [https://www.ensembl.org/info/docs/tools/vep/index.html](https://www.ensembl.org/info/docs/tools/vep/index.html)
 ([web interface](https://www.ensembl.org/Tools/VEP)).

Detailed instructions for installation are available from here, 

http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#installer.

There are several possible ways to install under csd3: GitHub, R and docker.

### --- GitHub ---

GitHub Page: [https://github.com/Ensembl/ensembl-vep](https://github.com/Ensembl/ensembl-vep).

The ease with this option lies with GitHub in that updates can simply be made with `git pull` to an exisiting release.

```bash
cd $HPC_WORK
git clone https://github.com/Ensembl/ensembl-vep.git
cd ensembl-vep
mkdir .vep
ln -sf $HPC_WORK/ensembl-vep/.vep $HOME/.vep
module load htslib/1.4
perl INSTALL.pl
# set up symbolic links to the executables
for f in convert_cache.pl filter_vep haplo variant_recoder vep; 
    do ln -sf $HPC_WORK/ensembl-vep/$f $HPC_WORK/bin/$f; done
vep -i examples/homo_sapiens_GRCh37.vcf -o examples/homo_sapiens_GRCh37.txt \
    --force_overwrite --offline --pick --symbol
```
Note in particular that by default, the cache files will be installed at $HOME which would exceed the quota (<40GB) of an ordinary user, 
and as before the destination was redirected. The setup above facilitates storage of cache files, FASTA files and plugins.

> The FASTA file should be automatically detected by the VEP when using --cache or --offline.
> If it is not, use "--fasta $HOME/.vep/homo_sapiens/98_GRCh37/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa"

Without the htslib/1.4 module, the `--NO_HTSLIB` option is needed but "Cannot use format gff without Bio::DB::HTS::Tabix module installed". 
Bio::DB:HTS is in https://github.com/Ensembl/Bio-DB-HTS and change can be made to the `Makefile` of htslibs for a desired location, to be
used by `Build.PL` via its command line parameters.

One may wish to skipped the comments (lines started with ##) in processing of the output, e.g., in R,
```bash
export skips=$(grep '##' examples/homo_sapiens_GRCh37.txt | wc -l)
R --no-save -q <<END
  vo <- read.delim("examples/homo_sapiens_GRCh37.txt",skip=as.numeric(Sys.getenv("skips")))
  head(vo)
END
```
aloowing for variable number of lines given various command-line options to be skipped to have
```
  X.Uploaded_variation    Location Allele            Gene         Feature
1          rs116645811 21:26960070      A ENSG00000154719 ENST00000307301
2            rs1135638 21:26965148      A ENSG00000154719 ENST00000307301
3              rs10576 21:26965172      C ENSG00000154719 ENST00000307301
4            rs1057885 21:26965205      C ENSG00000154719 ENST00000307301
5          rs116331755 21:26976144      G ENSG00000154719 ENST00000307301
6            rs7278168 21:26976222      T ENSG00000154719 ENST00000307301
  Feature_type        Consequence cDNA_position CDS_position Protein_position
1   Transcript   missense_variant          1043         1001              334
2   Transcript synonymous_variant           939          897              299
3   Transcript synonymous_variant           915          873              291
4   Transcript synonymous_variant           882          840              280
5   Transcript synonymous_variant           426          384              128
6   Transcript synonymous_variant           348          306              102
  Amino_acids  Codons Existing_variation
1         T/M aCg/aTg                  -
2           G ggC/ggT                  -
3           P ccA/ccG                  -
4           V gtA/gtG                  -
5           L ctT/ctC                  -
6           K aaG/aaA                  -
                                                                     Extra
1 IMPACT=MODERATE;STRAND=-1;SYMBOL=MRPL39;SYMBOL_SOURCE=HGNC;HGNC_ID=14027
2      IMPACT=LOW;STRAND=-1;SYMBOL=MRPL39;SYMBOL_SOURCE=HGNC;HGNC_ID=14027
3      IMPACT=LOW;STRAND=-1;SYMBOL=MRPL39;SYMBOL_SOURCE=HGNC;HGNC_ID=14027
4      IMPACT=LOW;STRAND=-1;SYMBOL=MRPL39;SYMBOL_SOURCE=HGNC;HGNC_ID=14027
5      IMPACT=LOW;STRAND=-1;SYMBOL=MRPL39;SYMBOL_SOURCE=HGNC;HGNC_ID=14027
6      IMPACT=LOW;STRAND=-1;SYMBOL=MRPL39;SYMBOL_SOURCE=HGNC;HGNC_ID=14027
>
```

### **ENSEMBL-synonym translation**

The ENSEMBL-synonym translation is useful to check for the feature types -- in the case of ENSG00000160712 (IL6R)
we found ENST00000368485 and ENST00000515190, we do
```bash
wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/ensemblToGeneName.txt.gz
zgrep -e ENST00000368485 -e ENST00000515190 ensemblToGeneName.txt.gz
```
giving
```
ENST00000368485 IL6R
ENST00000515190 IL6R
```
though this could also be furnished with R/biomaRt as follows,
```r
library(biomaRt)
ensembl <- useMart("ensembl", dataset="hsapiens_gene_ensembl", host="grch37.ensembl.org", path="/biomart/martservice")
attr <- listAttributes(ensembl)
g <- c('ensembl_gene_id', 'chromosome_name', 'start_position', 'end_position', 'description', 'hgnc_symbol')
t <- c('ensembl_transcript_id', 'transcription_start_site', 'transcript_start', 'transcript_end')
u <- "uniprotswissprot"
gtu <- getBM(attributes = c(g,t,u), mart = ensembl)
```
For ENSEMBL genes, R/grex is likely to work though it was developed for other purpose, e.g.,
```bash
R -q -e "grex::grex(\"ENSG00000160712\")"
```
giving
```
       ensembl_id entrez_id hgnc_symbol              hgnc_name cyto_loc
1 ENSG00000160712      3570        IL6R interleukin 6 receptor   1q21.3
  uniprot_id   gene_biotype
1     A0N0L5 protein_coding
```

### **dbNSFP**

Web page: [https://sites.google.com/site/jpopgen/dbNSFP](https://sites.google.com/site/jpopgen/dbNSFP).

This is set up as follows,
```bash
wget ftp://dbnsfp:dbnsfp@dbnsfp.softgenetics.com/dbNSFP4.0a.zip
unzip dbNSFP4.0a.zip -d dbNSFP4.0a
cd dbNSFP4.0a
zcat dbNSFP4.0a_variant.chr1.gz | head -n1 > h
zgrep -h -v ^#chr dbNSFP4.0a_variant.chr* | sort -k1,1 -k2,2n - | cat h - | bgzip -c > dbNSFP4.0a.gz
tabix -s 1 -b 2 -e 2 dbNSFP4.0a.gz
cd -
vep -i examples/homo_sapiens_GRCh37.vcf -o test --cache --force_overwrite --offline \
    --plugin dbNSFP,dbNSFP4.0a/dbNSFP4.0a.gz,LRT_score,FATHMM_score,MutationTaster_score
```
Since this release is frozen on Ensembl 94's transcript set, one may prefer to use it independently via its Java programs, e.g.,
```bash
java -jar search_dbNSFP40a.jar -i tryhg19.in -o tryhg19.out -v hg19
java -jar search_dbNSFP40a.jar -i tryhg38.in -o tryhg38.out
```

### **clinvar**

The local installation enables considerable flexibilty, and the following example, using GRCh37 assembly, is based on 
[https://www.ensembl.org/info/docs/tools/vep/script/vep_custom.html#custom_options](https://www.ensembl.org/info/docs/tools/vep/script/vep_custom.html#custom_options).

```bash
# Compressed VCF file
curl ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/clinvar.vcf.gz -o clinvar_GRCh37.vcf.gz
# Index file
curl ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/clinvar.vcf.gz.tbi -o clinvar_GRCh37.vcf.gz.tbi
```

Information is gathered from the header of the VCF file,

ClinVar Variation ID | Description
---------------------|-----------------------------------------------------------------------------------------------------------
AF_ESP | allele frequencies from GO-ESP
AF_EXAC | allele frequencies from ExAC
AF_TGP | allele frequencies from TGP
ALLELEID | the ClinVar Allele ID
CLNDN | ClinVar's preferred disease name for the concept specified by disease identifiers in CLNDISDB
CLNDNINCL | For included Variant : ClinVar's preferred disease name for the concept specified by disease identifiers in CLNDISDB
CLNDISDB | Tag-value pairs of disease database name and identifier, e.g. OMIM:NNNNNN
CLNDISDBINCL | For included Variant: Tag-value pairs of disease database name and identifier, e.g. OMIM:NNNNNN
CLNHGVS | Top-level (primary assembly, alt, or patch) HGVS expression.
CLNREVSTAT | ClinVar review status for the Variation ID
CLNSIG | Clinical significance for this single variant
CLNSIGCONF | Conflicting clinical significance for this single variant
CLNSIGINCL | Clinical significance for a haplotype or genotype that includes this variant. Reported as pairs of VariationID:clinical significance.
CLNVC | Variant type
CLNVCSO | Sequence Ontology id for variant type
CLNVI | the variant's clinical sources reported as tag-value pairs of database and variant identifier
DBVARID | nsv accessions from dbVar for the variant
GENEINFO | Gene(s) for the variant reported as gene symbol:gene id. The gene symbol and id are delimited by a colon (:) and each pair is delimited by a vertical bar (|)
MC | comma separated list of molecular consequence in the form of Sequence Ontology ID|molecular_consequence
ORIGIN | Allele origin. One or more of the following values may be added: 0 - unknown; 1 - germline; 2 - somatic ; 4 - inherited; 8 - paternal; 16 - maternal; 32 - de-novo; 64 - biparental; 128 - uniparental; 256 - not-tested; 512 - tested-inconclusive; 1073741824 - other
RS | dbSNP ID (i.e. rs number)
SSR | Variant Suspect Reason Codes. One or more of the following values may be added: 0 - unspecified, 1 - Paralog, 2 - byEST, 4 - oldAlign, 8 - Para_EST, 16 - 1kg_failed, 1024 - other

We now query rs2228145,
```bash
vep --id "1 154426970 154426970 A/C 1" --species homo_sapiens -o rs2228145 --cache --offline --force_overwrite \
    --assembly GRCh37 --custom clinvar_GRCh37.vcf.gz,ClinVar,vcf,exact,0,CLNSIG,CLNREVSTAT,CLNDN
```
which gives
```
#Uploaded_variation	Location	Allele	Gene	Feature	Feature_type	Consequence	cDNA_position	CDS_position	Protein_position	Amino_acids	Codons	Existing_variation	Extra
1_154426970_A/C	1:154426970	C	ENSG00000160712	ENST00000344086	Transcript	intron_variant	-	-	-	-	-	-	IMPACT=MODIFIER;STRAND=1;ClinVar=14660;ClinVar_CLNDN=Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus;ClinVar_CLNREVSTAT=no_assertion_criteria_provided;ClinVar_CLNSIG=association;ClinVar_FILTER=.
1_154426970_A/C	1:154426970	C	ENSG00000160712	ENST00000368485	Transcript	missense_variant	1510	1073	358	D/A	gAt/gCt	-	IMPACT=MODERATE;STRAND=1;ClinVar=14660;ClinVar_CLNDN=Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus;ClinVar_CLNREVSTAT=no_assertion_criteria_provided;ClinVar_CLNSIG=association;ClinVar_FILTER=.
1_154426970_A/C	1:154426970	C	ENSG00000160712	ENST00000476006	Transcript	downstream_gene_variant	-	-	-	-	-	-	IMPACT=MODIFIER;DISTANCE=4515;STRAND=1;FLAGS=cds_start_NF,cds_end_NF;ClinVar=14660;ClinVar_CLNDN=Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus;ClinVar_CLNREVSTAT=no_assertion_criteria_provided;ClinVar_CLNSIG=association;ClinVar_FILTER=.
1_154426970_A/C	1:154426970	C	ENSG00000160712	ENST00000502679	Transcript	non_coding_transcript_exon_variant	386	-	-	-	-	-	IMPACT=MODIFIER;STRAND=1;ClinVar=14660;ClinVar_CLNDN=Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus;ClinVar_CLNREVSTAT=no_assertion_criteria_provided;ClinVar_CLNSIG=association;ClinVar_FILTER=.
1_154426970_A/C	1:154426970	C	ENSG00000160712	ENST00000507256	Transcript	non_coding_transcript_exon_variant	271	-	-	-	-	-	IMPACT=MODIFIER;STRAND=1;ClinVar=14660;ClinVar_CLNDN=Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus;ClinVar_CLNREVSTAT=no_assertion_criteria_provided;ClinVar_CLNSIG=association;ClinVar_FILTER=.
1_154426970_A/C	1:154426970	C	ENSG00000160712	ENST00000515190	Transcript	missense_variant	481	482	161	D/A	gAt/gCt	-	IMPACT=MODERATE;STRAND=1;FLAGS=cds_start_NF,cds_end_NF;ClinVar=14660;ClinVar_CLNDN=Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus;ClinVar_CLNREVSTAT=no_assertion_criteria_provided;ClinVar_CLNSIG=association;ClinVar_FILTER=.
```
A [HTML summary](files/rs2228145_summary.html) (somehow the web browser may not display the embedded figures) is also available. The `Extra` column looks clumsy and we could add the `--tab` option to generate a tab-delimited output.
```bash
vep --id "1 154426970 154426970 A/C 1" --species homo_sapiens -o rs2228145 --cache --offline --force_overwrite \
    --custom clinvar_GRCh37.vcf.gz,ClinVar,vcf,exact,0,CLNSIG,CLNREVSTAT,CLNDN --tab \
    --fields Uploaded_variation,Gene,Consequence,ClinVar_CLNSIG,ClinVar_CLNREVSTAT,ClinVar_CLNDN
```
to give neatly
```
#Uploaded_variation	Gene	Consequence	ClinVar_CLNSIG	ClinVar_CLNREVSTAT	ClinVar_CLNDN
1_154426970_A/C	ENSG00000160712	intron_variant	association	no_assertion_criteria_provided	Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus
1_154426970_A/C	ENSG00000160712	missense_variant	association	no_assertion_criteria_provided	Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus
1_154426970_A/C	ENSG00000160712	downstream_gene_variant	association	no_assertion_criteria_provided	Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus
1_154426970_A/C	ENSG00000160712	non_coding_transcript_exon_variant	association	no_assertion_criteria_provided	Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus
1_154426970_A/C	ENSG00000160712	non_coding_transcript_exon_variant	association	no_assertion_criteria_provided	Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus
1_154426970_A/C	ENSG00000160712	missense_variant	association	no_assertion_criteria_provided	Interleukin_6,_serum_level_of,_quantitative_trait_locus|Soluble_interleukin-6_receptor,_serum_level_of,_quantitative_trait_locus
```

### --- loftee ---

GitHub page: [https://github.com/konradjk/loftee](https://github.com/konradjk/loftee).

Reference: MacArthur DG et al (2012). A systematic survey of loss-of-function variants in human protein-coding genes. *Science* 335:823–828

It is actually part of the standard VEP plugins.
```bash
cd loftee
# human_ancestor_fa
## samtools --version gives 0.1.19
wget http://www.broadinstitute.org/~konradk/loftee/human_ancestor.fa.rz
wget http://www.broadinstitute.org/~konradk/loftee/human_ancestor.fa.rz.fai
## samtools --version gives 1.x
wget https://s3.amazonaws.com/bcbio_nextgen/human_ancestor.fa.gz
wget https://s3.amazonaws.com/bcbio_nextgen/human_ancestor.fa.gz.fai
wget https://s3.amazonaws.com/bcbio_nextgen/human_ancestor.fa.gz.gzi
# conservation_file
wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh37/phylocsf_gerp.sql.gz
wget https://www.broadinstitute.org/~konradk/loftee/phylocsf_data.tsv.gz
wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh37/GERP_scores.final.sorted.txt.gz
wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh37/GERP_scores.exons.txt.gz
# annotation
vep --id "1 154426970 154426970 A/C 1" --species homo_sapiens -o rs2228145 --cache --offline --force_overwrite \
    --assembly GRCh37 --plugin LoF,loftee_path:.,human_ancestor_fa:human_ancestor.fa.gz,conservation_file:phylocsf_gerp.sql.gz
```
If offers implementation for parsing CSQ field but is preferably done with R as described below. Note that if loftee_path uses an absolute path, that path should also be within PERL5LIB, e.g.,
```
export PERL5LIB=$PERL5LIB:$HPC_WORK/loftee
```
is put in .bashrc.

### --- R ---

This is a wrapper and `the Ensembl VEP perl script must be installed in your path`. Expected to be slower than the `--offline` mode above, it is 
relatively easy to set up,
```r
BiocManager::install("ensemblVEP")
vignette("ensemblVEP")
file <- system.file("extdata", "ex2.vcf", package="VariantAnnotation")
vep <- ensemblVEP(file, param=VEPFlags(flags=list(vcf=TRUE, host="useastdb.ensembl.org")))
info(vep)$CSQ
```
Annotation is made to a VCF file, and returns data with unparsed 'CSQ'.

The facility to parse the CSQ column of a VCF object could be useful as shown below by the documentation example.
```r
# VCF output from the VEP web interface or the call above
vep <- "INF1.merge.trans.vcf"
# Parse into a GRanges and include the 'VCFRowID' column.
vcf <- readVcf(vep, "hg19")
csq <- parseCSQToGRanges(vep, VCFRowID=rownames(vcf))
write.table(mcols(csq),file="INF1.merge.trans.txt", quote=FALSE, sep="\t")
```
The dbNSFP counterpart is also possible
```r
BiocManager::install("myvariant")
library(VariantAnnotation)
file <- system.file("extdata", "dbsnp_mini.vcf", package="myvariant")
vcf <- readVcf(file, genome="hg19")
rowRanges(vcf)
library(myvariant)
hgvs <- formatHgvs(vcf, variant_type="snp")
head(hgvs)
getVariants(hgvs)
rsids <- paste("rs", info(vcf)$RS, sep="")
head(rsids)
res <- queryVariants(q=rsids, scopes="dbsnp.rsid", fields="all")
fields <- names(res)
cadd <- grep('cadd',fields)
res[fields[cadd]]
```

### --- docker ---

See `docker/Dockerfile ` from the GitHub directory above, or https://github.com/Ensembl/ensembl-vep.

### --- Virtual machine ---

See http://www.ensembl.org/info/data/virtual_machine.html which is possibly best for MicroSoft Windows and is not pursued here.

ENSEMBL-synonym translation (hg19) file
