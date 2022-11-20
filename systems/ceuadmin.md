---
sort: 7
---

# ceuadmin

The CEU software repository is here, **/usr/local/Cluster-Apps/ceuadmin/**. As of November 2022, the list is as follows,

```
  [1] "ABCtoolbox"      "akt"             "alpine"          "annovar"
  [5] "aria2"           "axel"            "bazel"           "bcftools"
  [9] "Beagle"          "bedops"          "bedtools2"       "bgen"
 [13] "biobank"         "blat"            "boltlmm"         "CaVEMaN"
 [17] "CAVIAR"          "CAVIARBF"        "ccal"            "circos"
 [21] "citeproc"        "cppunit"         "crossmap"        "Cytoscape"
 [25] "DjVuLibre"       "docbook2X"       "DosageConverter" "ensembl-vep"
 [29] "exiv2"           "exomeplus"       "expat"           "FastQTL"
 [33] "fcGENE"          "ffmpeg"          "finemap"         "fossil"
 [37] "fribidi"         "GARFIELD"        "gcta"            "gdal"
 [41] "GEMMA"           "gettext"         "ghc"             "ghostscript"
 [45] "git"             "git-extras"      "GitKraken"       "gmp"
 [49] "gnutls"          "googletest"      "GraphicsMagick"  "gtksourceview"
 [53] "gtool"           "hpg"             "htslib"          "impute"
 [57] "JAGS"            "jq"              "KentUtils"       "KING"
 [61] "lapack"          "ldc2"            "LDstore"         "LEMMA"
 [65] "libgit2"         "libiconv"        "libidn2"         "libntlm"
 [69] "libpng"          "libsodium"       "libssh2"         "libxml2"
 [73] "libxslt"         "MAGENTA"         "magma"           "Mega2"
 [77] "metal"           "MONSTER"         "MORGAN"          "MR-MEGA"
 [81] "MsCAVIAR"        "nano"            "netbeans"        "nettle"
 [85] "NLopt"           "nspr"            "oniguruma"       "OpenMS"
 [89] "osca"            "PAINTOR"         "pandoc"          "pandoc-citeproc"
 [93] "parallel"        "pcre2"           "pdf2djvu"        "plink"
 [97] "plink-bgi"       "plinkseq"        "polyphen"        "poppler"
[101] "proj"            "PRSice"          "pspp"            "qctool"
[105] "qpdf"            "QTLtools"        "quicktest"       "R"
[109] "raremetal"       "rclone"          "readline"        "regenie"
[113] "ruby"            "samtools"        "shapeit"         "SMR"
[117] "SNP2HLA"         "snptest"         "sqlite"          "ssw"
[121] "STAR"            "stata"           "SurvivalKit"     "tabix"
[125] "tidy"            "trinculo"        "trousers"        "Typora"
[129] "unbound"         "vala"            "vcftools"        "VSCode"
[133] "zstd"
```

These are wrapped up as :star::star::star: **[modules](https://modules.readthedocs.io/en/latest/index.html)** :star::star::star:.

A module is loaded/unloaded as follows,

```bash
module load ceuadmin/<module name>
```

Other commands include `display`, `help`, `show`, `whatis`, as in [3.2.9](https://linux.die.net/man/4/modulefile). In particular, 
`module whatis ceuadmin/ensembl-vep` indicates usage regarding build37/build38 setup for the `loftee` plugin used in loss of 
function (LoF) annotation.

The module files are defined at **/usr/local/Cluster-Config/modulefiles/ceuadmin**.

Ideally, software with large size / reference data will be available from /rds/project/jmmh2/software. However, CEU users will be 
able to use ANNOVAR, ensembl-vep, OpenMS, polyphen, KentUtils linking internal projects/personal space (additional requests need to 
be made). Further information is avaiiable from **doc/README.md, README.html**. A large collection of R packages (1,258 as of 
November 2022) is linked with ceuadmin/R/4.2.2, the latest R distribution, please drop an email to <jhz22@medschl.cam.ac.uk> for 
access. The original list prior to November 2022 is given blow[^original].

---

