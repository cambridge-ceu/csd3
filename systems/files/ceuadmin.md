# A full list of ceuadmin modules

Location at CSD3: /usr/local/Cluster-Apps/ceuadmin, (module files: /usr/local/Cluster-Config/modulefiles/ceuadmin)

The current list is as follows[^ls],

```
  [1] "ABCtoolbox"            "akt"                   "allegro"               "alpine"
  [5] "Anaconda3"             "annovar"               "aria2"                 "autoconf"
  [9] "automake"              "axel"                  "bazel"                 "bcftools"
 [13] "Beagle"                "bedops"                "bedtools2"             "bgen"
 [17] "biobank"               "blat"                  "boltlmm"               "brotli"
 [21] "busybox"               "CaVEMaN"               "CAVIAR"                "CAVIARBF"
 [25] "ccal"                  "circos"                "citeproc"              "cmake"
 [29] "cppunit"               "crossmap"              "Cytoscape"             "deno"
 [33] "DEPICT"                "DjVuLibre"             "docbook2X"             "DosageConverter"
 [37] "Eagle"                 "enchant"               "ensembl-vep"           "exiv2"
 [41] "exomeplus"             "expat"                 "FastQTL"               "fcGENE"
 [45] "ffmpeg"                "fgwas"                 "finemap"               "fossil"
 [49] "fpc"                   "fraposa_pgsc"          "fribidi"               "GARFIELD"
 [53] "gatk"                  "gcta"                  "gdal"                  "gdc"
 [57] "geany"                 "GEM"                   "GEMMA"                 "Genotype-Harmonizer"
 [61] "gettext"               "gh"                    "ghc"                   "ghostscript"
 [65] "git"                   "git-extras"            "GitKraken"             "glib"
 [69] "glibc"                 "globusconnectpersonal" "glpk"                  "gmp"
 [73] "gnutls"                "go"                    "googletest"            "graphene"
 [77] "GraphicsMagick"        "GreenAlgorithms4HPC"   "gsl"                   "gtk+"
 [81] "gtksourceview"         "gtool"                 "hpg"                   "htslib"
 [85] "hunspell"              "icu"                   "ImageJ"                "impute"
 [89] "JabRef"                "JAGS"                  "jq"                    "KentUtils"
 [93] "KING"                  "lapack"                "ldc2"                  "ldsc"
 [97] "LDstore"               "LEMMA"                 "libcares"              "libgit2"
[101] "libglvnd"              "libiconv"              "libidn2"               "libntlm"
[105] "libpng"                "libseccomp"            "libsodium"             "libssh2"
[109] "libuv"                 "libxml2"               "libxslt"               "locuszoom"
[113] "MAGENTA"               "magma"                 "Mango"                 "Mega2"
[117] "metal"                 "MONSTER"               "MORGAN"                "MR-MEGA"
[121] "MsCAVIAR"              "nano"                  "ncbi-vdb"              "ncurses"
[125] "netbeans"              "nettle"                "nextflow"              "NLopt"
[129] "node"                  "nspr"                  "oniguruma"             "openjdk"
[133] "OpenMS"                "openssh"               "openssl"               "osca"
[137] "PAINTOR"               "pandoc"                "pandoc-citeproc"       "pango"
[141] "parallel"              "Pascal"                "pcre2"                 "pdf2djvu"
[145] "pdfjam"                "pgsc_calc"             "phenoscanner"          "PhySO"
[149] "picard"                "plink"                 "plink-bgi"             "plinkseq"
[153] "PoGo"                  "polyphen"              "poppler"               "proj"
[157] "PRSice"                "pspp"                  "pulsar"                "PWCoCo"
[161] "qctool"                "qpdf"                  "qt"                    "qtcreator"
[165] "QTLtools"              "quarto"                "quicktest"             "R"
[169] "raremetal"             "rclone"                "readline"              "regenie"
[173] "regtools"              "RHHsoftware"           "rst2pdf"               "rstudio"
[177] "ruby"                  "rust"                  "samtools"              "Scala"
[181] "shapeit"               "singularity"           "SMR"                   "snakemake"
[185] "SNP2HLA"               "snptest"               "spread-sheet-widget"   "sqlite"
[189] "sra-tools"             "ssw"                   "STAR"                  "stata"
[193] "SurvivalAnalysis"      "SurvivalKit"           "Swift"                 "tabix"
[197] "tatami"                "thunderbird"           "tidy"                  "trinculo"
[201] "trousers"              "Typora"                "unbound"               "vala"
[205] "VarScan"               "vcftools"              "VEGAS2"                "verifyBamID"
[209] "VSCode"                "VSCodium"              "vte"                   "xpdf"
[213] "yaml-cpp"              "Zotero"                "zstd"
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

| Date        | Add ons                          | Category             |
| :---------- | :------------------------------- | :------------------- |
| 2022-10-21  | pspp/1.6.0                       | Generic              |
| 2022-10-22  | snptest/2.5.6                    | Genetics             |
| ""          | qctool/2.0.8                     | Genetics             |
| ""          | gcta/1.94.1                      | Genetics             |
| ""          | KING/2.1.6                       | Genetics             |
| ""          | LDstore/2.0                      | Genetics             |
| ""          | shapeit/3                        | Genetics             |
| ""          | vcftools/0.1.16                  | Genetics             |
| ""          | finemap/1.4                      | Genetics             |
| 2022-10-23  | quicktest/1.1                    | Genetics             |
| ""          | samtools/1.11                    | Genetics             |
| ""          | bcftools/1.12                    | Genetics             |
| ""          | MORGAN/3.4                       | Genetics             |
| ""          | METAL/2020-05-05r                | Genetics[^metal]     |
| ""          | regenie/3.2.1                    | Genetics             |
| ""          | GEMMA/0.98.5                     | Genetics[^gemma]     |
| ""          | htslib/1.12                      | Genetics             |
| ""          | fcGENE/1.0.7                     | Genetics[^fcgene]    |
| ""          | SMR/1.0.3                        | Genetics             |
| ""          | FastQTL/2.165                    | Genetics             |
| ""          | GitKraken/8.1.0                  | Generic              |
| 2022-10-24  | Typora/0.11.8beta                | Generic              |
| ""          | pandoc/2.19.2                    | Generic              |
| ""          | citeproc/0.4.0.1                 | Generic              |
| ""          | citeproc/0.8.0.2                 | Generic              |
| 2022-10-26  | circos/0.69-9                    | Genetics             |
| ""          | DjVuLibre/3.5.27.1-14            | Generic              |
| ""          | ghostscript/9.56.1               | Generic              |
| ""          | bgen/1.1.7                       | Genetics             |
| 2022-10-27  | sqlite/3.39.4                    | Generic              |
| 2022-10-28  | poppler/0.84.0                   | Generic              |
| ""          | jq/1.6                           | Generic[^jq]         |
| ""          | DosageConverter/1.0.0            | Genetics             |
| ""          | tidy/5.8.0                       | Generic              |
| 2022-10-29  | ghc/8.6.5                        | Generic              |
| ""          | pandoc-citeproc/0.17.0.2         | Generic              |
| 2022-10-31  | git/2.38.1                       | Generic              |
| ""          | aria2/1.36.0                     | Generic              |
| 2022-11-01  | alpine/2.26                      | Generic              |
| ""          | readline/8.0                     | Generic              |
| ""          | Cytoscape/3.9.1                  | Generic              |
| ""          | nano/6.0                         | Generic              |
| ""          | R/4.2.2                          | Generic              |
| ""          | parallel/20220222                | Generic              |
| ""          | pdf2djvu/0.9.19                  | Generic              |
| 2022-11-02  | lapack/3.10.1                    | Generic              |
| ""          | GraphicsMagick/1.3.38            | Generic              |
| ""          | QTLtools/1.3.1-25                | Genetics[^qtltools]  |
| ""          | NLopt/2.7.1                      | Generic              |
| ""          | blat/37x1                        | Genetics             |
| ""          | bedtools2/2.29.2                 | Genetics             |
| ""          | bedops/2.4.41                    | Genetics             |
| 2022-11-03  | Beagle/3.0.4                     | Genetics             |
| ""          | netbeans/15                      | Generic              |
| ""          | JAGS/4.3.1                       | Generic              |
| ""          | exiv2/0.27.5                     | Generic[^exiv2]      |
| ""          | googletest/1.8.0                 | Generic              |
| ""          | googletest/1.12.1                | Generic              |
| ""          | libiconv/1.17                    | Generic              |
| ""          | ldc2/1.24.0                      | Generic              |
| ""          | gettext/0.21                     | Generic              |
| ""          | ssw/0.7                          | Generic              |
| ""          | fribidi/1.0.8                    | Generic              |
| ""          | proj/6.3.0                       | Generic              |
| ""          | gmp/6.2.1                        | Generic              |
| ""          | pcre2/10.30                      | Generic              |
| ""          | zstd/1.5.2                       | Generic              |
| 2022-11-04  | libxslt/1.1.34                   | Generic[^libxslt]    |
| ""          | libssh2/1.10.0                   | Generic              |
| ""          | libxml2/2.9.10                   | Generic[^libxml2]    |
| ""          | libsodium/1.10.0                 | Generic              |
| ""          | gdal/3.0.4                       | Generic[^gdal]       |
| ""          | expat/2.4.7                      | Generic[^expat]      |
| ""          | docbook2X/0.8.8                  | Generic              |
| ""          | libntlm/1.6                      | Generic              |
| ""          | vala/0.46.5                      | Generic              |
| ""          | gtksourceview/4.0.3              | Generic              |
| ""          | oniguruma/6.9.8                  | Generic              |
| ""          | nspr/4.35                        | Generic              |
| ""          | nettle/2.7.1                     | Generic              |
| 2022-11-05  | trinculo/0.96                    | Generic              |
| ""          | ruby/2.7.5                       | Generic              |
| 2022-11-06  | libpng/0.5.30                    | Generic              |
| ""          | libgit2/1.1.0                    | Generic[^libgit2]    |
| ""          | git-extras/6.5.0                 | Generic              |
| ""          | trousers/0.3.14                  | Generic              |
| ""          | libidn2/2.3.4                    | Generic              |
| ""          | unbound/1.17.0                   | Generic              |
| ""          | nettle/3.6.0                     | Generic[^nettle]     |
| ""          | gnutls/3.7.8                     | Generic[^gnutls]     |
| 2022-11-08  | CrossMap/0.6.4                   | Genetics             |
| ""          | SurvivalKit/6.12                 | Genetics             |
| ""          | PRSice/2.3.3                     | Genetics             |
| 2022-11-09  | qctool/2.2.0                     | Genetics             |
| ""          | fossil/2.19                      | Generic              |
| 2022-11-10  | rclone/1.53.1                    | Generic              |
| ""          | CaVEMaN/1.01-c1815a0             | Genetics             |
| ""          | akt/0.3.3                        | Genetics             |
| ""          | MsCAVIAR/0.6.4                   | Genetics             |
| ""          | CAVIAR/2.2                       | Genetics             |
| ""          | MONSTER/1.3                      | Genetics             |
| ""          | osca/0.46                        | Genetics             |
| ""          | LEMMA/1.0.4                      | Genetics[^lemma]     |
| ""          | CAVIARBF/0.2.1                   | Genetics             |
| 2022-11-11  | PAINTOR/3.0                      | Genetics             |
| ""          | ABCtoolbox/2.0                   | Generic              |
| ""          | cppunit/1.15.2                   | Generic              |
| 2022-11-12  | ccal/2.5.3                       | Generic              |
| 2022-11-13  | axel/2.17.11                     | Generic[^axel]       |
| ""          | axel/1.0a                        | Generic              |
| ""          | bazel/2.0.0                      | Generic              |
| ""          | bazel/1.2.1                      | Generic              |
| 2022-11-14  | MR-MEGA/0.2                      | Genetics             |
| 2022-11-16  | SNP2HLA/1.0.3                    | Genetics             |
| ""          | STAR/2.7.10b                     | Genetics             |
| ""          | Mega2/6.0.0                      | Genetics             |
| 2022-11-18  | ffmpeg/5.1.1                     | Generic              |
| 2022-11-19  | ensembl-vep/104                  | Genetics\*           |
| ""          | OpenMS/3.0.0-pre-develop         | Genetics\*[^OpenMS]  |
| ""          | polyphen/2.2.2                   | Genetics\*           |
| ""          | ANNOVAR/24Oct2019                | Genetics\*           |
| ""          | MAGENTA/vs2_July2011             | Genetics\*           |
| ""          | GARFIELD/v2                      | Genetics\*           |
| ""          | KentUtils/2022-11-14             | Genetics\*           |
| 2022-11-20  | Genotype-Harmonizer/1.4.25       | Genetics             |
| 2022-11-21  | locuszoom/1.4                    | Genetics\*[^lz]      |
| ""          | DEPICT/v1_rel194                 | Genetics\*           |
| ""          | MAGMA/1.10                       | Genetics\*           |
| ""          | Pascal/v_debut                   | Genetics\*           |
| ""          | VEGAS2/2.01.17                   | Genetics\*           |
| ""          | fgwas/0.3.6                      | Genetics\*           |
| 2022-11-24  | qtcreator/2.5.2                  | Generic              |
| ""          | rstudio/2022.07.2+576            | Generic              |
| 2022-11-26  | yaml-cpp/0.7.0                   | Generic              |
| ""          | libglvnd/1.6.0                   | Generic              |
| ""          | GreenAlgorithmsforHPC/0.2.2-beta | Generic              |
| 2022-11-28  | openssl/1.1.1s                   | Generic              |
| 2022-11-29  | qt/5.15.7                        | Generic\*            |
| 2022-12-02  | rstudio/1.3.1093                 | Generic[^rstudio]    |
| 2022-12-04  | phenoscanner/v2                  | Genetics\*           |
| 2022-12-07  | SurvivalAnalysis/2016-05-09      | Genetics             |
| 2022-12-14  | node/16.14.0                     | Generic              |
| 2022-12-19  | rstudio/2022.12.0+353            | Generic              |
| ""          | icu/50.2                         | Generic              |
| 2022-12-20  | snakemake/7.19.1                 | Generic              |
| 2022-12-21  | icu/70.1                         | Generic              |
| ""          | libuv/1.43.0                     | Generic              |
| ""          | libcares/1.18.1                  | Generic              |
| ""          | brotli/1.0.9                     | Generic              |
| 2022-12-28  | ncurses/6.3                      | Generic              |
| 2023-01-03  | Eagle/2.4.1                      | Genetics             |
| 2023-01-05  | GEM/1.4.5                        | Genetics             |
| 2023-02-01  | GENEHUNTER/2.1_r6                | Genetics             |
| 2023-02-26  | JabRef/5.9                       | Generic              |
| 2023-02-27  | Zotero/6.0.22                    | Generic              |
| 2023-03-14  | regenie/3.2.5                    | Genetics             |
| 2023-03-22  | rstudio/2023.03.0+386            | Generic              |
| 2023-03-24  | PoGo/1.0.0                       | Genetics             |
| 2023-03-31  | PWCoCo/2023-03-31                | Genetics[^pwcoco]    |
| 2023-04-02  | regenie/3.2.5.3                  | Genetics             |
| 2023-04-04  | PWCoCo/1.0                       | Genetics             |
| 2023-04-05  | PhySO/1.0-dev0                   | Generic              |
| 2023-04-21  | ImageJ/1.53t                     | Generic              |
| 2023-04-25  | busybox/1.35.0                   | Generic              |
| 2023-06-02  | regenie/3.2.7                    | Genetics[^regenie]   |
| 2023-06-05  | gsl/2.7.1                        | Generic              |
| 2023-06-06  | allegre/2.0f                     | Genetics             |
| 2023-06-14  | autoconf/2.72c.24-8e728          | Generic[^autoconf]   |
| 2023-06-16  | globusconnectpersonal/3.2.2      | Generic              |
| 2023-06-19  | plink-ng/2.00a3.3                | Genetics             |
| 2023-06-26  | RHHsoftware/0.1                  | Genetics             |
| 2023-07-19  | pdfjam/3.06                      | Generic              |
| 2023-07-22  | rstudio/2023.06.1+524            | Generic              |
| 2023-07-28  | PWCoCo/1.1                       | Genetics             |
| 2023-08-02  | regenie/3.2.9                    | Genetics             |
| ""          | fossil/2.22                      | Generic              |
| 2023-08-04  | quarto/1.3.450-icelake           | Generic[^quarto]     |
| 2023-08-06  | finemap/1.4.2                    | Genetics             |
| 2023-08-10  | GreenAlgorithmsforHPC/0.3        | Generic              |
| 2023-08-12  | xpdf/4.04                        | Generic[^xpdf]       |
| 2023-08-22  | thunderbird/115.1.1              | Generic              |
| 2023-08-24  | pdfjam/3.07                      | Generic              |
| 2023-09-03  | 2.0.0-pre1ge32bec                | Genetic[^pspp]       |
| ""          | spead-sheet-widget               | Generic              |
| 2023-09-27  | ncbi-vdb/3.0.8                   | Genetics[^ncbi-vdb]  |
| ""          | sra-tools/3.0.8                  | Genetics[^sra-tools] |
| ""          | gatk/4.4.0.0                     | Genetics[^gatk]      |
| 2023-09-28  | openjdk/8u382-b05                | Generic              |
| ""          | openjdk/11.0.20+8                | Generic              |
| ""          | openjdk/17.0.8+7                 | Generic              |
| 2023-10-24  | rst2pdf/0.101                    | Generic              |
| ""          | geany/1.38                       | Generic              |
| ""          | pango/1.41.1                     | Generic              |
| ""          | gettext/0.20                     | Generic              |
| 2023-10-26  | glib/2.58.3                      | Generic              |
| 2023-10-27  | graphene/1.4.0                   | Generic              |
| ""          | graphene/1.8.0                   | Generic              |
| 2023-10-24  | gtk+/3.24.0                      | Generic              |
| ""          | geany/2.0                        | Generic              |
| 2023-10-28  | hunspell/1.7.0                   | Generic              |
| ""          | hunspell/1.7.2                   | Generic              |
| ""          | enchant/2.2.0                    | Generic              |
| 2023-10-29  | gtk+/3.90.0                      | Generic              |
| 2023-10-31  | vte/0.55.0                       | Generic              |
| 2023-11-05  | Anaconda3/2023.09-0              | Generic              |
| 2023-11-23  | SciKit-LLM & OpenAI API          | Genetic              |
| 2023-11-24  | ldsc/1.0.1                       | Genetics             |
| 2023-11-30  | gdc/1.6.1-1.0.0                  | Genetics[^gdc]       |
| 2023-12-13  | rust/1.74.1                      | Generic              |
| 2023-12-20  | verifyBamID/1.1.3                | Genetics             |
| 2023-12-21  | verifyBamID/2.0.1                | Genetics[^VB2]       |
| 2023-12-27  | regtools/1.0.0                   | Genetics[^regtools]  |
| ""          | VarScan/2.4.6                    | Genetics[^varscan]   |
| 2024-01-02  | Mango/0.1.0                      | Generic              |
| 2024-01-08  | picard/3.1.1                     | Genetics             |
| ""          | plink/2.0_20240105               | Genetics             |
| 2024-01-10  | cmake/3.28.1                     | Generic              |
| ""          | tatami/2.1.2                     | Generic[^tatami]     |
| 2024-01-19  | htslib/1.19                      | Genetics             |
| 2024-01-23  | nextflow/23.10.1                 | Generic[^nextflow]   |
| ""          | go/1.21.6                        | Generic              |
| ""          | singularity/4.0.3                | Generic[^singularity]|
| ""          | libseccomp/2.5.5                 | Generic              |
| 2024-01-24  | fraposa_pgsc/0.1.0               | Genetics[^fraposa]   |
| ""          | pgsc_calc/2.0.0-alpha.4          | Genetics[^pgsc_calc] |
| 2024-01-27  | glibc/2.18                       | Generic              |
| ""          | glibc/2.26                       | Generic              |
| ""          | deno/1.40.2                      | Generic[^deno]       |
| ""          | deno/1.40.2-icelake              | Generic              |
| ""          | quarto/1.4.549                   | Generic              |
| 2024-02-29  | R/4.3.3                          | Generic[^R]          |
! 2024-03-01  | glpk/5.0                         | Generic              |
! 2024-03-02  | glpk/4.57                        | Generic              |
! 2024-03-04  | rstudio/2023.12.1-402            | Generic              |
! 2024-03-05  | GitKraken/9.12.0                 | Generic[^gitkraken]  |
! ""          | automake/1.16.5                  | Generic[^automake]   |
! ""          | pspp/2.0.0                       | Generic              |
! 2024-03-09  | Scala/3.3.3                      | Generic              |
! 2024-03-10  | fpc/3.2.2                        | Generic              |
! ""          | Swift/5.10                       | Generic              |
! ""          | pulsar/1.114.0                   | Generic              |
! ""          | VSCodium/1.87.1.24068            | Generic              |
! 2024-03-27  | openssl/3.2.1-icelake            | Generic[^openssl]    |
! ""          | openssh/9.7p1-icelake            | Generic[^openssh]    |

\* CEU or approved users only.

Three aspects are notable,

1. A file named NOTE indicates the original annotation.
2. A symbolic link is generated when appropriate to simplify executable file name.
3. The available source package is kept in the sources/ directory.


A word cloud diagram is generated from the following script

```bash
grep -e Generic ${CEUADMIN}/doc/ceuadmin.md | grep "^[|]" | awk '{print $4}' > generic.lst
grep -e Genetics ${CEUADMIN}/doc/ceuadmin.md | grep "^[|]" | awk '{print $4}' > genetics.lst
grep -e Genetics -e Generic ${CEUADMIN}/doc/ceuadmin.md | grep "^[|]" | awk '{print $4}' | wc -l
rm -f ceuadmin.png generic.png genetics.png
Rscript -e '
  library(RColorBrewer)
  library(dplyr)
  library(tm)
  library(wordcloud)
  options(width=110);
  ceuadmin <- Sys.getenv("CEUADMIN")
  wc <- function(modules,png)
  {
    print(length(modules))
    docs <- Corpus(VectorSource(modules))
    m <- TermDocumentMatrix(docs) %>%
         as.matrix()
    words <- sort(rowSums(m),decreasing=TRUE)
    freq <- rpois(length(words),lambda=3)
    png(png,,res=300,height=10,width=10,units="in")
    wordcloud(names(words), freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
    dev.off()
  }
  set.seed(1234321)
  generic <- scan("generic.lst",what="")
  genetics <- scan("genetics.lst",what="")
  wc(generic,"generic.png")
  wc(genetics,"genetics.png")
  unlink(c("generic.lst","genetics.lst"))
  modules <- setdiff(dir(ceuadmin),c("doc","lib","misc","sources","generic.png","genetics.png"))
  wc(modules,"ceuadmin.png")
  print(modules)
'
```


---

[^ls]: **ls**

    A larger collection of packages is deposited at /rds/project/jmmh2.

[^gui]: **GUI**

    As GUI-based programs claim more computing resources, it is recommended that they are only used occasionally, e.g., calling back GitHub sessions.

[^metal]: **metal**

    Notes on METAL 2020-05-05r

    This version has options EFFECT_PRINT_PRECISION and STDERR_PRINT_PRECISION (both with default 4) to enable many decimal places.

    The letter `r` as in `2020-05-05r` indicates a replacement of functions in `libsrc/MathStats.cpp` to ensure generality -- [details](http://numerical.recipes/forum/attachment.php?attachmentid=60&d=1190409664) have also been posted to the GitHub page, [https://github.com/statgen/METAL/issues/24](https://github.com/statgen/METAL/issues/24).

    ```
    FATAL ERROR -
    a too large, ITMAX too small in gamma countinued fraction (gcf)

    so the -1.info file could not be generated.
    ```

[^gemma]: **gema**

    Note on compiling from source

    A considerably smaller (1,097,256 vs 22,721,624) executable, /usr/local/Cluster-Apps/ceuadmin/GEMMA/0.98.5/bin, is generated under CSD3 but the original distribution is used by default.

    ```bash
    module load openblas/0.2.15
    make
    ```

[^fcgene]: **fcgene**

    Alternative site

    See [https://github.com/dr-roshyara/fcgene](https://github.com/dr-roshyara/fcgene)

[^jq]: **jq**

    The executable points to the one available from the website.

    The bin/, include/, lib/, share/ directories are obtained from source with oniguruma also compiled independently.

[^qtltools]: **qtltools**

    The long version number is 1.3.1-25-g6e49f85f20.

[^exiv2]: **exiv2**

    This is compiled with configuration

    ```bash
    cmake -DCMAKE_INSTALL_PREFIX=$CEUADMIN/exiv/0.27.5 -DEXIV2_ENABLE_NLS=On -DEXIV2_ENABLE_BMFF=On -DEXIV2_BUILD_UNIT_TESTS=Off -DCMAKE_PREFIX_PATH=$HPC_WORK ..
    ```

    The modules ceuadmin/gettext/0.21, ceuadmin/libiconv/1.17, ceuadmin/googletest/1.8.0 are at disposal.

[^libxslt]: **libxslt**

    There is complaint about docbook as in expat, however there is no apparent option to control for this.

[^libxml2]: **libxml2**

    The packaging is not perfect and Python 2 package requires to be manually furnished,

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

[^gdal]: **gdal**

    This involves many libraries; an expeeriment has been done as follows,

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
    # --with-proj=/usr/local/software/spack/spack-git/opt/spack/linux-rhel7-broadwell/gcc-5.4.0/proj-6.2.0-iw4jbzsrjirypecjm4c7bmlhdvhgwjmx \
    ```

[^expat]: **expat**

    Due to error messages, the options are specified as follows,

    ```bash
    ./configure --prefix=$CEUADMIN/expat/2.4.7 --without-docbook
    ```

[^libgit2]: **libgit2**

    It uses Python 2.7 and libssh2 (as above). The following warnings are given

    ```
    /usr/bin/ld: warning: libssl.so.10, needed by /home/jhz22/hpc-work/lib/libssh2.so, may conflict with libssl.so.1.1
    /usr/bin/ld: warning: libcrypto.so.10, needed by /home/jhz22/hpc-work/lib/libssh2.so, may conflict with libcrypto.so.1.1
    ```

[^nettle]: **nettle**

    This is required by gnutls/3.7.8, which requires `ceuadmin/gmp/6.2.1` and `--enable-mini-gmp`.

    Alternatively, we use

    ```bash
    ./configure --prefix=$HPC_WORK LDFLAGS=-L$HPC_WORK/lib64 LIBS=-lhogweed --disable-openssl \
                --with-lib-path=/usr/local/Cluster-Apps/ceuadmin/gmp/6.2.1/lib \
                --with-include-path=/usr/local/Cluster-Apps/ceuadmin/gmp/6.2.1/include
    ```

[^gnutls]: **gnutls**

    It requires libunistring (optionally --with-included-unistring), libidn2, libunbound, and trousers, all prepared above.

    ```bash
    ./configure --prefix=$HPC_WORK --with-included-unistring --with-nettle-mini --enable-ssl3-support \
                CFLAGS=-I$HPC_WORK/include LDFLAGS=-L$HPC_WORK/lib LIBS=-lhogweed LIBS=-lunbound LIBS=-ltspi \
                --enable-sha1-support --disable-guile
    ```

    It is necessary to edit `lib/pkcs11_privkey.c` to make `ck_rsa_pkcs_pss_params` definition explicit. Then there is error with guile so we use --disable-guile.

[^lemma]: **lemma**

    The documentation indicates a requirement of gcc/9.4, boost/1.78, OpenMP/3.1 and/or Intel MKL Library 2019 Update 1 but it is possible to proceed with gcc/11, cmake-3.19.7-gcc-5.4-5gbsejo, boost-1.66.0-gcc-5.4.0-slpq3un, ceuadmin/bgen.

[^axel]: The following scripts avoid option `--without-ssl`.

    ```bash
     wget -qO- https://github.com/axel-download-accelerator/axel/releases/download/v2.17.11/axel-2.17.11.tar.gz | \
     tar xvfz -
     cd axel-2.17.11
    ./configure --prefix=$CEUADMIN/axel/2.17.11  LDFLAGS=-L/usr/lib64 LIBS=-lssl
    ```

[^OpenMS]: **OpenMS**

    When the OpenMS module is loaded, pyopenms and alphapept also become available.

[^lz]: **locuszoom**

    The version adds chromosome X data and will have options using INTERVAL data.

[^rstudio]: **rstudio**

    This is replacement of the module by HPC (no longer working) with the RStudio itself unchanged.

    To save space, 2023.06.1+524 is removed upon installation of 2023.12.1+402.

[^pwcoco]: **pwcoco**

    It compiles under gcc/9. Upon release of 1.1, this snapshot is removed.

[^regenie]: **regenie**

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

[^autoconf]: **autoconf**

    ```bash
    git clone git://git.sv.gnu.org/autoconf
    cd autoconf/
    ./bootstrap
    module load help2man-1.47.4-gcc-4.8.5-phopsy7
    ./configure --prefix=/home/jhz22/rds/public_databases/software
    moke
    make install
    ```

[^quarto]: **quarto**

    It requires CentOS 8 (icelake, or login-q-\*); otherwise it fails with message: `GLIBC_2.18` not found.

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

[^xpdf]: **xpdf**

    To enable display fonts as in login-e-[1-4] in /etc/xpdfrc or ~/.xpdfrc

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

[^pspp]: **pspp**

    Makeinfo

    The following replacement is used.

    ```
    MAKEINFO = ${SHELL} '/rds/project/jmmh2/rds-jmmh2-public_databases/software/pspp-2.0.0-pre1ge32bec/build-aux/missing' makeinfo --force --no-validate
    ```

    while the rest is copied from GNU build, <https://benpfaff.org/~blp/pspp-master/20230624103130/x86_64/pspp-2.0.0-pre1ge32bec-x86_64-build20230624103419.tar.gz>.

[^ncbi-vdb]: **ncbi-vdb**

    The installation is preceeded with `module load gcc/6 flex-2.6.4-gcc-5.4.0-2u2fgon`. Although `configure` is provided, `cmake` is used instead.

    ```bash
    cmake -DCMAKE_PREFIX_PATH=$CEUADMIN/ncbi-vdb/3.0.8 -DCMAKE_INSTALL_PREFIX=$CEUADMIN/ncbi-vdb/3.0.8 ..
    ```

[^sra-tools]: **sra-tools**

    First, create a symbolic link for `ncbi-vdb/3.0.8` in the parent directory.

    ```bash
    cmake -DVDB_LIBDIR=$CEUADMIN/ncbi-vdb/3.0.8/lib64 -DCMAKE_INSTALL_PREFIX=$CEUADMIN/sra-tools/3.0.8 ..
    ```

    Drop `constexpr` as in `constexpr size_type max_size() const { return SIZE_MAX; }` in line 161 of the following header file:

    `/usr/local/Cluster-Apps/ceuadmin/sra-tools/3.0.8/tools/external/driver-tool/util.hpp`.

[^gatk]: **gatk**

    The Python dependencies are set up as follows,

    ```bash
    module load anaconda/3.2019-10
    conda env create -p /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10 -f gatkcondaenv.yml
    conda activate /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10
    ```

    Workflow downloads: <https://github.com/gatk-workflows>

[^gdc]: **gdc**

    It also includes gdc_dtt-ui 1.0.0

[^VB2]: **VB2**

    To build from source, module `htslib-1.9-gcc-5.4.0-p2taavl` is needed yet with message `/usr/bin/ld: warning: libbz2.so.1.0, needed by /usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/htslib-1.9-p2taavlu3ieppo25otjfgvfu5tysbgho/lib/libhts.so, may conflict with libbz2.so.1`. In fact, 1 == 1.0 so it is ignored.

[^regtools]: **regtools**

    gcc/6 is required for C++11.

[^varscan]: **varscan**

    Simply call `java -jar $VARSCAN_HOME/VarScan.v2.4.6.jar` after `module load ceuadmin/VarScan/2.4.6`.

[^tatami]: **tatami**

    The following aspects are required.

    1. module load gcc/9
    2. mkdir build && cd build
    3. cmake .. -DCMAKE_INSTALL_PREFIX=$CEUADMIN/tatami/2.1.2
    4. cmake --build . --target install

[^nextflow]: **nextflow**

    ```bash
    curl -fsSL get.nextflow.io | bash
    ```

[^singularity]: **singularity**

    ```bash
    mconfig --prefix=$CEUADMIN/singularity/4.0.3 --without-seccomp --without-conmon --without-suid
    cd builddir & make
    ```

[^fraposa]: **fraposa**

    Several packages, including poetry, poetry-plugin-export and fraposa_pgsc, will be installed as follows,

    ```bash
    module load ceuadmin/Anaconda3/2023.09-0
    pip install poetry
    pip3 install poetry-plugin-export
    pip install --use-feature=fast-deps .
    scripts/run_example.sh
    ```

    This is necessay since by default `peotry install` will use user's home directory. As indicated from `poetry install --help`:

    The install command reads the poetry.lock file from
    the current directory, processes it, and downloads and installs all the
    libraries and dependencies outlined in that file. If the file does not
    exist it will look for pyproject.toml and do the same.

[^pgsc_calc]: **pgsc_calc**

    Application, <https://pgsc-calc.readthedocs.io/en/latest/index.html>

    ```bash
    nextflow run pgscatalog/pgsc_calc -profile test,singularity
    ```

    It appears quarto is called so presumably under icelake.

[^deno]: **deno**

    Web: <https://anaconda.org/conda-forge/deno/files>

    ```bash
    wget https://anaconda.org/conda-forge/deno/1.40.2/download/linux-64/deno-1.40.2-hfc7925d_0.conda -O deno.conda
    unzip deno.conda
    tar --use-compress-program=unzstd -xvf pkg-deno-1.40.2-hfc7925d_0.tar.zst
    ```

[^R]: **R**

    This replaces R/4.3.2. It is also R/latest.

[^gitkraken]: **GitKraken**

    This replaces 8.1.0.

[^automake]: **automake**

    This is required by pspp 2.0.0.

[^openssl]: **openssl**

    ```bash
    wget -qO- https://www.openssl.org/source/openssl-3.2.1.tar.gz | \
    tar xvfz -
    cd openssl-3.2.1/
    export PERL5LIB=
    ./Configure --prefix=$CEUADMIN/openssl/3.2.1-icelake
    make
    make install
    ```

[^openssh]: **openssh**

    OpenSSL is called first to use the specific `openssl`, i.e.,

    ```bash
    module load ceuadmin/openssl/3.2.1-icelake
    ./configure --prefix=$CEUADMIN/openssh/9.7p1-icelake --with-ssl-dir=$CEUADMIN/openssl/3.2.1-icelake
    make
    make install
    ```

    Check is made with `cat config.log | grep -i openssl`.
