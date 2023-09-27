# The CEU software repository at CSD3

Location at CSD3:  /usr/local/Cluster-Apps/ceuadmin

The current list is as follows[^ls],

```
  [1] "ABCtoolbox"            "akt"                   "allegro"
  [4] "alpine"                "annovar"               "aria2"
  [7] "autoconf"              "axel"                  "bazel"
 [10] "bcftools"              "Beagle"                "bedops"
 [13] "bedtools2"             "bgen"                  "biobank"
 [16] "blat"                  "boltlmm"               "brotli"
 [19] "busybox"               "CaVEMaN"               "CAVIAR"
 [22] "CAVIARBF"              "ccal"                  "circos"
 [25] "citeproc"              "cppunit"               "crossmap"
 [28] "Cytoscape"             "DEPICT"                "DjVuLibre"
 [31] "docbook2X"             "DosageConverter"       "Eagle"
 [34] "ensembl-vep"           "exiv2"                 "exomeplus"
 [37] "expat"                 "FastQTL"               "fcGENE"
 [40] "ffmpeg"                "fgwas"                 "finemap"
 [43] "fossil"                "fribidi"               "GARFIELD"
 [46] "gatk"                  "gcta"                  "gdal"
 [49] "GEM"                   "GEMMA"                 "Genotype-Harmonizer"
 [52] "gettext"               "gh"                    "ghc"
 [55] "ghostscript"           "git"                   "git-extras"
 [58] "GitKraken"             "globusconnectpersonal" "gmp"
 [61] "gnutls"                "googletest"            "GraphicsMagick"
 [64] "GreenAlgorithms4HPC"   "gsl"                   "gtksourceview"
 [67] "gtool"                 "hpg"                   "htslib"
 [70] "icu"                   "ImageJ"                "impute"
 [73] "JabRef"                "JAGS"                  "jq"
 [76] "KentUtils"             "KING"                  "lapack"
 [79] "ldc2"                  "LDstore"               "LEMMA"
 [82] "libcares"              "libgit2"               "libglvnd"
 [85] "libiconv"              "libidn2"               "libntlm"
 [88] "libpng"                "libsodium"             "libssh2"
 [91] "libuv"                 "libxml2"               "libxslt"
 [94] "locuszoom"             "MAGENTA"               "magma"
 [97] "MAGMA"                 "Mega2"                 "metal"
[100] "MONSTER"               "MORGAN"                "MR-MEGA"
[103] "MsCAVIAR"              "nano"                  "ncbi-vdb"
[106] "ncurses"               "netbeans"              "nettle"
[109] "NLopt"                 "node"                  "nspr"
[112] "oniguruma"             "OpenMS"                "openssl"
[115] "osca"                  "PAINTOR"               "pandoc"
[118] "pandoc-citeproc"       "parallel"              "Pascal"
[121] "pcre2"                 "pdf2djvu"              "pdfjam"
[124] "phenoscanner"          "PhySO"                 "plink"
[127] "plink-bgi"             "plinkseq"              "PoGo"
[130] "polyphen"              "poppler"               "proj"
[133] "PRSice"                "pspp"                  "PWCoCo"
[136] "qctool"                "qpdf"                  "qt"
[139] "qtcreator"             "QTLtools"              "quarto"
[142] "quicktest"             "R"                     "raremetal"
[145] "rclone"                "readline"              "regenie"
[148] "RHHsoftware"           "rstudio"               "ruby"
[151] "samtools"              "shapeit"               "SMR"
[154] "snakemake"             "SNP2HLA"               "snptest"
[157] "spread-sheet-widget"   "sqlite"                "sra-tools"
[160] "ssw"                   "STAR"                  "stata"
[163] "SurvivalAnalysis"      "SurvivalKit"           "tabix"
[166] "thunderbird"           "tidy"                  "trinculo"
[169] "trousers"              "Typora"                "unbound"
[172] "vala"                  "vcftools"              "VEGAS2"
[175] "VSCode"                "xpdf"                  "yaml-cpp"
[178] "Zotero"                "zstd"
```

Most should be available to all CSD3 users in the whole campus, e.g., for pspp, a brief description of a module is available with

```bash
module help ceuadmin/pspp
```

