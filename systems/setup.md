---
sort: 17
mathjax: true
---

# Setup of modules

- Location at CSD3: **/usr/local/Cluster-Apps/ceuadmin** (CEUADMIN)
- Module files: **/usr/local/Cluster-Config/modulefiles/ceuadmin** (CEUMODULES)

## Recent modules

All entries are ordered chronologically.

| Date       | Add ons                          | Category              |
| :--------- | :------------------------------- | :-------------------- |
| 2022-10-21 | pspp/1.6.0                       | Generic               |
| 2022-10-22 | snptest/2.5.6                    | Genetics              |
| ""         | qctool/2.0.8                     | Genetics              |
| ""         | gcta/1.94.1                      | Genetics              |
| ""         | KING/2.1.6                       | Genetics              |
| ""         | LDstore/2.0                      | Genetics              |
| ""         | shapeit/3                        | Genetics              |
| ""         | vcftools/0.1.16                  | Genetics              |
| ""         | finemap/1.4                      | Genetics              |
| 2022-10-23 | quicktest/1.1                    | Genetics              |
| ""         | samtools/1.11                    | Genetics              |
| ""         | bcftools/1.12                    | Genetics              |
| ""         | MORGAN/3.4                       | Genetics              |
| ""         | METAL/2020-05-05r                | Genetics[^metal]      |
| ""         | regenie/3.2.1                    | Genetics              |
| ""         | GEMMA/0.98.5                     | Genetics[^gemma]      |
| ""         | htslib/1.12                      | Genetics              |
| ""         | fcGENE/1.0.7                     | Genetics[^fcgene]     |
| ""         | SMR/1.0.3                        | Genetics              |
| ""         | FastQTL/2.165                    | Genetics              |
| ""         | GitKraken/8.1.0                  | Generic               |
| 2022-10-24 | Typora/0.11.8beta                | Generic               |
| ""         | pandoc/2.19.2                    | Generic               |
| ""         | citeproc/0.4.0.1                 | Generic               |
| ""         | citeproc/0.8.0.2                 | Generic               |
| 2022-10-26 | circos/0.69-9                    | Genetics              |
| ""         | DjVuLibre/3.5.27.1-14            | Generic               |
| ""         | ghostscript/9.56.1               | Generic[^gs]          |
| ""         | bgen/1.1.7                       | Genetics              |
| 2022-10-27 | sqlite/3.39.4                    | Generic               |
| 2022-10-28 | poppler/0.84.0                   | Generic               |
| ""         | jq/1.6                           | Generic[^jq]          |
| ""         | DosageConverter/1.0.0            | Genetics              |
| ""         | tidy/5.8.0                       | Generic               |
| 2022-10-29 | ghc/8.6.5                        | Generic               |
| ""         | pandoc-citeproc/0.17.0.2         | Generic               |
| 2022-10-31 | git/2.38.1                       | Generic               |
| ""         | aria2/1.36.0                     | Generic               |
| 2022-11-01 | alpine/2.26                      | Generic               |
| ""         | readline/8.0                     | Generic               |
| ""         | Cytoscape/3.9.1                  | Generic               |
| ""         | nano/6.0                         | Generic               |
| ""         | R/4.2.2                          | Generic               |
| ""         | parallel/20220222                | Generic               |
| ""         | pdf2djvu/0.9.19                  | Generic               |
| 2022-11-02 | lapack/3.10.1                    | Generic               |
| ""         | GraphicsMagick/1.3.38            | Generic               |
| ""         | QTLtools/1.3.1-25                | Genetics[^qtltools]   |
| ""         | NLopt/2.7.1                      | Generic               |
| ""         | blat/37x1                        | Genetics              |
| ""         | bedtools2/2.29.2                 | Genetics              |
| ""         | bedops/2.4.41                    | Genetics              |
| 2022-11-03 | Beagle/3.0.4                     | Genetics              |
| ""         | netbeans/15                      | Generic               |
| ""         | JAGS/4.3.1                       | Generic               |
| ""         | exiv2/0.27.5                     | Generic[^exiv2]       |
| ""         | googletest/1.8.0                 | Generic               |
| ""         | googletest/1.12.1                | Generic               |
| ""         | libiconv/1.17                    | Generic               |
| ""         | ldc2/1.24.0                      | Generic               |
| ""         | gettext/0.21                     | Generic               |
| ""         | ssw/0.7                          | Generic               |
| ""         | fribidi/1.0.8                    | Generic               |
| ""         | proj/6.3.0                       | Generic               |
| ""         | gmp/6.2.1                        | Generic               |
| ""         | pcre2/10.30                      | Generic               |
| ""         | zstd/1.5.2                       | Generic               |
| 2022-11-04 | libxslt/1.1.34                   | Generic[^libxslt]     |
| ""         | libssh2/1.10.0                   | Generic               |
| ""         | libxml2/2.9.10                   | Generic[^libxml2]     |
| ""         | libsodium/1.10.0                 | Generic               |
| ""         | gdal/3.0.4                       | Generic[^gdal]        |
| ""         | expat/2.4.7                      | Generic[^expat]       |
| ""         | docbook2X/0.8.8                  | Generic               |
| ""         | libntlm/1.6                      | Generic               |
| ""         | vala/0.46.5                      | Generic               |
| ""         | gtksourceview/4.0.3              | Generic               |
| ""         | oniguruma/6.9.8                  | Generic               |
| ""         | nspr/4.35                        | Generic               |
| ""         | nettle/2.7.1                     | Generic               |
| 2022-11-05 | trinculo/0.96                    | Generic               |
| ""         | ruby/2.7.5                       | Generic[^ruby]        |
| 2022-11-06 | libpng/0.5.30                    | Generic               |
| ""         | libgit2/1.1.0                    | Generic[^libgit2]     |
| ""         | git-extras/6.5.0                 | Generic               |
| ""         | trousers/0.3.14                  | Generic               |
| ""         | libidn2/2.3.4                    | Generic               |
| ""         | unbound/1.17.0                   | Generic               |
| ""         | nettle/3.6.0                     | Generic[^nettle]      |
| ""         | gnutls/3.7.8                     | Generic[^gnutls]      |
| 2022-11-08 | CrossMap/0.6.4                   | Genetics              |
| ""         | SurvivalKit/6.12                 | Genetics              |
| ""         | PRSice/2.3.3                     | Genetics              |
| 2022-11-09 | qctool/2.2.0                     | Genetics              |
| ""         | fossil/2.19                      | Generic               |
| 2022-11-10 | rclone/1.53.1                    | Generic               |
| ""         | CaVEMaN/1.01-c1815a0             | Genetics              |
| ""         | akt/0.3.3                        | Genetics              |
| ""         | MsCAVIAR/0.6.4                   | Genetics              |
| ""         | CAVIAR/2.2                       | Genetics              |
| ""         | MONSTER/1.3                      | Genetics              |
| ""         | osca/0.46                        | Genetics              |
| ""         | LEMMA/1.0.4                      | Genetics[^lemma]      |
| ""         | CAVIARBF/0.2.1                   | Genetics              |
| 2022-11-11 | PAINTOR/3.0                      | Genetics              |
| ""         | ABCtoolbox/2.0                   | Generic               |
| ""         | cppunit/1.15.2                   | Generic               |
| 2022-11-12 | ccal/2.5.3                       | Generic               |
| 2022-11-13 | axel/2.17.11                     | Generic[^axel]        |
| ""         | axel/1.0a                        | Generic               |
| ""         | bazel/2.0.0                      | Generic               |
| ""         | bazel/1.2.1                      | Generic               |
| 2022-11-14 | MR-MEGA/0.2                      | Genetics              |
| 2022-11-16 | SNP2HLA/1.0.3                    | Genetics              |
| ""         | STAR/2.7.10b                     | Genetics              |
| ""         | Mega2/6.0.0                      | Genetics              |
| 2022-11-18 | ffmpeg/5.1.1                     | Generic               |
| 2022-11-19 | ensembl-vep/104                  | Genetics\*            |
| ""         | OpenMS/3.0.0-pre-develop         | Genetics\*[^OpenMS]   |
| ""         | polyphen/2.2.2                   | Genetics\*            |
| ""         | ANNOVAR/24Oct2019                | Genetics\*            |
| ""         | MAGENTA/vs2_July2011             | Genetics\*            |
| ""         | GARFIELD/v2                      | Genetics\*            |
| ""         | KentUtils/2022-11-14             | Genetics\*            |
| 2022-11-20 | Genotype-Harmonizer/1.4.25       | Genetics              |
| 2022-11-21 | locuszoom/1.4                    | Genetics\*[^lz]       |
| ""         | DEPICT/v1_rel194                 | Genetics\*            |
| ""         | MAGMA/1.10                       | Genetics\*            |
| ""         | Pascal/v_debut                   | Genetics\*            |
| ""         | VEGAS2/2.01.17                   | Genetics\*            |
| ""         | fgwas/0.3.6                      | Genetics\*            |
| 2022-11-24 | qtcreator/2.5.2                  | Generic               |
| ""         | rstudio/2022.07.2+576            | Generic               |
| 2022-11-26 | yaml-cpp/0.7.0                   | Generic               |
| ""         | libglvnd/1.6.0                   | Generic               |
| ""         | GreenAlgorithmsforHPC/0.2.2-beta | Generic               |
| 2022-11-28 | openssl/1.1.1s                   | Generic               |
| 2022-11-29 | qt/5.15.7                        | Generic\*             |
| 2022-12-02 | rstudio/1.3.1093                 | Generic[^rstudio]     |
| 2022-12-04 | phenoscanner/v2                  | Genetics\*            |
| 2022-12-07 | SurvivalAnalysis/2016-05-09      | Genetics              |
| 2022-12-14 | node/16.14.0                     | Generic               |
| 2022-12-19 | rstudio/2022.12.0+353            | Generic               |
| ""         | icu/50.2                         | Generic               |
| 2022-12-20 | snakemake/7.19.1                 | Generic               |
| 2022-12-21 | icu/70.1                         | Generic               |
| ""         | libuv/1.43.0                     | Generic               |
| ""         | libcares/1.18.1                  | Generic               |
| ""         | brotli/1.0.9                     | Generic               |
| 2022-12-28 | ncurses/6.3                      | Generic               |
| 2023-01-03 | Eagle/2.4.1                      | Genetics              |
| 2023-01-05 | GEM/1.4.5                        | Genetics              |
| 2023-02-01 | GENEHUNTER/2.1_r6                | Genetics              |
| 2023-02-26 | JabRef/5.9                       | Generic               |
| 2023-02-27 | Zotero/6.0.22                    | Generic               |
| 2023-03-14 | regenie/3.2.5                    | Genetics              |
| 2023-03-22 | rstudio/2023.03.0+386            | Generic               |
| 2023-03-24 | PoGo/1.0.0                       | Genetics              |
| 2023-03-31 | PWCoCo/2023-03-31                | Genetics[^pwcoco]     |
| 2023-04-02 | regenie/3.2.5.3                  | Genetics              |
| 2023-04-04 | PWCoCo/1.0                       | Genetics              |
| 2023-04-05 | PhySO/1.0-dev0                   | Generic               |
| 2023-04-21 | ImageJ/1.53t                     | Generic               |
| 2023-04-25 | busybox/1.35.0                   | Generic               |
| 2023-06-02 | regenie/3.2.7                    | Genetics[^regenie]    |
| 2023-06-05 | gsl/2.7.1                        | Generic               |
| 2023-06-06 | allegre/2.0f                     | Genetics              |
| 2023-06-14 | autoconf/2.72c.24-8e728          | Generic[^autoconf]    |
| 2023-06-16 | globusconnectpersonal/3.2.2      | Generic               |
| 2023-06-19 | plink-ng/2.00a3.3                | Genetics              |
| 2023-06-26 | RHHsoftware/0.1                  | Genetics              |
| 2023-07-19 | pdfjam/3.06                      | Generic               |
| 2023-07-22 | rstudio/2023.06.1+524            | Generic               |
| 2023-07-28 | PWCoCo/1.1                       | Genetics              |
| 2023-08-02 | regenie/3.2.9                    | Genetics              |
| ""         | fossil/2.22                      | Generic               |
| 2023-08-04 | quarto/1.3.450-icelake           | Generic[^quarto]      |
| 2023-08-06 | finemap/1.4.2                    | Genetics              |
| 2023-08-10 | GreenAlgorithmsforHPC/0.3        | Generic               |
| 2023-08-12 | xpdf/4.04                        | Generic[^xpdf]        |
| 2023-08-22 | thunderbird/115.1.1              | Generic               |
| 2023-08-24 | pdfjam/3.07                      | Generic               |
| 2023-09-03 | 2.0.0-pre1ge32bec                | Genetic[^pspp]        |
| ""         | spead-sheet-widget               | Generic               |
| 2023-09-27 | ncbi-vdb/3.0.8                   | Genetics[^ncbi-vdb]   |
| ""         | sra-tools/3.0.8                  | Genetics[^sra-tools]  |
| ""         | gatk/4.4.0.0                     | Genetics[^gatk]       |
| 2023-09-28 | openjdk/8u382-b05                | Generic               |
| ""         | openjdk/11.0.20+8                | Generic               |
| ""         | openjdk/17.0.8+7                 | Generic               |
| 2023-10-24 | rst2pdf/0.101                    | Generic               |
| ""         | geany/1.38                       | Generic               |
| ""         | pango/1.41.1                     | Generic               |
| ""         | gettext/0.20                     | Generic               |
| 2023-10-26 | glib/2.58.3                      | Generic               |
| 2023-10-27 | graphene/1.4.0                   | Generic               |
| ""         | graphene/1.8.0                   | Generic               |
| 2023-10-24 | gtk+/3.24.0                      | Generic               |
| ""         | geany/2.0                        | Generic               |
| 2023-10-28 | hunspell/1.7.0                   | Generic               |
| ""         | hunspell/1.7.2                   | Generic               |
| ""         | enchant/2.2.0                    | Generic               |
| 2023-10-29 | gtk+/3.90.0                      | Generic               |
| 2023-10-31 | vte/0.55.0                       | Generic               |
| 2023-11-05 | Anaconda3/2023.09-0              | Generic               |
| 2023-11-23 | SciKit-LLM & OpenAI API          | Genetic               |
| 2023-11-24 | ldsc/1.0.1                       | Genetics              |
| 2023-11-30 | gdc/1.6.1-1.0.0                  | Genetics[^gdc]        |
| 2023-12-13 | rust/1.74.1                      | Generic               |
| 2023-12-20 | verifyBamID/1.1.3                | Genetics              |
| 2023-12-21 | verifyBamID/2.0.1                | Genetics[^VB2]        |
| 2023-12-27 | regtools/1.0.0                   | Genetics[^regtools]   |
| ""         | VarScan/2.4.6                    | Genetics[^varscan]    |
| 2024-01-02 | Mango/0.1.0                      | Generic               |
| 2024-01-08 | picard/3.1.1                     | Genetics              |
| ""         | plink/2.0_20240105               | Genetics              |
| 2024-01-10 | cmake/3.28.1                     | Generic               |
| ""         | tatami/2.1.2                     | Generic[^tatami]      |
| 2024-01-19 | htslib/1.19                      | Genetics              |
| 2024-01-23 | nextflow/23.10.1                 | Generic[^nextflow]    |
| ""         | go/1.21.6                        | Generic               |
| ""         | singularity/4.0.3                | Generic[^singularity] |
| ""         | libseccomp/2.5.5                 | Generic               |
| 2024-01-24 | fraposa_pgsc/0.1.0               | Genetics[^fraposa]    |
| ""         | pgsc_calc/2.0.0-alpha.4          | Genetics[^pgsc_calc]  |
| 2024-01-27 | glibc/2.18                       | Generic               |
| ""         | glibc/2.26                       | Generic               |
| ""         | deno/1.40.2                      | Generic[^deno]        |
| ""         | deno/1.40.2-icelake              | Generic               |
| ""         | quarto/1.4.549                   | Generic               |
| 2024-02-29 | R/4.3.3                          | Generic[^R]           |
| 2024-03-01 | glpk/5.0                         | Generic               |
| 2024-03-02 | glpk/4.57                        | Generic               |
| 2024-03-04 | rstudio/2023.12.1-402            | Generic               |
| 2024-03-05 | GitKraken/9.12.0                 | Generic[^gitkraken]   |
| ""         | automake/1.16.5                  | Generic[^automake]    |
| ""         | pspp/2.0.0                       | Generic               |
| 2024-03-09 | Scala/3.3.3                      | Generic               |
| 2024-03-10 | fpc/3.2.2                        | Generic               |
| ""         | Swift/5.10                       | Generic               |
| ""         | pulsar/1.114.0                   | Generic               |
| ""         | VSCodium/1.87.1.24068            | Generic               |
| 2024-03-27 | openssl/3.2.1-icelake            | Generic[^openssl]     |
| ""         | openssh/9.7p1-icelake            | Generic[^openssh]     |
| 2024-03-31 | ensembl-vep/111-icelake          | Genetics[^vep]        |
| 2024-04-01 | json-c/0.17-20230812-icelake     | Generic[^json-c]      |
| ""         | device-mapper/1.02.28-icelake    | Generic               |
| ""         | LVM2/2.03.23-icelake             | Generic[^LVM2]        |
| 2024-04-02 | cryptsetup/2.7.1-icelake         | Generic[^cryptsetup]  |
| 2024-04-05 | krb5/1.21.2-icelake              | Generic[^krb5]        |
| ""         | git/1.44.0-icelake               | Generic[^git]         |
| ""         | openssl/1.1.1b-icelake           | Generic               |
| ""         | libssh2/1.11.0-icelake           | Generic               |
| ""         | libssh/0.10.6-icelake            | Generic               |
| 2024-04-22 | peer/1.3                         | Generic[^peer]        |
| 2024-04-29 | ImageMagick/7.1.1-31             | Generic[^ImageMagick] |
| 2024-05-15 | rtmpdump/2.3                     | Generic[^rtmpdump]    |
| 2024-05-22 | spyder/5.5.4                     | Generic[^spyder]      |
| 2024-06-04 | pwiz/3_0_24156_80747de           | Proteomics            |
| 2024-06-09 | crux/4.2                         | Proteomics[^crux]     |
| ""         | p7zip-zstd/17.05                 | Generic[^p7zip_zstd]  |
| ""         | DIA-NN/1.8.1                     | Proteomics            |
| 2024-06-10 | patchelf/0.18.0                  | Generic               |
| ""         | boost/1.76.0                     | Generic[^boost]       |
| ""         | wine/8.21                        | Generic[^wine]        |
| 2024-06-11 | crux/4.1                         | Proteomics            |
| ""         | pwiz/3_0_24163_9bfa69a-wine      | Proteomics            |
| 2024-06-13 | seqkit/2.8.2                     | Proteomics[^seqkit]   |
| ""         | dotnet/8.0.304                   | Generic               |
| ""         | dotnet/6.0.423                   | Generic[^dotnet]      |
| ""         | FlashLFQ/1.2.6                   | Proteomics[^FlashLFQ] |
| ""         | MetaMorpheus/1.0.5               | Proteomics            |
| 2024-06-14 | R/4.4.1                          | Generic               |
| 2024-06-25 | msms/3.2rc-b163                  | Genetics              |
| 2024-06-30 | freesurfer/7.4.1                 | Generic               |
| 2024-07-04 | docker/24.0.5                    | Generic[^docker]      |
| ""         | docker/27.0.3                    | Generic               |
| 2024-07-05 | sshpass/1.10                     | Generic               |
| ""         | podman/5.1.1                     | Generic[^podman]      |
| 2024-07-09 | ntlm/1.6                         | Generic               |
| ""         | alpine/2.26-icelake              | Generic[^alpine]      |
| ""         | gnutls/3.8.4-icelake             | Generic               |
| ""         | quarto/1.6.1-icelake             | Generic               |
| ""         | gettext/0.22.5-icelake           | Generic               |
| ""         | nettle/3.9-icelake               | Generic               |
| 2024-07-11 | qemu/9.0.1                       | Generic[^qemu]        |
| 2024-07-13 | msamanda/3.0.21.532              | Proteomics            |
| 2024-07-16 | augeas/1.14.1                    | Generic               |
| ""         | hivex/1.3.23                     | Generic[^hivex]       |
| ""         | ocaml/4.14.2                     | Generic               |
| ""         | findlib/1.9.6                    | Generic[^findlib]     |
| ""         | opam/2.2.0                       | Generic[^opam]        |
| ""         | libguestfs/1.48.6                | Generic[^libguestfs]  |
| 2024-07-23 | Miniconda3/22.9.0                | Generic               |
| 2024-07-25 | pigz/2.8                         | Generic               |
| 2024-07-31 | tandem/2017.2.1.4                | Proteomics            |
| 2024-08-11 | comet/2024.01.1                  | Proteomics            |
| ""         | kojak/2.1.0                      | Proteomics            |
| ""         | kojak/1.5.5                      | Proteomics            |
| ""         | kojak/2.0.0a22                   | Proteomics            |
| 2024-08-12 | MS-GF+/2024.03.26                | Proteomics[^msgf]     |
| 2024-08-14 | ThermoRawFileParser/1.4.4        | Proteomics            |
| ""         | ThermoRawFileParserGUI/1.7.4     | Proteomics            |
| ""         | FragPipe/22.0                    | Proteomics[^fragpipe] |
| 2024-08-15 | MSFragger/4.1                    | Proteomics            |
| ""         | IonQuant/1.10.27                 | Proteomics            |
| 2024-08-20 | htslib/1.20                      | Genetics              |
| ""         | bcftools/1.20                    | Genetics              |
| ""         | samtools/1.20                    | Genetics              |
| 2024-08-23 | qpdf/11.9.1                      | Generic               |
| 2024-08-23 | qpdf/11.9.1                      | Generic               |
| 2024-09-01 | MaxQuant/2.6.4.0                 | Proteomics            |
| ""         | Perseus/2.1.2.0                  | Proteomics            |
| 2024-09-03 | tiff/4.0.4                       | Generic               |
| ""         | tiff/4.6.0                       | Generic               |
| 2024-09-05 | libgit2/1.4.2                    | Generic               |
| 2024-09-10 | jasper/4.2.4                     | Generic[^jasper]      |
| 2024-09-13 | geos/3.8.4                       | Generic               |
| ""         | prof/7.2.1                       | Generic               |
| 2024-09-14 | libarchive/3.7.5                 | Generic               |
| ""         | openssl/3.2.1                    | Generic               |
| ""         | curl/7.85.0                      | Generic[^curl]        |
| 2024-09-15 | libjpeg-turbo/3.0.4              | Genetic[^libjpeg]     |
| ""         | libgeotiff/1.7.3                 | Generic[^libgeotiff]  |
| ""         | gdal/3.7.0                       | Generic[^gdal370]     |
| 2024-10-04 | libsodium/1.0.20                 | Genetic               |
| ""         | SYMPHONY/3.6.17                  | Generic               |
| 2024-10-13 | sage/0.14.7                      | Proteomics            |
| 2024-10-23 | caddy/2.7.5                      | Genetic               |
| ""         | caddy/2.8.4                      | Generic               |
| ""         | nginx/1.24.0                     | Generic               |
| ""         | wrk/4.2.0                        | Generic               |
| 2024-10-25 | firefox/131.0.3                  | Genetic               |
| ""         | chromium/132.0.6798.0            | Generic               |
| 2024-10-29 | inetutils/2.5                    | Genetic[^inetutils]   |
| 2024-10-31 | R/4.4.2                          | Generic               |
| 2024-11-01 | edge/130.0.2849.56-1             | Generic               |
| 2024-11-22 | pspp/2.0.1                       | Generic               |
| 2024-11-26 | pgsc_calc/2.0.0                  | Generic               |
| 2024-12-03 | firefox/133.0                    | Genetic               |
| 2024-12-07 | firefox/nightly                  | Genetic               |
| 2024-12-10 | rstudio/2024.09.1+394            | Genetic               |
| 2025-01-21 | node/18.20.5                     | Genetic[^node]        |
| 2025-01-26 | node/20.18.2                     | Generic               |
| ""         | chrome/132.0.6834.110            | Generic[^chrome]      |
| 2025-01-29 | brotli/1.1.0                     | Generic[^brotli]      |
| 2025-01-31 | rust/1.84.1                      | Generic[^rust]        |
| 2025-02-04 | quarto/1.7.13                    | Generic               |
| ""         | pandoc/3.6.2                     | Generic               |
| 2025-02-05 | rstudio/2025.04.0+278            | Genetic               |
| ""         | git/2.48.1                       | Generic[^git2481]     |
| ""         | libgcrypt/1.5.3                  | Generic[^libgcrypt]   |
| ""         | texinfo/7.2                      | Generic[^texinfo]     |
| 2025-02-24 | VSCode/1.97.2                    | Genetic               |
| 2025-02-26 | ollama/0.5.12                    | Genetic[^ollama]      |
| 2025-02-28 | R/4.4.3                          | Generic               |
| 2025-03-01 | leptonica/1.85.0                 | Generic               |
| ""         | tesseract/5.5.0                  | Generic[^tesseract]   |
| 2025-03-02 | apidog/latest                    | Generic[^apidog]      |
| 2025-03-03 | micromamba/2.0.5                 | Generic               |
| 2025-03-13 | DjVuLibre/3.5.28                 | Generic               |
| ""         | ollama/0.6.0                     | Generic               |
| 2025-03-16 | qt/6.8.2                         | Generic               |
| ""         | Anaconda3/2024.10-1              | Generic[^Anaconda3]   |
| 2025-03-17 | micromamba/2.0.7                 | Generic[^micromamba]  |
| ""         | binutils/2.44                    | Generic               |
| 2025-03-18 | OpenMS/3.4.0                     | Proteomics            |
| 2025-03-20 | ollama/0.6.2                     | Generic               |
| 2025-03-22 | diann/2.0.2                      | Proteomics[^diann]    |
| 2025-03-25 | firefox/60.5.1-1.el7             | Generic[^esr]         |
| 2025-03-26 | firefox/136.0                    | Generic               |
| 2025-03-29 | llama.cpp/b4991                  | Generic[^llama_cpp]   |
| 2025-04-05 | InstaNovo/1.1.1-GPU              | Proteomics[^insnovo]  |
| 2025-04-07 | scGPT/0.2.4                      | Single cell[^scGPT]   |
| ""         | scanpy/1.11.1                    | Single cell[^scanpy]  |
| 2025-04-11 | R/4.5.0                          | Generic               |
| ""         | llama.cpp/b5121                  | Generic               |
| 2025-04-12 | ollama/0.6.5                     | Generic               |
| 2025-04-15 | DrugAssist/latest                | Generic[^DrugAssist]  |
| 2025-04-16 | uv/0.6.14                        | Generic[^uv]          |
| ""         | InstaNovo/1.1.1                  | Proteomics            |
| ""         | diann/2.1.0                      | Proteomics            |
| 2025-04-17 | BitNet/b1.58-2B-4T               | Generic[^bitnet]      |
| 2025-04-19 | C2S-Scale/0.0.2                  | Single cell[^C2S]     |
| 2025-04-20 | VSCode/1.99.3                    | Generic               |
| 2025-04-23 | gcta/1.94.4                      | Genetics              |
| 2025-04-24 | cbindgen/0.28.0                  | Generic[^mozbuild]    |
| ""         | clang/19.1.7                     | Generic               |
| ""         | dump_syms/2.3.4                  | Generic               |
| ""         | nasm/2.16.03                     | Generic               |
| ""         | node/18.19.0                     | Generic               |
| ""         | pkg-config/1.8.0                 | Generic               |
| 2025-04-29 | AnythingLLMDesktop/latest        | Generic               |
| 2025-05-02 | llama.cpp/b5259                  | Generic               |
| 2025-05-03 | GENIE/1.1.1                      | Genetics[^genie]      |
| 2025-05-05 | ollama/0.6.8                     | Generic               |
| 2025-05-06 | SuSiEx/1.1.2                     | Genetics              |
| 2025-05-07 | Synapse/4.8.0                    | Generic               |
| ""         | llama.cpp/b5305                  | Generic               |
| 2025-05-09 | PGS-CSx/1.1.0                    | Genetics[^pgs_csx]    |
| 2025-05-10 | VSCODE/1.100.0                   | Generic               |
| 2025-05-14 | RSEM/1.3.3                       | Genetics[^rsem]       |
| 2025-05-15 | BWA/0.7.19                       | Genetics              |
| 2025-05-16 | ollama/0.7.0                     | Generic               |
| 2025-05-17 | VirtualBox/7.1-7.1.8_168469      | Generic[^virtualbox]  |
| 2025-05-18 | VSCODE/1.100.2                   | Generic               |
| 2025-05-19 | geany/2.0-icelake                | Generic               |
| 2025-05-20 | vdo/8.3.1.1                      | Generic[^vdo]         |
| 2025-05-22 | rust/nightly                     | Generic[^rust]        |
| ""         | edit/1.0.0                       | Generic[^edit]        |
| 2025-05-23 | Windsurf/1.6.5                   | Generic               |
| 2025-05-25 | ollama/0.7.1                     | Generic               |
| 2025-05-29 | sqlite/3.49.2                    | Generic[^sqlite]      |
| 2025-05-30 | ollama/0.9.0                     | Generic               |
| 2025-06-01 | llama.cpp/b5558                  | Generic[^llama_cpp]   |
| 2025-05-30 | ollama/0.9.0                     | Generic               |
| 2025-06-14 | edit/1.2.0                       | Generic               |
| ""         | VSCode/1.101.0                   | Generic               |
| ""         | R/4.5.1-icelake                  | Generic               |
| 2025-07-05 | Zettlr/3.5.1                     | Generic[^zettlr]      |
| 2025-07-14 | edlib/1.2.7                      | Genetics[^edlib]      |
| ""         | MUMmer/4.0.1                     | Genetics              |
| 2025-07-15 | SVanalyzer/0.36                  | Genetics[^svanalyzer] |
| 2025-07-16 | sniffles/2.2                     | Genetics[^sniffles]   |
| ""         | awscli/2.27.52                   | Generic[^awscli]      |
| ""         | SEQPower/1.1.0                   | Genetics[^seqpower]   |
| 2025-07-18 | truvari/5.3.0                    | Genetics[^truvari]    |
| 2025-07-19 | hap.py/0.3.15                    | Genetics[^happy]      |
| ""         | rtg-tools/3.13                   | Genetics[^rtg]        |
| 2025-08-01 | ollama/0.10.1                    | Generic               |
| ""         | llama.cpp/b6059                  | Generic               |
| ""         | fly/0.3.164                      | Generic[^fly]         |
| ""         | node/22.16.0                     | Generic               |
| 2025-08-03 | cli/2.76.2                       | Generic[^cli]         |
| 2025-08-05 | qctool/2.2.5                     | Genetics              |
| ""         | MToolBox/1.2.1                   | Genetics[^mtoolbox]   |
| 2025-08-08 | ollama/0.11.4                    | Generic               |
| ""         | VSCode/1.103.0                   | Genetic[^vscode]      |
| ""         | LLM/0.26                         | Genetic[^llm]         |
| ""         | llama.cpp/b6119                  | Genetic               |
| ""         | gsutil/5.35                      | Generic               |
| ""         | python/3.12.10                   | Generic               |
| 2025-08-10 | haplogrep/2.4.0                  | Genetics[^haplogrep]  |
| ""         | haplogrep/3.2.2                  | Genetics              |
| 2025-08-11 | flashpca/2.0                     | Genetics[^flashpca]   |
| 2025-08-13 | fNUMT/1.1                        | Genetics[^fnumt]      |
| ""         | NUMTFinder/0.5.5                 | Genetics              |
| ""         | simNGS/1.7                       | Genetics[^simngs]     |
| 2025-08-18 | Anaconda2/2.5.0                  | Generic               |
| ""         | impute5/1.2.0                    | Genetics              |
| ""         | shapeit5/5.1.1                   | Genetics              |
| 2025-08-20 | snakemake/9.9.0                  | Generic               |
| 2025-08-21 | miniforge3/25.3.1-0              | Generic[^miniforge3]  |
| ""         | snakemake/9.9.0-miniforge3       | Generic               |
| ""         | cmocka/1.1.5                     | Generic[^cmocka]      |
| ""         | scl-utils/2.0.3                  | Generic[^scl]         |
| 2025-08-22 | gcc-toolset/12                   | Generic[^gcc_toolset] |
| ""         | llama.cpp/b6243                  | Generic               |
| 2025-08-27 | ollama/0.11.7                    | Generic               |
| 2025-08-28 | Zettlr/3.6.0                     | Generic               |
| 2025-09-01 | selscan/2.1                      | Genetics[^selscan]    |
| ""         | angsd/0.940                      | Genetics[^angsd]      |
| 2025-09-03 | hapstat/3.0                      | Genetics[^hapstat]    |
| 2025-09-04 | relate/1.2.3                     | Genetics[^relate]     |
| ""         | clues2/github                    | Genetics[^clues2]     |
| 2025-09-05 | fsc2/2.8.0                       | Genetics[^fsc2]       |
| 2025-09-06 | jbig2enc/0.39                    | Generic[^jbig2enc]    |
| ""         | pngquant/3.0.3                   | Generic[^pngquant]    |
| 2025-09-09 | MitoScape/1.0                    | Generic[^mitoscape]   |
| 2025-09-11 | mity/2.0.1                       | Genetics[^mity]       |
| 2025-09-13 | VSCode/1.104.0                   | Genetic               |
| 2025-09-21 | ollama/0.12.0                    | Genetic               |
| 2025-09-22 | delphi/github                    | Generic[^delphi]      |
| 2025-09-23 | alsa-lib/1.2.14                  | Generic               |
| ""         | firefox/145.0a1                  | Generic               |
| 2025-09-27 | firefox/143.0.1                  | Generic               |
| 2025-10-01 | ollama/0.12.3                    | Generic               |
| ""         | llama.cpp/b6653                  | Generic               |
| 2025-10-02 | Windsurf/1.12.12                 | Generic               |
| 2025-10-04 | gcc/12.1.0                       | Generic[^gcc]         |
| 2025-10-06 | wasi-sdk/20.0                    | Generic[^wasi]        |
| 2025-10-07 | patchelf/0.18.0                  | Generic[^patchelf]    |
| 2025-10-10 | glibc/2.30-5                     | Generic[^glibc]       |
| 2025-10-17 | ollama/0.12.6                    | Generic[^ollama]      |
| 2025-10-23 | ccphylo/0.8.5                    | Genetics[^ccphylo]    |
| 2025-10-25 | postman/10.21.0                  | Generic[^postman]     |
| 2025-10-31 | R/4.5.2-icelake                  | Generic               |
| 2025-11-14 | llama.cpp/b7058                  | Generic               |
| 2025-11-20 | ollama/0.13.0                    | Generic[^ollama]      |
| 2025-12-11 | ollama/0.13.2                    | Generic[^ollama]      |
| ""         | fresh/0.1.39                     | Generic[^fresh]       |
| 2025-12-12 | fresh/0.1.42                     | Generic               |
| 2025-12-14 | fresh/0.1.44                     | Generic               |
| 2025-12-18 | firefox/146.0.1                  | Generic               |
| 2025-12-19 | firefox/148.0a1 (nightly)        | Generic               |
| ""         | fresh/0.1.55, 0.1.55r            | Generic               |
| 2025-12-21 | fresh/0.1.56-58                  | Generic               |
| 2025-12-23 | fresh/0.1.59                     | Generic               |
| 2025-12-26 | fresh/0.1.64                     | Generic               |
| 2025-12-27 | gemini-cli/0.22.4                | Generic[^gemini]      |
| 2025-12-28 | fresh/0.1.65                     | Generic               |
| 2025-12-29 | gcloud/550.0.0                   | Generic[^gcloud]      |
| 2025-12-30 | fresh/0.1.67                     | Generic               |
| 2026-01-02 | fresh/0.1.69                     | Generic               |
| 2026-01-04 | fresh/0.1.70                     | Generic               |
| 2026-01-06 | fresh/0.1.71                     | Generic               |
| 2026-01-08 | fresh/0.1.74                     | Generic               |
| ""         | llama.cpp/b7673                  | Generic               |
| 2026-01-09 | fresh/0.1.75                     | Generic               |
| 2026-01-10 | ollama/0.13.5                    | Generic               |
| 2026-01-11 | fresh/0.1.76                     | Generic               |
| 2026-01-13 | fresh/0.1.77                     | Generic               |
| 2026-01-15 | VSCode/1.108.1                   | Generic               |
| 2026-01-19 | ollama/0.14.2                    | Generic               |
| ""         | cli/2.85.0                       | Generic[^cli]         |
| 2026-01-20 | fresh/0.1.83                     | Generic               |
| ""         | go/1.25.6                        | Generic[^go]          |
| ""         | jq/1.8.1                         | Generic[^jq]          |
| ""         | firefox/147.0.1                  | Generic               |
| 2026-01-21 | fresh/0.1.86                     | Generic               |
| 2026-01-22 | fresh/0.1.87                     | Generic               |
| 2026-01-23 | fresh/0.1.88                     | Generic               |
| 2026-01-25 | ollama/0.15.1                    | Generic               |
| 2026-01-27 | fresh/0.1.90                     | Generic               |
| ""         | libarrow/23.0.0                  | Generic[^libarrow]    |
| 2026-01-28 | fresh/0.1.93                     | Generic               |