[^original]:
    The original list was a mixture of modules and directories as follows,

    ```
    bgenix/               impute_v2.3.2_x86_64_static/  plink/                        R/                 Raremetal_linux_executables/        snptest_new/
    biobank/              interval/                     plink_1.90_beta/              raremetal_4.13/    Raremetal_linux_executables.tgz     source/
    boltlmm/              JAGS/                         plink_bgi_Dev/                raremetal_4.13.3/  raremetal.log                       stata/
    boltlmm_2.2/          LDstore/                      plink-bgi_linux_x86_64_may/   raremetal_4.13.4/  regenie/                            tabix/
    crossmap/             locuszoom/                    plink_linux_x86_64_beta2a/    raremetal_4.13.5/  samtools-1.10.tar.bz2               temp/
    exomeplus/            magma/                        plink_linux_x86_64_beta3.32/  raremetal_4.13.7/  samtools_1.2/                       vcftools/
    gcta/                 MAGMA_Celltyping/             plinkseq-0.08-x86_64/         raremetal_4.13.8/  shapeit.v2.r790.RHELS_5.4.dynamic/  vcftools_ps629/
    gtool_v0.7.5_x86_64/  metabolomics/                 plinkseq-0.10/                raremetal_4.14.0/  snptest/
    hpg/                  metal/                        pspp/                         raremetal_4.14.1/  snptest_2.5.2/
    htslib/               metal_updated/                qctool_v1.4-linux-x86_64/     raremetal_BPGen/   snptest_2.5.4_beta3/
    ```

    A grep of recent add-ons in the Genetics category is as follows,

    | Date       | Add.ons               | Category            |
    | :--------- | :-------------------- | :------------------ |
    | 2022-10-22 | snptest/2.5.6         | Genetics            |
    | ""         | qctool/2.0.8          | Genetics            |
    | ""         | gcta/1.94.1           | Genetics            |
    | ""         | KING/2.1.6            | Genetics            |
    | ""         | LDstore/2.0           | Genetics            |
    | ""         | shapeit/3             | Genetics            |
    | ""         | vcftools/0.1.16       | Genetics            |
    | ""         | finemap/1.4           | Genetics            |
    | 2022-10-23 | quicktest/1.1         | Genetics            |
    | ""         | samtools/1.11         | Genetics            |
    | ""         | bcftools/1.12         | Genetics            |
    | ""         | MORGAN/3.4            | Genetics            |
    | ""         | METAL/2020-05-05r     | Genetics[^metal]    |
    | ""         | regenie/3.2.1         | Genetics            |
    | ""         | GEMMA/0.98.5          | Genetics[^gemma]    |
    | ""         | htslib/1.12           | Genetics            |
    | ""         | fcGENE/1.0.7          | Genetics[^fcgene]   |
    | ""         | SMR/1.0.3             | Genetics            |
    | ""         | FastQTL/2.165         | Genetics            |
    | 2022-10-26 | circos/0.69-9         | Genetics            |
    | ""         | bgen/1.1.7            | Genetics            |
    | ""         | DosageConverter/1.0.0 | Genetics            |
    | ""         | QTLtools/1.3.1-25     | Genetics[^qtltools] |
    | ""         | blat/37x1             | Genetics            |
    | ""         | bedtools2/2.29.2      | Genetics            |
    | ""         | bedops/2.4.41         | Genetics            |
    | 2022-11-03 | Beagle/3.0.4          | Genetics            |
    | 2022-11-08 | CrossMap/0.6.4        | Genetics            |
    | ""         | SurvivalKit/6.12      | Genetics            |
    | ""         | PRSice/2.3.3          | Genetics            |
    | 2022-11-09 | qctool/2.2.0          | Genetics            |
    | 2022-11-10 | CaVEMaN/1.01-c1815a0  | Genetics            |
    | ""         | akt/0.3.3             | Genetics            |
    | ""         | MsCAVIAR/0.6.4        | Genetics            |
    | ""         | CAVIAR/2.2            | Genetics            |
    | ""         | MONSTER/1.3           | Genetics            |
    | ""         | osca/0.46             | Genetics            |
    | ""         | LEMMA/1.0.4           | Genetics[^lemma]    |
    | ""         | CAVIARBF/0.2.1        | Genetics            |
    | 2022-11-11 | PAINTOR/3.0           | Genetics            |
    | 2022-11-14 | MR-MEGA/0.2           | Genetics            |
    | 2022-11-16 | SNP2HLA/1.0.3         | Genetics            |
    | ""         | STAR/2.7.10b          | Genetics            |
    | ""         | Mega2/6.0.0           | Genetics            |
    | 2022-11-19 | ensembl-vep/104       | Genetics\*          |
    | ""         | OpenMS/3.0.0          | Genetics\*          |
    | ""         | polyphen/2.2.2        | Genetics\*          |
    | ""         | ANNOVAR/24Oct2019     | Genetics\*          |
    | ""         | MAGENTA/vs2_July2011  | Genetics\*          |
    | ""         | GARFIELD/v2           | Genetics\*          |
    | ""         | KentUtils/2022-11-14  | Genetics\*          |

    \* CEU or approved users only.

[^metal]: Notes on METAL 2020-05-05r

    This version has options EFFECT_PRINT_PRECISION and STDERR_PRINT_PRECISION (both with default 4) to enable many decimal places.

    The letter `r` as in `2020-05-05r` indicates a replacement of functions in `libsrc/MathStats.cpp` to ensure generality -- [details](files/complaint.pdf) have also been posted to the GitHub page, [https://github.com/statgen/METAL/issues/24](https://github.com/statgen/METAL/issues/24).

    ```
    FATAL ERROR -
    a too large, ITMAX too small in gamma countinued fraction (gcf)

    so the -1.info file could not be generated.
    ```

[^gemma]: Note on compiling from source

    A considerably smaller (1,097,256 vs 22,721,624) executable, /usr/local/Cluster-Apps/ceuadmin/GEMMA/0.98.5/bin, is generated under CSD3 but the origina>

    ```bash
    module load openblas/0.2.15
    make
    ```

[^fcgene]: Alternative site

    See [https://github.com/dr-roshyara/fcgene](https://github.com/dr-roshyara/fcgene)

[^qtltools]: The long version number is 1.3.1-25-g6e49f85f20.
[^lemma]: The documentation indicates a requirement of gcc/9.4, boost/1.78, OpenMP/3.1 and/or Intel MKL Library 2019 Update 1 but it is possible to proceed with gcc/11, cmake-3.19.7-gcc-5.4-5gbsejo, boost-1.66.0-gcc-5.4.0-slpq3un, ceuadmin/bgen/1.1.7.