and the module is loaded and graphical user interface (GUI)[^gui] started with

```bash
module load ceuadmin/pspp
psppire
```

for PSPP 1.6.0. Once the job is done, one can restore the previous environment with

```bash
module unload ceuadmin/pspp
```

A full list of module commands is available with `module help`.

NB most software use gcc/6, which can be enabled with `module load gcc/6`.

Due to limitation in size, a trade-off has been made to make some software available for CEU users by linking internal folders: ensembl-vep, ANNOVAR, polyphen, OpenMS, GARFIELD, KentUtils, 
(with large collection of packages), locuszoom (adding chromosome X data). Others which is in condieration include depict, fastenloc (with GTEx v8 reference data), tensorqtl, CookHLA, HLA-TAPAS, HATK. A desirable location is /rds/project/jmmh2/software.

## All recent entries

They are ordered chronologically.

|Date       |Add ons                          |Category            |
|:----------|:--------------------------------|:-------------------|
|2022-10-21 |pspp/1.6.0                       |Generic             |
|2022-10-22 |snptest/2.5.6                    |Genetics            |
|   ""      |qctool/2.0.8                     |Genetics            |
|   ""      |gcta/1.94.1                      |Genetics            |
|   ""      |KING/2.1.6                       |Genetics            |
|   ""      |LDstore/2.0                      |Genetics            |
|   ""      |shapeit/3                        |Genetics            |
|   ""      |vcftools/0.1.16                  |Genetics            |
|   ""      |finemap/1.4                      |Genetics            |
|2022-10-23 |quicktest/1.1                    |Genetics            |
|   ""      |samtools/1.11                    |Genetics            |
|   ""      |bcftools/1.12                    |Genetics            |
|   ""      |MORGAN/3.4                       |Genetics            |
|   ""      |METAL/2020-05-05r                |Genetics[^metal]    |
|   ""      |regenie/3.2.1                    |Genetics            |
|   ""      |GEMMA/0.98.5                     |Genetics[^gemma]    |
|   ""      |htslib/1.12                      |Genetics            |
|   ""      |fcGENE/1.0.7                     |Genetics[^fcgene]   |
|   ""      |SMR/1.0.3                        |Genetics            |
|   ""      |FastQTL/2.165                    |Genetics            |
|   ""      |GitKraken/8.1.0                  |Generic             |
|2022-10-24 |Typora/0.11.8beta                |Generic             |
|   ""      |pandoc/2.19.2                    |Generic             |
|   ""      |citeproc/0.4.0.1                 |Generic             |
|   ""      |citeproc/0.8.0.2                 |Generic             |
|2022-10-26 |circos/0.69-9                    |Genetics            |
|   ""      |DjVuLibre/3.5.27.1-14            |Generic             |
|   ""      |ghostscript/9.56.1               |Generic             |
|   ""      |bgen/1.1.7                       |Genetics            |
|2022-10-27 |sqlite/3.39.4                    |Generic             |
|2022-10-28 |poppler/0.84.0                   |Generic             |
|   ""      |jq/1.6                           |Generic[^jq]        |
|   ""      |DosageConverter/1.0.0            |Genetics            |
|   ""      |tidy/5.8.0                       |Generic             |
|2022-10-29 |ghc/8.6.5                        |Generic             |
|   ""      |pandoc-citeproc/0.17.0.2         |Generic             |
|2022-10-31 |git/2.38.1                       |Generic             |
|   ""      |aria2/1.36.0                     |Generic             |
|2022-11-01 |alpine/2.26                      |Generic             |
|   ""      |readline/8.0                     |Generic             |
|   ""      |Cytoscape/3.9.1                  |Generic             |
|   ""      |nano/6.0                         |Generic             |
|   ""      |R/4.2.2                          |Generic             |
|   ""      |parallel/20220222                |Generic             |
|   ""      |pdf2djvu/0.9.19                  |Generic             |
|2022-11-02 |lapack/3.10.1                    |Generic             |
|   ""      |GraphicsMagick/1.3.38            |Generic             |
|   ""      |QTLtools/1.3.1-25                |Genetics[^qtltools] |
|   ""      |NLopt/2.7.1                      |Generic             |
|   ""      |blat/37x1                        |Genetics            |
|   ""      |bedtools2/2.29.2                 |Genetics            |
|   ""      |bedops/2.4.41                    |Genetics            |
|2022-11-03 |Beagle/3.0.4                     |Genetics            |
|   ""      |netbeans/15                      |Generic             |
|   ""      |JAGS/4.3.1                       |Generic             |
|   ""      |exiv2/0.27.5                     |Generic[^exiv2]     |
|   ""      |googletest/1.8.0                 |Generic             |
|   ""      |googletest/1.12.1                |Generic             |
|   ""      |libiconv/1.17                    |Generic             |
|   ""      |ldc2/1.24.0                      |Generic             |
|   ""      |gettext/0.21                     |Generic             |
|   ""      |ssw/0.7                          |Generic             |
|   ""      |fribidi/1.0.8                    |Generic             |
|   ""      |proj/6.3.0                       |Generic             |
|   ""      |gmp/6.2.1                        |Generic             |
|   ""      |pcre2/10.30                      |Generic             |
|   ""      |zstd/1.5.2                       |Generic             |
|2022-11-04 |libxslt/1.1.34                   |Generic[^libxslt]   |
|   ""      |libssh2/1.10.0                   |Generic             |
|   ""      |libxml2/2.9.10                   |Generic[^libxml2]   |
|   ""      |libsodium/1.10.0                 |Generic             |
|   ""      |gdal/3.0.4                       |Generic[^gdal]      |
|   ""      |expat/2.4.7                      |Generic[^expat]     |
|   ""      |docbook2X/0.8.8                  |Generic             |
|   ""      |libntlm/1.6                      |Generic             |
|   ""      |vala/0.46.5                      |Generic             |
|   ""      |gtksourceview/4.0.3              |Generic             |
|   ""      |oniguruma/6.9.8                  |Generic             |
|   ""      |nspr/4.35                        |Generic             |
|   ""      |nettle/2.7.1                     |Generic             |
|2022-11-05 |trinculo/0.96                    |Generic             |
|   ""      |ruby/2.7.5                       |Generic             |
|2022-11-06 |libpng/0.5.30                    |Generic             |
|   ""      |libgit2/1.1.0                    |Generic[^libgit2]   |
|   ""      |git-extras/6.5.0                 |Generic             |
|   ""      |trousers/0.3.14                  |Generic             |
|   ""      |libidn2/2.3.4                    |Generic             |
|   ""      |unbound/1.17.0                   |Generic             |
|   ""      |nettle/3.6.0                     |Generic[^nettle]    |
|   ""      |gnutls/3.7.8                     |Generic[^gnutls]    |
|2022-11-08 |CrossMap/0.6.4                   |Genetics            |
|   ""      |SurvivalKit/6.12                 |Genetics            |
|   ""      |PRSice/2.3.3                     |Genetics            |
|2022-11-09 |qctool/2.2.0                     |Genetics            |
|   ""      |fossil/2.19                      |Generic             |
|2022-11-10 |rclone/1.53.1                    |Generic             |
|   ""      |CaVEMaN/1.01-c1815a0             |Genetics            |
|   ""      |akt/0.3.3                        |Genetics            |
|   ""      |MsCAVIAR/0.6.4                   |Genetics            |
|   ""      |CAVIAR/2.2                       |Genetics            |
|   ""      |MONSTER/1.3                      |Genetics            |
|   ""      |osca/0.46                        |Genetics            |
|   ""      |LEMMA/1.0.4                      |Genetics[^lemma]    |
|   ""      |CAVIARBF/0.2.1                   |Genetics            |
|2022-11-11 |PAINTOR/3.0                      |Genetics            |
|   ""      |ABCtoolbox/2.0                   |Generic             |
|   ""      |cppunit/1.15.2                   |Generic             |
|2022-11-12 |ccal/2.5.3                       |Generic             |
|2022-11-13 |axel/2.17.11                     |Generic[^axel]      |
|   ""      |axel/1.0a                        |Generic             |
|   ""      |bazel/2.0.0                      |Generic             |
|   ""      |bazel/1.2.1                      |Generic             |
|2022-11-14 |MR-MEGA/0.2                      |Genetics            |
|2022-11-16 |SNP2HLA/1.0.3                    |Genetics            |
|   ""      |STAR/2.7.10b                     |Genetics            |
|   ""      |Mega2/6.0.0                      |Genetics            |
|2022-11-18 |ffmpeg/5.1.1                     |Generic             |
|2022-11-19 |ensembl-vep/104                  |Genetics*           |
|   ""      |OpenMS/3.0.0-pre-develop         |Genetics*[^OpenMS]  |
|   ""      |polyphen/2.2.2                   |Genetics*           |
|   ""      |ANNOVAR/24Oct2019                |Genetics*           |
|   ""      |MAGENTA/vs2_July2011             |Genetics*           |
|   ""      |GARFIELD/v2                      |Genetics*           |
|   ""      |KentUtils/2022-11-14             |Genetics*           |
|2022-11-20 |Genotype-Harmonizer/1.4.25       |Genetics            |
|2022-11-21 |locuszoom/1.4                    |Genetics*[^lz]      |
|   ""      |DEPICT/v1_rel194                 |Genetics*           |
|   ""      |MAGMA/1.10                       |Genetics*           |
|   ""      |Pascal/v_debut                   |Genetics*           |
|   ""      |VEGAS2/2.01.17                   |Genetics*           |
|   ""      |fgwas/0.3.6                      |Genetics*           |
|2022-11-24 |qtcreator/2.5.2                  |Generic             |
|   ""      |rstudio/2022.07.2+576            |Generic             |
|2022-11-26 |yaml-cpp/0.7.0                   |Generic             |
|   ""      |libglvnd/1.6.0                   |Generic             |
|   ""      |GreenAlgorithmsforHPC/0.2.2-beta |Generic             |
|2022-11-28 |openssl/1.1.1s                   |Generic             |
|2022-11-29 |qt/5.15.7                        |Generic*            |
|2022-12-02 |rstudio/1.3.1093                 |Generic[^rstudio]   |
|2022-12-04 |phenoscanner/v2                  |Genetics*           |
|2022-12-07 |SurvivalAnalysis/2016-05-09      |Genetics            |
|2022-12-14 |node/16.14.0                     |Generic             |
|2022-12-19 |rstudio/2022.12.0+353            |Generic             |
|   ""      |icu/50.2                         |Generic             |
|2022-12-20 |snakemake/7.19.1                 |Generic             |
|2022-12-21 |icu/70.1                         |Generic             |
|   ""      |libuv/1.43.0                     |Generic             |
|   ""      |libcares/1.18.1                  |Generic             |
|   ""      |brotli/1.0.9                     |Generic             |
|2022-12-28 |ncurses/6.3                      |Generic             |
|2023-01-03 |Eagle/2.4.1                      |Genetics            |
|2023-01-05 |GEM/1.4.5                        |Genetics            |
|2023-02-01 |GENEHUNTER/2.1_r6                |Genetics            |
|2023-02-26 |JabRef/5.9                       |Generic             |
|2023-02-27 |Zotero/6.0.22                    |Generic             |
|2023-03-14 |regenie/3.2.5                    |Genetics            |
|2023-03-22 |rstudio/2023.03.0+386            |Generic             |
|2023-03-24 |PoGo/1.0.0                       |Genetics            |
|2023-03-31 |PWCoCo/2023-03-31                |Genetics[^pwcoco]   |
|2023-04-02 |regenie/3.2.5.3                  |Genetics            |
|2023-04-04 |PWCoCo/1.0                       |Genetics            |
|2023-04-05 |PhySO/1.0-dev0                   |Generic             |
!2023-04-21 |ImageJ/1.53t                     |Generic             |
!2023-04-25 |busybox/1.35.0                   |Generic             |
|2023-06-02 |regenie/3.2.7                    |Genetics[^regenie]  |
|2023-06-05 |gsl/2.7.1                        |Generic             |
|2023-06-06 |allegre/2.0f                     |Genetics            |
|2023-06-14 |autoconf/2.72c.24-8e728          |Generic[^autoconf]  |
|2023-06-16 |globusconnectpersonal/3.2.2      |Generic             |
|2023-06-19 |plink-ng/2.00a3.3                |Genetics            |
|2023-06-26 |RHHsoftware/0.1                  |Genetics            |
!2023-07-19 |pdfjam/3.06                      |Generic             |
|2023-07-22 |rstudio/2023.06.1+524            |Generic             |
|2023-07-28 |PWCoCo/1.1                       |Genetics            |
|2023-08-02 |regenie/3.2.9                    |Genetics            |
|2023-08-02 |fossil/2.22                      |Generic             |
|2023-08-04 |quarto/1.3.450-icelake           |Generic[^quarto]    |
|2023-08-06 |finemap/1.4.2                    |Genetics            |
|2023-08-10 |GreenAlgorithmsforHPC/0.3        |Generic             |
|2023-08-12 |xpdf/4.04                        |Generic[^xpdf]      |
!2023-08-22 |thunderbird/115.1.1              |Generic             |
!2023-08-24 |pdfjam/3.07                      |Generic             |
|2023-09-03 |2.0.0-pre1ge32bec                |Genetic[^pspp]      |
|2023-09-03 |spead-sheet-widget               |Generic             |
|2023-09-27 |ncbi-vdb/3.0.8                   |Genetics[^ncbi-vdb] |
|2023-09-27 |sra-tools/3.0.8                  |Genetics[^sra-tools]|
|2023-09-27 |gatk/4.4.0.0                     |Genetics[^gatk]     |