\* CEU or approved users only -- when not indicated can be found out from the folder associated with a module.

Three aspects are notable,

1. A file named NOTE indicates the original annotation.
2. A symbolic link is generated when appropriate to simplify executable file name.
3. The available source package is kept in the sources/ directory.

## Word cloud diagrams

They are generated from script [setup.sh](setup.sh),

## Footnotes

---

[^metal]: **metal**

    Notes on METAL 2020-05-05r

    This version has options EFFECT_PRINT_PRECISION and STDERR_PRINT_PRECISION (both with default 4) to enable many decimal places.

    The letter `r` as in `2020-05-05r` indicates a replacement of functions in `libsrc/MathStats.cpp` to ensure generality -- [details](http://numerical.recipes/forum/attachment.php?attachmentid=60&d=1190409664) have also been posted to the GitHub page, [https://github.com/statgen/METAL/issues/24](https://github.com/statgen/METAL/issues/24).

    ```
    FATAL ERROR -
    a too large, ITMAX too small in gamma countinued fraction (gcf)

    so the -1.info file could not be generated.
    ```

[^gemma]: **gemma**

    Note on compiling from source

    A considerably smaller (1,097,256 vs 22,721,624) executable, /usr/local/Cluster-Apps/ceuadmin/GEMMA/0.98.5/bin, is generated under CSD3 but the original distribution is used by default.

    ```bash
    module load openblas/0.2.15
    make
    ```

[^fcgene]: **fcgene**

    Alternative site

    See [https://github.com/dr-roshyara/fcgene](https://github.com/dr-roshyara/fcgene)

[^gs]: **ghostscript**

    To produce high-resolution png, try `gs -dSAFER -dBATCH -dNOPAUSE -dEPSCrop -sDEVICE=pngalpha -r600 -sOutputFile=output.png input.eps`.

[^jq]: **jq**

    The executable points to the one available from the website, e.g., `wget https://github.com/jqlang/jq/releases/download/jq-1.8.1/jq-linux-amd64 -O jq`.

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

    On icelake, this is updated as follows,

    ```bash
    module load ceuadmin/proj/6.3.0
    module load ceuadmin/jasper/4.2.4
    module load libxml2/2.9.13/gcc/fww2yzpt
    module load ceuadmin/json-c/0.17-20230812-icelake
    wget -qO- https://github.com/OSGeo/gdal/archive/refs/tags/v3.0.4.tar.gz | \
    tar xvfz -
    cd gdal-3.0.4/gdal
    ./configure --prefix=$CEUADMIN/gdal/3.0.4 --with-libjson-c=$CEUADMIN/json-c/0.17-20230812-icelake \
                --with-proj=/usr/local/Cluster-Apps/ceuadmin/proj/6.3.0 \
                --without-sqlite3
    make
    ```

[^expat]: **expat**

    Due to error messages, the options are specified as follows,

    ```bash
    ./configure --prefix=$CEUADMIN/expat/2.4.7 --without-docbook
    ```

[^ruby]: **ruby**

    This is done as follows,

    ```bash
    curl -sSL https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.5.tar.gz -o ruby-2.7.5.tar.gz
    tar -xzf ruby-2.7.5.tar.gz
    cd ruby-2.7.5
    ./configure --prefix=$CEUADMIN/ruby/2.7.5
    make
    make install
    rvm reset
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

    Under icelake (CentOS 8), this configuration is used for `gnutls/3.8.4-icelake`,

    ```bash
    module load gettext/0.21/gcc/qnrcglqo
    configure --prefix=$CEUADMIN/gnutls/3.8.4-icelake --with-included-unistring
    make
    make install
    ```

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

    See <https://cambridge-ceu.github.io/csd3/applications/quarto.html>.

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

    See <https://cambridge-ceu.github.io/csd3/applications/pspp.html>.

    **Makeinfo**

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

    The singularity module in place is already very useful, e.g.,

    ```bash
    singularity pull tensorflow_latest_gpu.sif docker://tensorflow/tensorflow:latest-gpu
    singularity build --sandbox tensorflow docker://tensorflow/tensorflow:latest-gpu
    singularity run tensorflow
    python -c '
    from tensorflow.python.client import device_lib
    print(device_lib.list_local_devices())
    '
    ```

    where we pull the container both in Singularity Image Format (SIF) format and into a directory. However, we now have

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

    For 2.0.3, we try the conda option.

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

    Archive, <https://www.openssl.org/source/old/>

    ```bash
    wget -qO- https://www.openssl.org/source/openssl-3.2.1.tar.gz | \
    tar xvfz -
    cd openssl-3.2.1/
    export PERL5LIB=
    ./Configure --prefix=$CEUADMIN/openssl/3.2.1-icelake --openssldir=$CEUADMIN/openssl/3.2.1-icelake/ssl
    make
    make install
    ```

    One can check version with `openssl version`. For 1.1.1b, it is the followiong,

    ```bash
    wget -qO- https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1b.tar.gz | \
    tar xvfz -
    cd openssl-OpenSSL_1_1_1b/
    config --prefix=$CEUADMIN/openssl/1.1.1b-icelake --openssldir=$CEUADMIN/openssl/1.1.1b-icelake/ssl
    make install
    ```

    Module `ceuadmin/openssl/3.2.1` actually points to `/usr/local/Cluster-Apps/openssl/3.2.1`.

[^openssh]: **openssh**

    OpenSSL is called first to use the specific `openssl`, e.g.,

    ```bash
    module load ceuadmin/openssl/3.2.1-icelake
    ./configure --prefix=$CEUADMIN/openssh/9.7p1-icelake --with-ssl-dir=$CEUADMIN/openssl/3.2.1-icelake
    make
    make install
    ```

    Check is made with `cat config.log | grep -i openssl`. However, variable EVP_PKEY_bits is nonexistent. It turns out the default ssl is fine.

    ```bash
    configure --prefix=$CEUADMIN/openssh/9.7p1-icelake
    make
    make install
    ```

    However, `EVP_KDF_ctrl` is missing with git.

[^vep]: **ensembl-vep**

    Note that a nextflow pipeline is now available from `nextflow/`. A test has been done as follows,

    ```bash
    export PERL5LIB=
    module load ceuadmin/libssh
    git clone https://github.com/Ensembl/ensembl-vep.git
    cd ensembl-vep
    perl INSTALL.pl -l Bio -y GRCh37 -a acfp -g all -s homo_sapiens,homo_sapiens_merged --NO_TEST -c .vep
    ./vep -i examples/homo_sapiens_GRCh38.vcf --cache .vep
    ```

    A log file is kept [here](https://github.com/cambridge-ceu/csd3/blob/master/systems/files/ensembl-vep-111-icelake.log).

    Moreover, we could also add some plugin data, <https://github.com/Ensembl/VEP_plugins>.

    For the nearest gene, the `Set::IntervalTree` is required and is furnished as follows,

    ```bash
    cpanm -l /usr/local/Cluster-Apps/ceuadmin/ensembl-vep/111-icelake/Bio ExtUtils::CppGuess
    cpanm -l /usr/local/Cluster-Apps/ceuadmin/ensembl-vep/111-icelake/Bio ExtUtils::CBuilder
    cpanm -l /usr/local/Cluster-Apps/ceuadmin/ensembl-vep/111-icelake/Bio Set::IntervalTree
    ```

    In general, with `perl -MCPAN -e shell` we specify

    > o conf makepl_arg "PREFIX=/usr/local/Cluster-Apps/ceuadmin/ensembl-vep/111-icelake/Bio"
    > o conf makepl_arg "INSTALL_BASE=/usr/local/Cluster-Apps/ceuadmin/ensembl-vep/111-icelake/Bio"
    > 'o conf commit'

    to see `commit: wrote '/home/jhz22/.cpan/CPAN/MyConfig.pm'`. However, this is NOT the case here.

    Our module has `PERL5LIB=$root/Bio:$root/Bio/lib/perl5/x86_64-linux-thread-multi/`.

    Our example data here is `442807041.vcf`,

    ```
    ##fileformat=VCFv4.0
    #CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO
    2	101332618	2:101332618_C_T	T	C	.	.	.
    ```

    and we run script,

    ```bash
    vep --input_file 442807041.vcf \
        --output_file 442807041.tab --force_overwrite \
        --offline --cache --dir_cache /usr/local/Cluster-Apps/ceuadmin/ensembl-vep/111-icelake/.vep \
        --species homo_sapiens --assembly GRCh37 --pick --nearest symbol --symbol \
        --tab
    ```

    Further information, <https://www.ensembl.org/info/docs/tools/vep/script/vep_download.html>.

[^json-c]: **json-c**

    ```bash
    export LD_LIBRARY_PATH=
    wget -qO- https://github.com/json-c/json-c/archive/refs/tags/json-c-0.17-20230812.tar.gz | \
    tar xvfz -
    cd json-c-0.17-20230812
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/Cluster-Apps/ceuadmin/json-c/0.17-20230812-icelake ..
    ln -sf /usr/include/locale.h xlocale.h
    make -I.
    make install
    ```

[^LVM2]: **LVM2**

    Only device mapper is installed, i.e.,

    ```bash
    wget -qO-  https://sourceware.org/ftp/lvm2/LVM2.2.03.23.tgz | \
    tar xvfz -
    cd LVM2.2.03.23
    ./configure --prefix=$CEUAMIN/LVM2/2.03.23-icelake --with-vdo=none
    make device-mapper
    make install_device-mapper
    ```

[^cryptsetup]: **cryptosetup**

    ```bash
    # incomplete libssh in need of a fix
    module load cmake/3.21.3/intel/wce32356
    wget -qO- https://www.libssh.org/files/0.10/libssh-0.10.6.tar.xz | \
    tar xfJ -
    cd libssh-0.10.6
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=$CEUADMIN/libssh/0.10.6-icelake  ..
    make
    module load ceuadmin/json-c/0.17-20230812-icelake
    module load ceuadmin/LVM2/2.03.23-icelake
    module load ceuadmin/popt/1.19-icelake
    module load gettext/0.21/gcc/qnrcglqo
    CFLAGS="-I/usr/local/Cluster-Apps/ceuadmin/LVM2/2.03.23-icelake/include" \
    configure --prefix=$CEUADMIN/cryptsetup/2.7.1-icelake --disable-ssh-token
    ```

[^krb5]: **krb5-icelake**

    It is possible to use the default ssh.

    ```bash
    configure --prefix=$CEUADMIN/krb5/1.21.2-icelake
    module load gettext/0.21/gcc/qnrcglqo
    make install
    ```

[^git]: **git-2.44.0-icelake**

    ```bash
    wget -qO- https://github.com/git/git/archive/refs/tags/v2.44.0.tar.gz | \
    tar xvfz -
    cd git-2.44.0
    make configure
    configure --prefix=${CEUADMIN}/git/2.44.0-icelake
    make
    make install
    ```

    There remains an error message `git-remote-https: symbol lookup error: /usr/lib64/libk5crypto.so.3: undefined symbol: EVP_KDF_ctrl, version OPENSSL_1_1_1b`.

[^peer]: **peer**

    This is documented separately in the R section, <https://cambridge-ceu.github.io/csd3/applications/peer.html>.

[^ImageMagick]: **ImageMagick**

    ```bash
    wget -qO- https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.1-31.tar.gz | \
    tar xvfz -
    cd ImageMagick-7.1.1-31/
    ./configure --prefix=$CEUADMIN/ImageMagick/7.1.1-31
    make
    make install
    ```

    This version comes with magick, e.g., `magick -density 600 -colorspace RGB -alpha on -background none input.eps output.png` which produces high-resolution png file.

[^rtmpdump]: **rtmpdump**

    It is necessary for `RCurl 1.98-1.14`. With `curl-7.63.0-gcc-5.4.0-4uswlql` we could also install `rtracklayer 1.64.0`.

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

[^spyder]: **spyder**

    ```bash
    cd /rds/project/jmmh2/rds-jmmh2-public_databases/software
    wget https://github.com/spyder-ide/spyder/releases/download/v5.5.4/EXPERIMENTAL-Spyder-5.5.4-Linux-x86_64.sh
    bash EXPERIMENTAL-Spyder-5.5.4-Linux-x86_64.sh
    ```

[^crux]: **crux**

    See <https://cambridge-ceu.github.io/csd3/applications/crux.html>.

[^p7zip_zstd]: **p7zip-zstd**

    A simple `make` is sufficient but it is necessary to implement a minor revision of `install.sh`, line 19, so that `DEST_HOME=/usr/local/Cluster-Apps/ceuadmin/p7zip-zstd/17.05`.

[^boost]: **boost**

    ```bash
    module load python/3.8.11/gcc/pqdmnzmw
    wget -qO- http://sourceforge.net/projects/boost/files/boost/1.76.0/boost_1_76_0.tar.gz | \
    tar xvzf -
    cd boost_1_76_0
    ./bootstrap.sh
    ./b2 --prefix=$CEUADMIN/boost/1.76.0 install
    ./bjam --with-regex --with-filesystem --with-iostreams --with-thread --with-program_options \
            --with-serialization --with-system --with-date_time install
    export BOOST_ROOT=/usr/local/src/boost_1_76_0
    ```

[^wine]: **wine**

    ```bash
    module load ceuadmin/krb5/1.21.2-icelake
    configure --prefix=${CEUADMIN}/wine/8.21 --enable-win64
    make install
    ```

[^seqkit]: **seqkit**

    An attempt is made with [UniProt](https://ftp.uniprot.org/pub/databases/uniprot/), `current_release/uniref/uniref100/`, `knowledgebase/genome_annotation_tracks/UP000005640_9606_beds`.

    ```bash
    #!/usr/bin/bash

    export fasta=~/rds/public_databases/UniProt/uniref100.fasta.gz
    export fasta=~/rds/public_databases/UniProt/uniprot_sprot.fasta.gz
    export regions=UP000005640_9606_proteome.bed

    module load ceuadmin/seqkit
    seqkit subseq --bed ${regions} --seq-type protein --out-file output.fasta ${fasta}

    awk '{print $4}' ${regions} | sort | uniq > protein_ids.txt
    seqkit grep -f protein_ids.txt ${fasta} > output.fasta

    # A contrast with the genomic counterpart
    # bedtools getfasta -fo output.fasta -s -fullHeader -fi ${fasta} -bed ${regions}
    ```

[^dotnet]: **dotnet**

    The paket tool is installed as follows,

    ````bash
    cd /usr/local/Cluster-Apps/ceuadmin/dotnet/6.0.423
    dotnet new tool-manifest
    dotnet tool install paket
    dotnet paket
    dotnet paket add Mono.Unix --version 7.1.0-final.1.21458.1
    ```

    The last line above is for OpenMS. We see `.config/dotnet-tools.json` and also

    ```
    Paket version 8.0.3+75b30cdcb8859e8d129f139444d9b9b600bfff07
    Adding package 'Mono.Unix' 7.1.0-final.1.21458.1
    Resolving dependency graph...
     - Mono.Unix is pinned to 7.1.0-final.1.21458.1
    Updated packages:
      Group: Main
        - Mono.Unix: 7.1.0-final.1.21458.1 (added)
    Created dependency graph (1 packages in total)
    Downloading Mono.Unix 7.1.0-final.1.21458.1
    Download of Mono.Unix 7.1.0-final.1.21458.1 done in 249 milliseconds. (231504 kbit/s, 6 MB)
     - Project GenerateDeps.proj needs to be restored
    Resolved package 'Mono.Unix' to version 7.1.0-final.1.21458.1
    Total time taken: 3 seconds
    ```

    ````

[^FlashLFQ]: **FlashLFQ**

    Web: <https://github.com/smith-chem-wisc/FlashLFQ/wiki/Using-the-Command-Line>

    In the script below, a benchmark provided by the software available from `${FLASHLFQ_ROOT}/src/Test/SampleFiles`.

    ```bash
    module load ceuadmin/FlashLFQ
    flashlfq --idt MaxQuant/msms.txt --rep . --ppm 5 --chg
    ```

    which works on `MaxQuant/msms.txt` and generates `FlashLfqSettings.toml`, `QuantifiedPeaks.tsv`, `QuantifiedPeptides.tsv` and `QuantifiedProteins.tsv`.

[^docker]: **docker**

    See <https://cambridge-ceu.github.io/csd3/applications/docker.html>.

[^podman]: **podman**

    See <https://cambridge-ceu.github.io/csd3/applications/podman.html>.

[^alpine]: **alpine**

    Module `ceuadmin/alpine/2.26-icelake` compiled using `gcc/11.2.0/gcc/rjvgspag`.

[^qemu]: **qemu**

    See <https://cambridge-ceu.github.io/csd3/applications/qemu.html>.

[^hivex]: **hivex**

    ```bash
    wget -qO- https://download.libguestfs.org/hivex/hivex-1.3.23.tar.gz | tar xfz -
    cd hivex-1.3.23
    module load ceuadmin/ocaml/4.14.2
    module load ceuadmin/ruby/2.7.5
    export PERLB5LIB=
    autoreconf -i --force
    ./generator/generator.ml
    ./configure --prefix=$CEUADMIN/hivex/1.3.23
    make
    cd perl
    perl Makefile.PL INSTALLDIRS=site INSTALL_BASE=/usr/local/Cluster-Apps/ceuadmin/hivex/1.3.23
    cd ..
    make
    make install
    ```

    The release version has `hivex.h` but GitHub releases doesn't; however since ocaml is available it can be generated from `generator/generator.ml`.. The `INSTALL_PREFIX` is replaced with `INSTALL_BASE`. Moreover, ocaml, Perl and ruby are enabled. Due to permission issue, Python binding is not enabled.

    ```
    /usr/bin/install: cannot create regular file '/usr/local/software/spack/spack-views/._rhel8-icelake-20211027_2/uxqqj4xcjrltatqgtuoi2hp46uabtzom/python-3.8.11/gcc-11.2.0/pqdmnzmwkrtp4e3gjibmcxho7g6ekpat/lib/python3.8/site-packages/libhivexmod.cpython-38-x86_64-linux-gnu.so': Permission denied
    ```

[^findlib]: **findlib**

    ```bash
    wget -qO- http://download.camlcity.org/download/findlib-1.9.6.tar.gz | tar xfz -
    cd findlib-1.9.6
    configure -bindir $CEUADMIN/findlib/1.9.6/bin -mandir $CEUADMIN/findlib/1.9.6/man
    make
    make install
    ```

[^opam]: **opam**

    ```bash
    opam init
    opam switch list
    opam switch list-available
    opam switch create ocaml-4.14
    opam install -y hivex --destdir $CEUADMIN/hivex/1.3.23
    ```

[^libguestfs]: **libguestfs**

    ```bash
    wget -qO- https://download.libguestfs.org/1.52-stable/libguestfs-1.52.2.tar.gz | tar xfz -
    cd libguestfs-1.52.2
    ./configure --prefix=$CEUADMIN/libguestfs/1.48.6 \
                --with-extra="findlib=$CEUADMIN/findlib/1.9.6" \
                --with-extra="hivex=$CEUADMIN/hivex/1.3.23"
    ```

    It appears `export LIBGUESTFS_BACKEND=direct` is working.

[^msgf]: **MS-GF+**

    A `test.sh` using examples from the source (`msgfplus-2024.03.26.tar.gz` -- assuming it has bene untarred into `src/`),

    ```bash
    ln -s src/src/test/resources test
    java -Xmx4000M -jar MSGFPlus.jar -s test/test.mgf -o test/test.mzid \
         -d test/BSA.fasta -t 10ppm -m 0 -inst 1 -e 1 -ti -1,2 -ntt 1 -tda 1 -minLength 6 \
         -maxLength 50 -n 1 -thread 7 -mod test/Mods.txt
    java -Xmx4000M -jar MSGFPlus.jar -s test/test.mgf -o test/test.mzid \
         -d  test/BSA.fasta -conf test/MSGFDB_Param.txt
    ```

[^fragpipe]: **FragPipe**

    It does require Java 11, MSFragger 4.1, Python 3.9, and EasyPQp; to get around we use `openjdk/11.0.12_7/gcc/czpuqhmv`, `ceuadmin/MSFragger/4.1`, `ceuadmin/Anaconda3/2023.09-0`.

    ```bash
    source /usr/local/Cluster-Apps/ceuadmin/Anaconda3/2023.09-0/bin/activate
    pip install git+https://github.com/grosenberger/easypqp.git@master
    ```

    IonQuant 1.10.27 is installed similarly. In fact, it is is straightforwad to select `Download Update` from the menu, so `IonQuant-1.10.27.jar`, `/MSFragger-4.1/`, and `diaTracer-1.1.5.jar` are available from the `tools/` directory.

[^jasper]: **jasper**

    ```bash
    wget -qO- https://github.com/jasper-software/jasper/archive/version-4.2.4/jasper-4.2.4.tar.gz | \
    tar -xvzf -
    module load texlive
    cd jasper-version-4.2.4/build && ./build_all
    ll ../tmp_cmake/release-1 -rt
    ```

[^curl]: **curl**

    ```bash
    wget -qO- wget https://curl.se/download/curl-7.85.0.tar.gz | \
    tar xfz -
    cd curl-7.85.0/
    module load ceuadmin/openssl/3.2.1
    configure --prefix=$CEUADMIN/curl/7.85.0 --with-openssl
    make
    make install
    ```

[^libjpeg]: **libjpeg-turbo**

    ```bash
    wget -qO- https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/tags/3.0.4.tar.gz | \
    tar xvfz -
    cd libjpeg-turbo-3.0.4/
    mkdir build
    cd build
    cmake -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$CEUADMIN/libjpeg-turbo/3.0.4 ..
    make
    make install
    ```

[^libgeotiff]: **libgeotiff**

    ```bash
    module load ceuadmin/autoconf/2.72c.24-8e728
    module load ceuadmin/proj/7.2.1
    module load ceuadmin/libjpeg-turbo/3.0.4
    module load zlib/1.2.11
    wget -qO- https://github.com/OSGeo/libgeotiff/archive/refs/tags/1.7.3.tar.gz | \
    tar xvfz -
    cd libgeotiff-1.7.3/
    cd libgeotiff
    autoupdate
    autogen.sh
    configure --prefix=$CEUADMIN/libgeotiff/1.7.3 \
              --with-jpeg=$CEUADMIN/libjpeg-turbo/3.0.4 \
              --with-libtiff=$CEUADMIN/tiff/4.6.0 \
              --with-proj=$CEUADMIN/proj/7.2.1 \
              --with-zlib=/usr/local/Cluster-Apps/zlib/1.2.11
    make -j3
    make check
    make install
    ```

[^gdal370]: **gdal 3.7.0**

    Web: <https://gdal.org/en/latest/development/building_from_source.html>

    ```bash
    wget -qO- https://github.com/OSGeo/gdal/releases/download/v3.7.0/gdal-3.7.0.tar.gz | \
    tar xvfz -
    cd gdal-3.7.0
    mkdir build && cd build

    module load ceuadmin/curl/7.85.0
    module load ceuadmin/libiconv/1.17
    module load ceuadmin/libarchive/3.7.5
    module load ceuadmin/libgeotiff/1.7.3
    module load ceuadmin/libjpeg-turbo/3.0.4
    module load ceuadmin/libpng/1.5.30
    module load ceuadmin/openssl/3.2.1
    module load ceuadmin/poppler/0.84.0
    module load ceuadmin/tiff/4.6.0

    cmake -DGDAL_ENABLE_CURL=ON \
          -DGDAL_ENABLE_OGR=ON \
          -DGDAL_ENABLE_LIBARCHIVE=ON \
          -DGDAL_ENABLE_OPENSSL=ON \
          -DCMAKE_INSTALL_PREFIX=$CEUADMIN/gdal/3.7.0 \
          -DCURL_INCLUDE_DIR=$CEUADMIN/curl/7.85.0/include \
          -DCURL_LIBRARY_RELEASE=$CEUADMIN/curl/7.85.0/lib/libcurl.so \
          -DGEOTIFF_INCLUDE_DIR=$CEUADMIN/libgeotiff/1.7.3/include \
          -DGEOTIFF_LIBRARY_RELEASE=$CEUADMIN/libgeotiff/1.7.3/lib/libgeotiff.so \
          -DARCHIVE_INCLUDE_DIR=$CEUADMIN/libarchive/3.7.5/include \
          -DARCHIVE_LIBRARY=$CEUADMIN/libarchive/3.7.5/lib/libarchive.so \
          -DCRYPTOPP_INCLUDE_DIR=$CEUADMIN/cryptopp/8.9.0/include \
          -DCRYPTOPP_LIBRARY_RELEASE=$CEUADMIN/cryptopp/8.9.0/lib/libcryptopp.so \
          -DIconv_INCLUDE_DIR=$CEUADMIN/libiconv/1.17/include \
          -DIconv_LIBRARY=$CEUADMIN/libiconv/1.17/lib/libiconv.so \
          -DJPEG_INCLUDE_DIR=$CEUADMIN/libjpeg-turbo/3.0.4/include \
          -DJPEG_LIBRARY_RELEASE=$CEUADMIN/libjpeg-turbo/3.0.4/lib64/libjpeg.so \
          -DOPENSSL_INCLUDE_DIR=$CEUADMIN/openssl/3.2.1/include \
          -DOPENSSL_CRYPTO_LIBRARY=$CEUADMIN/openssl/3.2.1/lib/libcrypto.so \
          -DOPENSSL_SSL_LIBRARY=$CEUADMIN/openssl/3.2.1/lib/libssl.so \
          -DPNG_PNG_INCLUDE_DIR=$CEUADMIN/libpng/1.5.30/include \
          -DPNG_LIBRARY_RELEAS=$CEUADMIN/libpng/1.5.30/lib \
          -DPoppler_INCLUDE_DIR=$CEUADMIN//poppler/0.84.0/include \
          -DPoppler_LIBRARY=$CEUADMIN/poppler/0.84.0/lib64/libpoppler.so \
          -DPROJ_LIBRARY=$CEUADMIN/proj/7.2.1/lib/libproj.so \
          -DPROJ_INCLUDE_DIR=$CEUADMIN/proj/7.2.1/include \
          -DTIFF_LIBRARY=$CEUADMIN/tiff/4.6.0/lib/libtiff.so \
          -DTIFF_INCLUDE_DIR=$CEUADMIN/tiff/4.6.0/include \
          ..
    make
    module load ceuadmin/Anaconda3/2023.09-0
    pip install rasterio
    pip install geopandas
    pip install gdal==3.7.0
    ```

    where `pip install gdal` uses `libgdal.so` just built.

[^inetutils]: **inetutils**

    This is already in the list of decommissioned GNU packages, <https://www.gnu.org/software/software.en.html>; nevertheless `finger` is still useful from Fedora 28.

[^node]: **node**

    See <https://cambridge-ceu.github.io/csd3/applications/node.html>.

[^chrome]: **chrome**

    ```bash
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    rpm2cpio google-chrome-stable_current_x86_64.rpm | cpio -idmv
    ```

[^brotli]: **brotli**

    There appears to be CMake-based, an overhaul of 1.0.9 as used for building RStudio earlier.

    ```bash
    wget -qO- https://github.com/google/brotli/archive/refs/tags/v1.1.0.tar.gz | \
    tar xfz -
    cd brotli-1.1.0
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=${CEUADMIN}/brotli/1.1.0 ..
    make
    make install
    ```

    As it is used for building R 4.4.2-gcc11, it also does away with gcc/6 and miniconda3/4.5.1.

[^rust]: **Rust**

    This is upgraded from 1.74.1 with `rustup default stable` at suggestion of gmake when compiling firefox/nightly.
    To avoid duplication, a symbolic link is generated on `/usr/local/Cluster-Apps/ceuadmin/rust/1.74.1/cargo` as `${HOME}/.cargo`.
    Naturally, both cargo and rustc use the directory above.

    The following steps are sketched for `ceuadmin/nightly`,

    ```bash
    export CARGO_HOME="$CEUADMIN/rust/nightly/cargo"
    export RUSTUP_HOME="$CEUADMIN/rust/nightly/rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    export PATH="$CARGO_HOME/bin:$PATH"
    rustup toolchain install nightly
    rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu
    rustup default nightly
    rustc --version
    ```

    As noted in [rust.md](files/rust.md) on 22/5/2025, we have `rustc 1.89.0-nightly (bf64d66bd 2025-05-21)`.

    To compile Firefox/nightly (145.0a1), cbindgen is required which can be installed with `cargo install cbindgen --root $CEUADMIN/rust/nightly/cargo`.

[^git2481]: **git/2.48.1**

    Now it has a separate entry in the Applications section, <https://cambridge-ceu.github.io/csd3/applications/git.html>.

[^libgcrypt]: **libgcrypto**

    ```bash
    wget -qO- https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.5.3.tar.bz2 | x
    tar xjf -
    mv libgcrypt-1.5.3/ src
    cd src
    ./configure --prefix=$CEUADMIN/libgcrypt/1.5.3
    make
    make install
    ```

[^texinfo]: **texinfo**

    ```bash
    wget -qO- https://ftp.gnu.org/gnu/texinfo/texinfo-7.2.tar.xz | \
    tar Jxf -
    mv texinfo-7.2/ src
    cd src
    make && make install
    ```

[^ollama]: **ollama**

    It is rather standard,

    ```bash
    curl -L https://ollama.com/download/ollama-linux-amd64.tgz | \
    tar xvfz -
    ollama --help
    ollama serve &
    ollama list
    ```

    Note that `ollama serve` command procedes `ollama list` for available models, and the `--help` option will list environment variables such as OLLAMA_HOST (default 127.0.0.1:11434).

[^tesseract]: **tesseract**

    See <https://cambridge-ceu.github.io/csd3/applications/tesseract.html>.

[^apidog]: **apidog**

    ```bash
    wget https://file-assets.apidog.com/download/Apidog-linux-latest.zip
    unzip  Apidog-linux-latest.zip
    ./Apidog.AppImage  --appimage-extract
    ./apidog --no-sandbox --help
    ```

[^Anaconda3]: **Anaconda3**

    We start with

    ```bash
    https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh
    PREFIX=/usr/local/Cluster-Apps/ceuadmin/Anaconda3/2024.10-1
    conda config --set auto_activate_base false
    ```

    Due to its complex environment, it is prohibitive to furnish any installation therefore preferable to create new environment from this.

    ```bash
    source /rds/project/rds-4o5vpvAowP0/software/Anaconda3-2024.10-1/bin/activate
    conda create --name new_env python=3.9
    conda activate new_env
    conda config --add channels defaults
    conda config --add channels bioconda
    conda config --add channels conda-forge
    conda install -c openms pyopenms --yes
    ```

[^micromamba]: **micromamba**

    Web: <https://mamba.readthedocs.io/en/latest/index.html>

    ```bash
    export dst=/rds/project/rds-4o5vpvAowP0/software/micromamba/2.0.7
    mkdir -p $dst && cd $dst
    curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | \
    tar -xvj bin/micromamba
    export MAMBA_ROOT_PREFIX=$dst
    eval "$(./bin/micromamba shell hook -s posix)"
    micromamba activate
    micromamba install python=3.13 jupyter -c conda-forge
    export MAMBA_ROOT_PREFIX=$CEUADMIN/micromamba/2.0.7
    mkdir $CEUADMIN/micromamba
    ln -sf $dst $CEUADMIN/micromamba/2.0.7
    # current shell
    eval "$(micromamba shell hook --shell bash)"
    micromamba activate
    micromamba deactivate
    ```

    Note that to save space, a symbolic link is created from the project space. The usual environment creation also works,

    ```bash
    micromamba create -n micromamba xtensor -c conda-forge
    micromamba activate micromamba
    micromamba config append channels conda-forge
    micromamba config set channel_priority strict
    ```

[^diann]: **DIA-NN 2.0.2**

    GitHub, <https://github.com/vdemichev/DiaNN>

    We see

    ```
    ./diann
    ./diann: /lib64/libm.so.6: version `GLIBC_2.29' not found (required by ./diann)
    ./diann: /lib64/libc.so.6: version `GLIBC_2.32' not found (required by ./diann)
    ./diann: /lib64/libc.so.6: version `GLIBC_2.34' not found (required by ./diann)
    ./diann: /lib64/libc.so.6: version `GLIBC_2.33' not found (required by ./diann)
    ```

    and resort to singularity with [diann-2.0.2.def](files/diann-2.0.2.def)

    ```bash
    singularity build diann.sif diann.def
    singularity run diann.sif --fasta /path/to/human_proteome.fasta --dir /path/to/data/ --out output.txt
    ```

[^esr]: **firefox/60.5.1-1.el7**

    This is actually the only version (from shub://nuitrcs/singularity-firefox) which works on CSD3.

[^llama_cpp]: **llama.cpp**

    See <https://cambridge-ceu.github.io/csd3/applications/llama.cpp.html>.

[^insnovo]: **InstaNovo**

    See <https://cambridge-ceu.github.io/csd3/Python/InstaNovo.html>.

[^scGPT]: **scGPT**

    See <https://cambridge-ceu.github.io/csd3/Python/scGPT.html>.

[^scanpy]: **scanpy**

    GitHub: <https://github.com/scverse/scanpy>

    This is a side-product of scGPT (the GitHub installation above). We intend to run tutorials `tutorial_pearson_residuals.ipynb` as in <https://github.com/scverse/scanpy-tutorials> but gets
    error, so we set for an update of 1.11.1.

    ```bash
    pip uninstall scanpy -y
    pip install scanpy
    pip list | grep scanpy
    ```

    It turns out it does not introduce any conflicts. For this tutorial we additionally have `tqdm` 4.67.1 and `iprogress` 1.17.0.

[^DrugAssist]: **DrugAssist**

    See <https://cambridge-ceu.github.io/csd3/Python/DrugAssist.html>.

[^uv]: **uv**

    Web, <https://docs.astral.sh/uv/>

    ```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
    ```

    extracts `uv`/`uvx` to `$HOME/.local/bin` and adds `. "$HOME/.local/bin/env"` to `$HOME/.bashrc` but we might as well customise.

    To implement `pip cache purge`, use `uv cache clean`.

[^bitnet]: **BitNet**

    See <https://cambridge-ceu.github.io/csd3/Python/BitNet.html>.

[^C2S]: **C2S-Scale**

    See <https://cambridge-ceu.github.io/csd3/Python/C2S-Scale.html>.

[^mozbuild]: **mozbuild**

    The cluster includes `cbindgen/0.28.0`, `clang/19.1.7`, `dump_syms/2.3.4`, `nasm/2.16.03`, `node/18.19.0` and `pkg-config/1.8.0` from compiling mozilla Firefox nightly. By default, the directory is `$HOME/.mozbuild` which could also be symbolic to a designated directory.

[^genie]: **GENIE**

    ```bash
    git clone https://github.com/sriramlab/GENIE.git
    cd GENIE
    git checkout v1.1.1
    mkdir 1.1.1 && cd 1.1.1
    cmake ..
    make
    ```

[^pgs_csx]: **PGS-CSx**

    Web: <https://github.com/getian107/PRScsx>

    The Python packages numpy and scipy are required, which are conveniently derived from ceuadmin/scGPT, and the documenetation example is used as follows,

    ```bash
    #!/usr/bin/bash
    module load ceuadmin/PGS-CSx
    python ${PGS_CSx_ROOT}/PRScsx.py
           --ref_dir=${LD_UKBB} \
           --bim_prefix=test_data/test \
           --sst_file=test_data/EUR_sumstats.txt,test_data/EAS_sumstats.txt \
           --n_gwas=200000,100000 \
           --pop=EUR,EAS \
           --chrom=22 \
           --phi=1e-2 \
           --out_dir=. \
           --out_name=test
    ```

    to get `test_EAS_pst_eff_a1_b0.5_phi1e-02_chr22.txt` and `test_EUR_pst_eff_a1_b0.5_phi1e-02_chr22.txt`.

    From `snpinfo_mult_ukbb_hm3` it is apparent that the software uses GRCh37/hg19 alignment.

[^rsem]: **RSEM**

    One can directly use `Makefile`,

    ```bash
    make install prefix=/usr/local/Cluster-Apps/ceuadmin/RSEM/1.3.3
    make clean
    ```

    The R/EBSeq package is provided but the latest version can be installed with `BiocManager::install("EBSeq")` from R. The pRSEM/ directory is somewhat outdated.

[^virtualbox]: **VirtualBox/7.1-7.1.8_168469**

    This is purely experimental and half-way done.

[^vdo]: **vdo**

    There is no immediate use of this but a patch to `LVM2/2.03.23-icelake` mysteriously built earlier.

    ```bash
    wget -qO- https://github.com/dm-vdo/vdo/archive/refs/tags/8.3.1.1.tar.gz | \
    tar xfz -
    cd vdo-8.3.1.1/
    make
    make install DESTDIR=$CEUADMIN/vdo/8.3.1.1 INSTALLOWNER= defaultdocdir= defaultlicensedir=
    # LVM2 as above but also into vdo/8.3.1.1
    module load ceuadmin/vdo
    cd LVM2.2.03.23
    ./configure --prefix=$CEUADMIN/LVM2/2.03.23-icelake
    make
    make install
    ```

[^edit]: **edit**

    This is done as documented after `ceuadmin/rust/nightly`[^rust] is set up,

    ```bash
    wget -qO- https://github.com/microsoft/edit/archive/refs/tags/v1.0.0.tar.gz | \
    tar xfz -
    cd edit-1.0.0/
    RUST_BACKTRACE=1
    cargo build --config .cargo/release.toml --release
    ```

    We have `target/release/edit`, which is from `$CEUADMIN/rust/nightly/cargo/bin/cargo` not from
    `$CEUADMIN/rust/nightly/rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/cargo`.

[^sqlite]: **SQLite**

    It is standard, but TCLLIBDIR is needed to relocate `libtclsqlite3.so`.

    ```bash
    wget https://www.sqlite.org/2025/sqlite-src-3490200.zip
    unzip sqlite-src-3490200.zip
    cd sqlite-src-3490200
    ./configure --enable-all --prefix=$CEUADMIN/sqlite/3.49.2  TCLLIBDIR=$CEUADMIN/sqlite/3.49.2/tcl8.6
    make && make install
    ```

[^zettlr]: **Zettlr**

    Relevant information on Zettlr (<https://www.zettlr.com/>) is as follows,

    ```bash
    wget -qO- https://github.com/Zettlr/Zettlr/releases/download/v3.5.1/Zettlr-3.5.1-x86_64.rpm | \
    rpm2cpio - | \
    cpio -idmv
    wget https://github.com/retorquere/zotero-better-bibtex/releases/download/v6.7.269/zotero6-better-bibtex-6.7.269.xpi
    ```

    Note that a Zotero 6 Plugin is used. See <https://docs.zettlr.com/en/core/citations/> for additional information. See also Better BibTex for Zotero plugin (<https://retorque.re/zotero-better-bibtex/index.html>).

[^edlib]: **edlib**

    ```bash
    wget -qO- https://github.com/Martinsos/edlib/archive/refs/tags/v1.2.7.tar.gz | tar tvfz -
    cd edlib-1.2.7/
    source ~/rds/software/py38/bin/activate
    make
    ```

[^svanalyzer]: **SVanalyzer**

    Web: <https://svanalyzer.readthedocs.io/>

    ```bash
    module load ceuadmin/Miniconda3/22.9.0
    mkdir SVanalyzer
    cd SVanalyzer/
    conda create -n 0.36
    conda activate 0.36
    conda install -c bioconda svanalyzer
    svanalyzer benchmark
    ```

    The bundle includes bedtools/2.30.0, edlib/1.2.3, mummer/3.23, samtools/1.3.1. An attempt from source turned to be difficult with Log-Log4perl/1.57 and/or associates though the module does proceed,

    ```bash
    tar xvfz /home/jhz22/.cpan/sources/authors/id/E/ET/ETJ/Log-Log4perl-1.57.tar.gz
    cd Log-Log4perl-1.57/
    export PERL5LIB=/usr/local/Cluster-Apps/ceuadmin/lib/perl5
    make install
    perl Makefile.PL INSTALL_BASE=$PERL5LIB
    make
    make install
    ```

    By-products include newer modules bedtools/2.29.2, edlib/1.2.7, MUMmer/4.0.1, samtools/1.20.

[^sniffles]: **sniffles**

    see <https://cambridge-ceu.github.io/csd3/Python/Sniffles.html>.

[^awscli]: **awscli**

    See <https://cambridge-ceu.github.io/csd3/applications/awscli.html>.

[^seqpower]: **SEQPower**

    See <https://cambridge-ceu.github.io/csd3/applications/SEQPower.html>.

[^truvari]: **truvari**

    This is analogous to sniffles but from `conda install Truvari`.

    ```bash
    wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/AshkenazimTrio/analysis/NIST_SVs_Integration_v0.6/HG002_SVs_Tier1_v0.6.vcf.gz
    wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/AshkenazimTrio/analysis/NIST_SVs_Integration_v0.6/HG002_SVs_Tier1_v0.6.vcf.gz.tbi
    wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/AshkenazimTrio/analysis/NIST_SVs_Integration_v0.6/HG002_SVs_Tier1_v0.6.bed
    truvari bench --base HG002_SVs_Tier1_v0.6.vcf.gz \
                  --comp HG002_PacBio-HiFi-Revio_20231031_48x_GRCh38-GIABv3.vcf.gz \
                  --reference GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta.gz \
                  --includebed HG002_SVs_Tier1_v0.6.bed \
                  --output truvari_HG002_bench \
                  --giabreport --passonly --multimatch --refdist 2000 --chunksize 2000 --pctsize 0.70 --pctovl 0.0
    ```

    the output is in truvari_HG002_bench/.

[^happy]: **hap.py**

    See <https://cambridge-ceu.github.io/csd3/Python/hap.py.html>.

[^rtg]: **rtg-tools**

    It is very straightforward,

    ```bash
    wget https://github.com/RealTimeGenomics/rtg-tools/releases/download/3.13/rtg-tools-3.13-linux-x64.zip
    unzip rtg-tools-3.13-linux-x64.zip
    cd benchmarking
    FA=GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
    SDF=GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.sdf
    rtg format -o "$SDF" "$FA"
    ```

    which contains part of [`happy.sb`](files/happy.sb)[^happy] from above.

[^fly]: **fly**

    Web: <https://fly.io/>

    The module is built around attempt for a user,

    ```bash
    cd ~/rsd/software
    mkdir fly && cd fly
    ln -s /rds/project/rds-4o5vpvAowP0/software/fly ~/.fly
    curl -L https://fly.io/install.sh | sh
    export FLYCTL_INSTALL=~/.fly
    export PATH="$FLYCTL_INSTALL/bin:$PATH"
    flyctl --help
    flyctl version
    fly volumes create coffeeshop_vol --size 1
    fly deploy
    ```

    The last two lines are per <https://github.com/pavelanni/pythonicadventure-code>.

[^cli]: **cli (GitHub CLI)**

    See <https://cambridge-ceu.github.io/csd3/applications/cli.html>.

[^mtoolbox]: **MToolBox**

    Due to its size this is recreated as a separate entry, <https://cambridge-ceu.github.io/csd3/applications/MToolBox.html>.

[^vscode]: **VS Code**

    It is possible from CLI

    ```bash
    wget -qO- https://update.code.visualstudio.com/latest/linux-x64/stable | \
    tar -xzf -
    cd VSCode-linux-x64
    ./code
    ```

[^llm]: **LLM**

    Web: <https://llm.datasette.io/en/stable/>

    ```bash
    export UV_TOOL_DIR=$CEUADMIN/llm/0.26
    uv tool install llm
    uv tool dir
    ```

[^haplogrep]: **haplogrep**

    This follows MToolBox, see <https://cambridge-ceu.github.io/csd3/applications/haplogrep.html>.

[^flashpca]: **flashpca**

    This module is built to mirror flashpca2/2 which has been linked to personal home folder.

[^fnumt]: **fNUMT**

    This suite includes blastn 2.13.0+, samtools 1.10 and cap3 02/10/15.

[^simngs]: **simNGS**

    Case study from

    Zhuang X, et al. Leveraging new methods for comprehensive characterization of mitochondrial DNA in esophageal squamous cell carcinoma. _Genome Med_ 16, 50 (2024). <https://doi.org/10.1186/s13073-024-01319-2>.

    ```bash
    cat mutated_rCRS.fa | simLibrary -x 5 -r 150 --seed 12 > chrM_mut_5x.fasta
    cat wide_rCRS.fa | simLibrary-x 4995 -r 150 --seed 12 > chrM_wide_4995x.fasta
    cat chrM_mut_5x.fasta chrM_wide_4995x.fasta > chrM_sim_5000x_mut5x.fasta
    simNGS -p "paired" -O "chrM_sim_5000x_mut5x_PE150" -o "fastq" -s 12 runfile chrM_sim_5000x_mut5x.fasta
    ```

[^miniforge3]: **miniforge3**

    See <https://cambridge-ceu.github.io/csd3/applications/miniforge3.html>

[^cmocka]: **cmocka**

    ```bash
    wget -qO- https://github.com/clibs/cmocka/archive/refs/tags/1.1.5.tar.gz | tar xvfz -
    cd cmocka-1.1.5
    cmake -DUNIT_TESTING=ON -DCMAKE_INSTALL_PREFIX=$CEUADMIN/cmocka/1.1.5 -DCMAKE_BUILD_TYPE=Release ..
    make
    make install
    ```

[^scl]: **scl-utils**

    ```bash
    wget -qO- https://github.com/sclorg/scl-utils/archive/refs/tags/2.0.3.tar.gz | tar xvfz -
    cd scl-utils-2.0.3
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=$CEUADMIN/scl-utils/2.0.3 -DCMAKE_BUILD_TYPE=Release ..
    # cp mocka.h from mocka/1.1.5/include to tests; add several #include <below> to it; and #inlude "cmocka.h" from test_scllib.c
    #include <stdarg.h>
    #include <stddef.h>
    #include <stdint.h>
    #include <setjmp.h>
    module load cmocka/1.1.5
    make
    make staging
    # handling system folders
    make install DESTDIR=staging
    cd staging
    mv usr/local/Cluster-Apps/ceuadmin/scl-utils/2.0.3/*
    rm -rf usr
    cp -r * $CEUADMIN/scl-utils/2.0.3
    ```

[^gcc_toolset]: **gcc_toolset**

    Web: <https://dl.rockylinux.org/vault/centos/8-stream/AppStream/x86_64/os/Packages/>

    Files are downloaded and extracted via [gcc-toolset-12.sh](files/gcc-toolset-12.sh), and post-processed with `cd gcc-toolset-12;rsync -a --exclude='opt/' opt/rh/gcc-toolset-12/root/ .`.

[^selscan]: **selscan**

    See <https://cambridge-ceu.github.io/csd3/applications/selscan.html>.

[^angsd]: **angsd**

    See <https://cambridge-ceu.github.io/csd3/applications/angsd.html>.

[^hapstat]: **hapstat**

    See <https://cambridge-ceu.github.io/csd3/applications/hapstat.html>.

[^relate]: **relate**

    See <https://cambridge-ceu.github.io/csd3/applications/relate.html>.

[^clues2]: **clues2**

    Somewhat confusing, the software has been called CLUES2 and detailed in <https://cambridge-ceu.github.io/csd3/applications/clues2.html>.

[^fsc2]: **fastsimcoal2**

    See <https://cambridge-ceu.github.io/csd3/applications/fsc2.html>.

[^jbig2enc]: **jbig2enc**

    ```bash
    module load ceuadmin/leptonica/1.85.0
    wget -qO- https://github.com/agl/jbig2enc/archive/refs/tags/0.30.tar.gz | tar xvfz -
    cd jbig2enc-0.30/src
    ln -s $INCLUDE/loptonica
    cd -
    module load ceuadmin/autoconf/2.72c.24-8e728
    ./autogen.sh
    ./configure --prefix=$CEUADMIN/jbig2enc/0.30
    make
    make install
    ```

    Note that 1. A more recent autoconf is required, 2. Although ceuadmin/leptonica has the correct setup, the -I flag still requires specified explicitly -- the easiest is to create a symbolic link and modify jbig2enc.cc at line 26 to use it locally.

[^pngquant]: **pngquant**

    ```bash
    wget -qO- https://pngquant.org/pngquant-linux.tar.bz2 | tar xjf -
    ```

[^mitoscape]: **MitoScape**

    See <https://cambridge-ceu.github.io/csd3/applications/mitoscape.html>.

[^mity]: **mity**

    See <https://cambridge-ceu.github.io/csd3/applications/mity.html>.

[^delphi]: **delphi**

    See <https://cambridge-ceu.github.io/csd3/Python/delphi.html>.

[^gcc]: **gcc**

    This is furnished as follows,

    ```bash
    wget https://mirrors.kernel.org/gcc/gcc-12.1.0/gcc-12.1.0.tar.xz
    tar xf gcc-12.1.0.tar.xz
    cd gcc-12.1.0
    ./contrib/download_prerequisites
    mkdir ../gcc-build
    cd ../gcc-build
    ../gcc-12.1.0/configure --prefix=$CEUADMIN/gcc/12.1.0 \
      --disable-multilib \
      --enable-languages=c,c++ \
      --disable-bootstrap \
      --disable-libssp \
      --disable-libquadmath \
      --disable-libvtv \
      --disable-libsanitizer
    module load gettext/0.21/gcc/qnrcglqo
    make -j5
    ```

    Note this module enables compilation of Firefox nightly (145.0a1) as dated here.

[^wasi]: **WASI-sdk**

    ```bash
    wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-20/wasi-sdk-20.0-linux.tar.gz
    tar -xzf wasi-sdk-20.0-linux.tar.gz
    ```

[^patchelf]: **patchelf**

    This turns out to be a replica of module made on 10/06/2024.

    ```bash
    module load ceuadmin/autoconf
    wget -qO- https://github.com/NixOS/patchelf/releases/download/0.18.0/patchelf-0.18.0-x86_64.tar.gz | \
    tar -xzf -
    cd patchelf-0.18.0
    ./bootstrap.sh
    ./configure --prefix=$CEUADMIN/patchelf/0.18.0
    make -j4
    make install
    ```

[^glibc]: **glibc**

    ```bash
    wget -qO- https://kojipkgs.fedoraproject.org/packages/glibc/2.30/5.fc31/x86_64/glibc-2.30-5.fc31.x86_64.rpm | \
    mkdir glibc-2.30-5
    cd glibc-2.30-5/
    rpm2cpio ../glibc-2.30-5.fc31.x86_64.rpm | cpio -idmv
    ```

[^ccphylo]: **ccphylo**

    ccphylo tree test.phy.gz > test.nwk

    to be viewed ![](files/ccphylo.svg) from <https://itol.embl.de>, <https://phylo.io> or Python

    ```python
    from Bio import Phylo
    import matplotlib.pyplot as plt

    tree = Phylo.read("test.nwk", "newick")
    Phylo.draw(tree)
    plt.show()
    ```

[^postman]: **postman**

    See <https://cambridge-ceu.github.io/csd3/applications/postman.html>.

[^fresh]: **fresh**

    See <https://cambridge-ceu.github.io/csd3/applications/fresh.html>.

[^gemini]: **gemini-cli**

    See <https://cambridge-ceu.github.io/csd3/applications/gemini-cli.html>.

[^gcloud]: **gcloud**

    See <https://cambridge-ceu.github.io/csd3/applications/gcloud.html>.

[^go]: **go**

    ```bash
    wget -qO- https://go.dev/dl/go1.25.6.linux-amd64.tar.gz | \
    tar xfz -
    ```
    so it is straightforward.

[^libarrow]: **libarrow**

    ```bash
    module load gcc/11.3.0/gcc/4zpip55j
    wget -qO- https://github.com/apache/arrow/archive/refs/tags/apache-arrow-23.0.0.tar.gz | \
    tar xfz -
    cd arrow-apache-arrow-23.0.0/cpp
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=$CEUADMIN/libarrow/23.0.0 \
          -DCMAKE_BUILD_TYPE=Release \
          ..
    make -j4
    make install
    ```

    Since arrow/23.0.0 requires C++20, we have

    ```bash
    module load ceuadmin/gcc/12.1.0
    cmake .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$CEUADMIN/libarrow/23.0.0 \
      -DARROW_CSV=ON \
      -DARROW_FILESYSTEM=ON \
      -DARROW_PARQUET=ON \
      -DARROW_BUILD_SHARED=ON \
      -DCMAKE_CXX_STANDARD=20
    ```