\* CEU or approved users only.

Three aspects are notable,

1. A file named NOTE indicates the original annotation. 
2. A symbolic link is generated when appropriate to simplify executable file name.
3. The available source package is kept in the sources/ directory.

[^ls]: The list is generated and the number counted with

    ```bash
    Rscript -e 'setdiff(dir(),c("doc","lib","misc","sources"))'
    # Generic, Genetics, All
    grep -e Generic ceuadmin.md | grep "^[|]" | wc -l
    grep -e Genetics ceuadmin.md | grep "^[|]" | wc -l
    grep -e Genetics -e Generic ceuadmin.md | grep "^[|]" | wc -l
    ```

    The latest R (4.2.2 as of 31/10/2022) is installed but a larger collection of packages will be deposited at /rds/project/jmmh2.

[^gui]: GUI

    As GUI-based programs claim more computing resources, it is recommended that they are only used occasionally, e.g., calling back GitHub sessions.

[^metal]: Notes on METAL 2020-05-05r

    This version has options EFFECT_PRINT_PRECISION and STDERR_PRINT_PRECISION (both with default 4) to enable many decimal places.

    The letter `r` as in `2020-05-05r` indicates a replacement of functions in `libsrc/MathStats.cpp` to ensure generality -- [details](http://numerical.recipes/forum/attachment.php?attachmentid=60&d=1190409664) have also been posted to the GitHub page, [https://github.com/statgen/METAL/issues/24](https://github.com/statgen/METAL/issues/24).

    ```
    FATAL ERROR -
    a too large, ITMAX too small in gamma countinued fraction (gcf)

    so the -1.info file could not be generated.
    ```

[^gemma]: Note on compiling from source

    A considerably smaller (1,097,256 vs 22,721,624) executable, /usr/local/Cluster-Apps/ceuadmin/GEMMA/0.98.5/bin, is generated under CSD3 but the original distribution is used by default.

    ```bash
    module load openblas/0.2.15
    make
    ```

[^fcgene]: Alternative site

    See [https://github.com/dr-roshyara/fcgene](https://github.com/dr-roshyara/fcgene)

[^jq]: The executable points to the one available from the website.

    The bin/, include/, lib/, share/ directories are obtained from source with oniguruma also compiled independently.

[^qtltools]: The long version number is 1.3.1-25-g6e49f85f20.

[^exiv2]: This is compiled with configuration

    ```bash
    cmake -DCMAKE_INSTALL_PREFIX=$CEUADMIN/exiv/0.27.5 -DEXIV2_ENABLE_NLS=On -DEXIV2_ENABLE_BMFF=On -DEXIV2_BUILD_UNIT_TESTS=Off -DCMAKE_PREFIX_PATH=$HPC_WORK ..
    ```

    The modules ceuadmin/gettext/0.21, ceuadmin/libiconv/1.17, ceuadmin/googletest/1.8.0 are at disposal.

[^libxslt]: There is complaint about docbook as in expat, however there is no apparent option to control for this.

[^libxml2]: The packaging is not perfect and Python 2 package requires to be manually furnished,

    ```bash
    export PYTHONPATH=/usr/local/Cluster-Apps/ceuadmin/libxml2/2.9.10/lib/python2.7/site-packages
    ./configure --prefix=$CEUADMIN/libxml2/2.9.10
    cd libxml2-2.9.10/python
    python setup.py install --prefix=${PYTHONPATH}
    ```

    The module file is expicitly appended with

    ```bash
    module load python/2.7
    export PYTHONPATH=$root/lib/python2.7/site-packages:$PYTHONPATH
    ```

[^gdal]: This involves many libraries; an expeeriment has been done as follows,

    ```bash
    module load gcc/6
    module load cfitsio-3.450-gcc-5.4.0-colpo6h
    module load geos-3.6.2-gcc-5.4.0-vejexvy
    module load jpeg-9b-gcc-5.4.0-7s6bvoe
    module load libgeotiff-1.4.2-gcc-5.4.0-2emzhxh
    module load libpng-1.6.29-gcc-5.4.0-3qwhidp
    module load mpich-3.2-gcc-5.4.0-idlluti
    module load netcdf/4.4.1
    module load postgresql-9.5.3-gcc-5.4.0-fxmot7h
    module load zlib/1.2.11
    module load zstd-1.3.0-intel-17.0.4-eyn6gaw
    ./configure --with-libjson-c=$HPC_WORK --with-proj=$HPC_WORK --without-sqlite3 --prefix=$HPC_WORK \
      --with-cfitsio=/usr/local/software/spack/current/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/cfitsio-3.450-colpo6hwycaaind2al47yriydf4oysyx \
      --with-cpp14

   # module load json-c-0.13.1-gcc-5.4.0-ffamohj
   # module load proj-6.2.0-gcc-5.4.0-iw4jbzs
   #     --with-proj=/usr/local/software/spack/spack-git/opt/spack/linux-rhel7-broadwell/gcc-5.4.0/proj-6.2.0-iw4jbzsrjirypecjm4c7bmlhdvhgwjmx \
    ```

[^expat]: Due to error messages, the options are specified as follows,

    ```bash
    ./configure --prefix=$CEUADMIN/expat/2.4.7 --without-docbook
    ```

[^libgit2]: It uses Python 2.7 and libssh2 (as above). The following warnings are given

    ```
    /usr/bin/ld: warning: libssl.so.10, needed by /home/jhz22/hpc-work/lib/libssh2.so, may conflict with libssl.so.1.1
    /usr/bin/ld: warning: libcrypto.so.10, needed by /home/jhz22/hpc-work/lib/libssh2.so, may conflict with libcrypto.so.1.1
    ```

[^nettle]: This is required by gnutls/3.7.8, which requires `ceuadmin/gmp/6.2.1` and `--enable-mini-gmp`.

    Alternatively, we use

    ```bash
    ./configure --prefix=$HPC_WORK LDFLAGS=-L$HPC_WORK/lib64 LIBS=-lhogweed --disable-openssl \
                --with-lib-path=/usr/local/Cluster-Apps/ceuadmin/gmp/6.2.1/lib \
                --with-include-path=/usr/local/Cluster-Apps/ceuadmin/gmp/6.2.1/include
    ```

[^gnutls]: It requires libunistring (optionally --with-included-unistring), libidn2, libunbound, and trousers, all prepared above.

    ```bash
    ./configure --prefix=$HPC_WORK --with-included-unistring --with-nettle-mini --enable-ssl3-support \
                CFLAGS=-I$HPC_WORK/include LDFLAGS=-L$HPC_WORK/lib LIBS=-lhogweed LIBS=-lunbound LIBS=-ltspi \
                --enable-sha1-support --disable-guile
    ```

    It is necessary to edit `lib/pkcs11_privkey.c` to make `ck_rsa_pkcs_pss_params` definition explicit. Then there is error with guile so we use --disable-guile.

[^lemma]: The documentation indicates a requirement of gcc/9.4, boost/1.78, OpenMP/3.1 and/or Intel MKL Library 2019 Update 1 but it is possible to proceed with gcc/11, cmake-3.19.7-gcc-5.4-5gbsejo, boost-1.66.0-gcc-5.4.0-slpq3un, ceuadmin/bgen.

[^axel]: The following scripts avoid option `--without-ssl`.

    ```bash
     wget -qO- https://github.com/axel-download-accelerator/axel/releases/download/v2.17.11/axel-2.17.11.tar.gz | \
     tar xvfz -
     cd axel-2.17.11
    ./configure --prefix=$CEUADMIN/axel/2.17.11  LDFLAGS=-L/usr/lib64 LIBS=-lssl
    ```

[^OpenMS]: When the OpenMS module is loaded, pyopenms and alphapept also become available.

[^lz]: locuszoom

    The version adds chromosome X data and will have options using INTERVAL data.

[^rstudio]:

    This is replacement of the module by HPC (no longer working) with the RStudio itself unchanged.

[^pwcoco]:

    It compiles under gcc/9. Upon release of 1.1, this snapshot is removed.

[^regenie]:

    ```bash
    cd ~/rds/public_databases/software/
    wget -qO- https://github.com/rgcgithub/regenie/archive/refs/tags/v3.2.7.tar.gz | \
    tar xvfz -
    cd regenie-3.2.7/
    export BGEN_PATH=~/rds/public_databases/software/bgen
    module load zlib/1.2.11
    export ZLIB_LIBRARY=/usr/local/Cluster-Apps/zlib/1.2.11
    module load gcc/6
    module load cmake-3.19.7-gcc-5.4-5gbsejo
    module load intel/mkl/mic/2018.4
    mkdir build
    cd build
    cmake ..
    make
    ```

[^autoconf]:

    ```bash
    git clone git://git.sv.gnu.org/autoconf
    cd autoconf/
    ./bootstrap
    module load help2man-1.47.4-gcc-4.8.5-phopsy7
    ./configure --prefix=/home/jhz22/rds/public_databases/software
    moke
    make install
    ```

[^quarto]:

    It requires CentOS 8 (icelake, or login-q-*); otherwise it fails with message: `GLIBC_2.18` not found.

    Upon installation, we supplement `jupyter` (python3 -m pip install jupyter --target=${PWD}/python; set PYTHONPATH in the module) and `knitr` (R_LIBS is set in the module). Furthermore, to allow for generality, python and R directories are symbollically linked.

    To enable `rmarkdown`, we need to get around issue of no Internet on icelake with the following,

    ```r
    packages <- c("base64enc","bslib","cachem","cli","digest",
                  "ellipsis","evaluate","fastmap","fontawesome","fs",
                  "glue","htmltools","jquerylib","jsonlite","knitr",
                  "lifecycle","memoise","mime","R6","rappdirs",
                  "rlang","rmarkdown","sass","stringi","stringr",
                  "tinytex","vctrs","xfun","yaml")
    download.packages(packages,".")
    install.packages(dir(pattern="tar.gz"),lib="R",repos=NULL)
    ```

    somewhat repetitive nonetheless successful since some are package dependencies.

    $ quarto check
    ```
    [✓] Checking versions of quarto binary dependencies...
          Pandoc version 3.1.1: OK
          Dart Sass version 1.55.0: OK
    [✓] Checking versions of quarto dependencies......OK
    [✓] Checking Quarto installation......OK
          Version: 1.3.450
          Path: /usr/local/Cluster-Apps/ceuadmin/quarto/1.3.450-icelake/bin
    
    [✓] Checking basic markdown render....OK
    
    [✓] Checking Python 3 installation....OK
          Version: 3.8.11
          Path: /usr/local/software/spack/spack-views/rhel8-icelake-20211027_2/python-3.8.11/gcc-11.2.0/pqdmnzmwkrtp4e3gjibmcxho7g6ekpat/bin/python3
          Jupyter: 5.3.1
          Kernels: python3
    
    [✓] Checking Jupyter engine render....OK
    
    [✓] Checking R installation...........OK
          Version: 4.3.1
          Path: /usr/local/Cluster-Apps/R/4.3.1-icelake/lib64/R
          LibPaths:
            - /usr/local/Cluster-Apps/ceuadmin/quarto/R
            - /usr/local/Cluster-Apps/R/4.3.1-icelake/lib64/R/library
            - /rds/project/jmmh2/rds-jmmh2-public_databases/software/R
            - /rds/project/jmmh2/rds-jmmh2-public_databases/software/R-4.3.1/library
          knitr: 1.43
          rmarkdown: 2.23
    
    [✓] Checking Knitr engine render......OK
    ```

[^xpdf]: To enable display fonts as in login-e-[1-4] in /etc/xpdfrc or ~/.xpdfrc

    ```
    # SJR addition
    fontFile Times-Roman           /usr/share/fonts/urw-base35/NimbusRoman-Regular.t1
    fontFile Times-Italic          /usr/share/fonts/urw-base35/NimbusRoman-Italic.t1
    fontFile Times-Bold            /usr/share/fonts/urw-base35/NimbusRoman-Bold.t1
    fontFile Times-BoldItalic      /usr/share/fonts/urw-base35/NimbusRoman-BoldItalic.t1
    fontFile Helvetica             /usr/share/fonts/urw-base35/NimbusSans-Regular.t1
    fontFile Helvetica-Oblique     /usr/share/fonts/urw-base35/NimbusSans-Italic.t1
    fontFile Helvetica-Bold        /usr/share/fonts/urw-base35/NimbusSans-Bold.t1
    fontFile Helvetica-BoldOblique /usr/share/fonts/urw-base35/NimbusSans-BoldItalic.t1
    fontFile Courier               /usr/share/fonts/urw-base35/NimbusMonoPS-Regular.t1
    fontFile Courier-Oblique       /usr/share/fonts/urw-base35/NimbusMonoPS-Italic.t1
    fontFile Courier-Bold          /usr/share/fonts/urw-base35/NimbusMonoPS-Bold.t1
    fontFile Courier-BoldOblique   /usr/share/fonts/urw-base35/NimbusMonoPS-BoldItalic.t1
    fontFile Symbol                /usr/share/fonts/urw-base35/StandardSymbolsPS.t1
    fontFile ZapfDingbats          /usr/share/fonts/urw-base35/D050000L.t1
    ```

[^pspp]: Makeinfo

    The following replacement is used.

    ```
    MAKEINFO = ${SHELL} '/rds/project/jmmh2/rds-jmmh2-public_databases/software/pspp-2.0.0-pre1ge32bec/build-aux/missing' makeinfo --force --no-validate
    ```
    while the rest is copied from GNU build, <https://benpfaff.org/~blp/pspp-master/20230624103130/x86_64/pspp-2.0.0-pre1ge32bec-x86_64-build20230624103419.tar.gz>.

[^ncbi-vdb]:

    The installation is preceeded with `module load gcc/6 flex-2.6.4-gcc-5.4.0-2u2fgon`. Although `configure` is provided, `cmake` is used instead.

    ```bash
    cmake -DCMAKE_PREFIX_PATH=$CEUADMIN/ncbi-vdb/3.0.8 -DCMAKE_INSTALL_PREFIX=$CEUADMIN/ncbi-vdb/3.0.8 ..
    ```

[^sra-tools]:

    First, create a symbolic link for `ncbi-vdb/3.0.8` in the parent directory.

    ```bash
    cmake -DVDB_LIBDIR=$CEUADMIN/ncbi-vdb/3.0.8/lib64 -DCMAKE_INSTALL_PREFIX=$CEUADMIN/sra-tools/3.0.8 ..
    ```
    
    Drop `constexpr` as in `constexpr size_type max_size() const { return SIZE_MAX; }` in line 161 of the following header file:

    `/usr/local/Cluster-Apps/ceuadmin/sra-tools/3.0.8/tools/external/driver-tool/util.hpp`.

[^gatk]:

    The Python dependencies are set up as follows,

    ```bash
    module load anaconda/3.2019-10
    conda env create -p /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10 -f gatkcondaenv.yml
    conda activate /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10
    ```

    Workflow downloads: <https://github.com/gatk-workflows>
