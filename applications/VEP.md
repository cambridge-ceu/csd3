---
sort: 46
---

# VEP

Official page: [https://www.ensembl.org/info/docs/tools/vep/index.html](https://www.ensembl.org/info/docs/tools/vep/index.html)
([web interface](https://www.ensembl.org/Tools/VEP)).

Detailed instructions for installation are available from here,

[http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#installer](http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#installer).

There are several possible ways to install under csd3: GitHub, R and docker.

## --- GitHub ---

GitHub Page: [https://github.com/Ensembl/ensembl-vep](https://github.com/Ensembl/ensembl-vep).

The ease with this option lies with GitHub in that updates can simply be made with `git pull` to an exisiting release.

```bash
cd $HPC_WORK
git clone https://github.com/Ensembl/ensembl-vep.git
cd ensembl-vep
# ---
# release/98
# module load htslib/1.4
# perl INSTALL.pl
# release/104
# long form:
# perl INSTALL.pl --DESTDIR Bio --ASSEMBLY GRCh38 --AUTO acfp --PLUGINS all --SPECIES homo_sapiens,homo_sapiens_merged --NO_TEST --CACHEDIR .vep
# ---
module load htslib-1.9-gcc-5.4.0-p2taavl
# short form:
perl INSTALL.pl -l Bio -y GRCh38 -a acfp -g all -s homo_sapiens,homo_sapiens_merged --NO_TEST -c .vep
ln -sf $HPC_WORK/ensembl-vep/.vep $HOME/.vep
# set up symbolic links to the executables
for f in convert_cache.pl filter_vep haplo variant_recoder vep;
    do ln -sf $HPC_WORK/ensembl-vep/$f $HPC_WORK/bin/$f; done
vep -i examples/homo_sapiens_GRCh37.vcf -o examples/homo_sapiens_GRCh37.txt \
    --force_overwrite --offline --pick --symbol
```

A (slightly edited due to two species at -s were installed separately) log file can be found here, [VEP.log](files/VEP.log).

Note in particular that by default, the cache files will be installed at $HOME which would exceed the quota (<40GB) of an ordinary user,
and as before the destination was redirected. The setup above facilitates storage of cache files, FASTA files and plugins.

> The FASTA file should be automatically detected by the VEP when using --cache or --offline.

> If it is not, use "--fasta $HOME/.vep/homo_sapiens/98_GRCh37/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa"

> Remember to use --merged or --refseq when running the VEP with \_merged or \_refseq cache!

Without the htslib module, the `--NO_HTSLIB` option is needed but "Cannot use format gff without Bio::DB::HTS::Tabix module installed".
Bio::DB:HTS is in [https://github.com/Ensembl/Bio-DB-HTS](https://github.com/Ensembl/Bio-DB-HTS) and change can be made to the `Makefile` of htslibs for a desired location, to be
used by `Build.PL` via its command line parameters.

It is notable that VEP accepts compress (.gz) input. It is worthwhile to check for the VEP plugins: [https://github.com/Ensembl/VEP_plugins](https://github.com/Ensembl/VEP_plugins). For instance, to enable the PolyPhen_SIFT plugin we first generate the database and then annotate locally.

```bash
cd ${HPC_WORK}
git clone https://github.com/Ensembl/VEP_plugins
cd VEP_plugins
# download of database
vep --database --port 3337 --force_overwrite --dir_plugin . --plugin PolyPhen_SIFT,create_db=1
# offline annotation
vep -i homo_sapiens_GRCh37.vcf -o homo_sapiens_GRCh37 --offline --force_overwrite --format vcf --dir_plugin . --plugin PolyPhen_SIFT
```

By default, the database port number is 5306. The `create_db=1` option downloads `homo_sapiens.PolyPhen_SIFT.db` at `${HOME}/.vep`.

One may wish to skip the comments (lines started with ##) in processing of the output, e.g., in R,

```bash
export skips=$(grep '##' examples/homo_sapiens_GRCh37.txt | wc -l)
R --no-save -q <<END
  vo <- read.delim("examples/homo_sapiens_GRCh37.txt",skip=as.numeric(Sys.getenv("skips")))
  head(vo)
END
```

allowing for variable number of lines given various command-line options to be skipped to have

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

When a particular release really works well on the system, it is possible to install it, e.g.,

```
git checkout release/98
perl INSTALL.pl
```

for release 98 instead of the latest from `git pull`.

It could be useful to filter VEP output, see [https://www.ensembl.org/info/docs/tools/vep/script/vep_filter.html](https://www.ensembl.org/info/docs/tools/vep/script/vep_filter.html).

### **Nearest gene**

This can produces error message

```
-------------------- EXCEPTION --------------------
MSG: ERROR: --nearest requires Set::IntervalTree perl module to be installed
```

and we get around with

```bash
perl -MCPAN -e shell
install Set::IntervalTree
```

which will enable `--nearest gene`.

### **Annotation in chunks**

A toy example, following [http://www.ensembl.org/info/docs/tools/vep/script/vep_other.html#faster](http://www.ensembl.org/info/docs/tools/vep/script/vep_other.html#faster), is given as follows,

```bash
cd examples
bgzip -f homo_sapiens_GRCh37.vcf
tabix -Cf homo_sapiens_GRCh37.vcf.gz
tabix -h  homo_sapiens_GRCh37.vcf.gz 22:50616005-50616006 | \
vep --cache --fork 4 --port 3337 --format vcf -o - --tab --no_stats | \
grep -v '##'
cd -
```

from this we could propagate the idea for autosomes in chunks as follows,

```bash
export ref=~/rds/post_qc_data/interval/reference_files/genetic/reference_files_genotyped_imputed/
export chunk_size=10000
seq 22 | \
parallel -j1 --env ref -C' ' '
  export n=$(awk "END{print NR-1}" ${ref}/impute_{}_interval.snpstats)
  export g=$(expr ${n} / ${chunk_size})
  export s=$(expr $n - $(( $g * $chunk_size)))
  (
    for i in $(seq ${g}); do
      (
        awk "BEGIN{print \"##fileformat=VCFv4.0\"}"
        awk -vOFS="\t" "BEGIN{print \"#CHROM\",\"POS\",\"ID\",\"REF\",\"ALT\",\"QUAL\",\"FILTER\",\"INFO\"}"
        (
          sed "1d" ${ref}/impute_{}_interval.snpstats | \
          awk -v i=${i} -v chunk_size=${chunk_size} -v OFS="\t" "NR==(i-1)*chunk_size+1,NR==i*chunk_size {
              if(\$1==\".\") \$1=\$3+0 \":\" \$4 \"_\" \$5 \"/\" \$6; print \$3+0,\$4,\$1,\$5,\$6,\".\",\".\",\$19}"
          if [ ${s} -gt 0 ] &&  [ ${i} -eq ${g} ]; then
             sed "1d" ${ref}/impute_{}_interval.snpstats | \
             awk -v i=${i} -v chunk_size=${chunk_size} -v OFS="\t" -v n=${n} "NR==i*chunk_size+1,NR==n {
                 if(\$1==\".\") \$1=\$3+0 \":\" \$4 \"_\" \$5 \"/\" \$6; print \$3+0,\$4,\$1,\$5,\$6,\".\",\".\",\$19}"
          fi
        )
      ) | \
      vep  --cache --offline --format vcf -o - --tab --pick --no_stats  \
           --species homo_sapiens --assembly GRCh37 --port 3337 | \
      (
        if [ ${i} -eq 1 ]; then cat; else grep -v "#"; fi
      )
    done
  ) | \
  gzip -f > work/INTERVAL-{}.vep.gz
'
```

Note we use information from `.snpstats` files at location `ref` to build input in vcf format on the fly and feed into VEP. For instance `impute_22_interval.snpstats` contains the following lines,

```
SNPID	RSID	chromosome	position	A_allele	B_allele	minor_allele	major_allele	AA	AB	BB	AA_calls	AB_calls	BB_calls	MAF	HWE	missing	missing_calls	information
rs587697622	rs587697622	22	16050075	A	G	G	A	43058	1.2499	0	43058	1	0	1.4514e-05	-0	0	0	0.81003
rs587755077	rs587755077	22	16050115	G	A	A	G	42485	572.42	1.7625	42105	306	1	0.0066878	0.14341	3.5437e-09	0.015026	0.68672
rs587654921	rs587654921	22	16050213	C	T	T	C	42848	211.12	0.16248	42746	124	0	0.0024553	-0	1.4175e-09	0.0043893	0.67168
rs587712275	rs587712275	22	16050319	C	T	T	C	43022	36.998	0	43022	23	0	0.00042962	-0	0	0.00032514	0.69071
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

The aligment of ENSG, ENST, ENSP is `ensGtp.txt.gz` at the same UCSC directory above.

Other possibilities include UCSC/ensembl MySQL server, e.g.,

```bash
mysql  --user=genome --host=genome-mysql.cse.ucsc.edu -A -D hg19 <<END
select distinct G.gene,N.value from ensGtp as G, ensemblToGeneName as N where
   G.transcript=N.name and
   G.gene in ("ENSG00000160712");
END
```

and

```bash
mysql -h ensembldb.ensembl.org --port 5306  -u anonymous -D homo_sapiens_core_64_37 -A <<END
select distinct
   G.stable_id,
   S.synonym
from
  gene_stable_id as G,
  object_xref as OX,
  external_synonym as S,
  xref as X ,
  external_db as D
where
  D.external_db_id=X.external_db_id and
  X.xref_id=S.xref_id and
  OX.xref_id=X.xref_id and
  OX.ensembl_object_type="Gene" and
  G.gene_id=OX.ensembl_id and
  G.stable_id in ("ENSG00000160712");
END
```

according to [https://www.biostars.org/p/14367/](https://www.biostars.org/p/14367/).

Perhaps it is the easiest to use `gprofiler2`, i.e.,

```r
gprofiler2::gconvert("ENSG00000164761")
```

giving

```
  input_number input target_number          target name                                               description                           namespace
1            1  IL6R           1.1 ENSG00000160712 IL6R interleukin 6 receptor [Source:HGNC Symbol;Acc:HGNC:6019] ENTREZGENE,HGNC,UNIPROT_GN,WIKIGENE
```

### **clinvar**

Web: [https://ftp.ncbi.nlm.nih.gov/pub/clinvar/](https://ftp.ncbi.nlm.nih.gov/pub/clinvar/).

The local installation enables considerable flexibilty, based on
[https://www.ensembl.org/info/docs/tools/vep/script/vep_custom.html#custom_options](https://www.ensembl.org/info/docs/tools/vep/script/vep_custom.html#custom_options).

```bash
# Compressed VCF file/Index file
# GCRh37
curl ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/clinvar.vcf.gz -o clinvar_GRCh37.vcf.gz
curl ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/clinvar.vcf.gz.tbi -o clinvar_GRCh37.vcf.gz.tbi
# GCRh38
curl ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/clinvar.vcf.gz -o clinvar_GRCh38.vcf.gz
curl ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/clinvar.vcf.gz.tbi -o clinvar_GRCh38.vcf.gz.tbi
```

Information is gathered from the header of the VCF file,

| ClinVar Variation ID | Description                                                                                                                                                                                                                                                             |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| AF_ESP               | allele frequencies from GO-ESP                                                                                                                                                                                                                                          |
| AF_EXAC              | allele frequencies from ExAC                                                                                                                                                                                                                                            |
| AF_TGP               | allele frequencies from TGP                                                                                                                                                                                                                                             |
| ALLELEID             | the ClinVar Allele ID                                                                                                                                                                                                                                                   |
| CLNDN                | ClinVar's preferred disease name for the concept specified by disease identifiers in CLNDISDB                                                                                                                                                                           |
| CLNDNINCL            | For included Variant : ClinVar's preferred disease name for the concept specified by disease identifiers in CLNDISDB                                                                                                                                                    |
| CLNDISDB             | Tag-value pairs of disease database name and identifier, e.g. OMIM:NNNNNN                                                                                                                                                                                               |
| CLNDISDBINCL         | For included Variant: Tag-value pairs of disease database name and identifier, e.g. OMIM:NNNNNN                                                                                                                                                                         |
| CLNHGVS              | Top-level (primary assembly, alt, or patch) HGVS expression.                                                                                                                                                                                                            |
| CLNREVSTAT           | ClinVar review status for the Variation ID                                                                                                                                                                                                                              |
| CLNSIG               | Clinical significance for this single variant                                                                                                                                                                                                                           |
| CLNSIGCONF           | Conflicting clinical significance for this single variant                                                                                                                                                                                                               |
| CLNSIGINCL           | Clinical significance for a haplotype or genotype that includes this variant. Reported as pairs of VariationID:clinical significance.                                                                                                                                   |
| CLNVC                | Variant type                                                                                                                                                                                                                                                            |
| CLNVCSO              | Sequence Ontology id for variant type                                                                                                                                                                                                                                   |
| CLNVI                | the variant's clinical sources reported as tag-value pairs of database and variant identifier                                                                                                                                                                           |
| DBVARID              | nsv accessions from dbVar for the variant                                                                                                                                                                                                                               |
| GENEINFO             | Gene(s) for the variant reported as gene symbol:gene id. The gene symbol and id are delimited by a colon (:) and each pair is delimited by a vertical bar (                                                                                                             | )                     |
| MC                   | comma separated list of molecular consequence in the form of Sequence Ontology ID                                                                                                                                                                                       | molecular_consequence |
| ORIGIN               | Allele origin. One or more of the following values may be added: 0 - unknown; 1 - germline; 2 - somatic ; 4 - inherited; 8 - paternal; 16 - maternal; 32 - de-novo; 64 - biparental; 128 - uniparental; 256 - not-tested; 512 - tested-inconclusive; 1073741824 - other |
| RS                   | dbSNP ID (i.e. rs number)                                                                                                                                                                                                                                               |
| SSR                  | Variant Suspect Reason Codes. One or more of the following values may be added: 0 - unspecified, 1 - Paralog, 2 - byEST, 4 - oldAlign, 8 - Para_EST, 16 - 1kg_failed, 1024 - other                                                                                      |

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

### **dbNSFP**

Web page: [https://sites.google.com/site/jpopgen/dbNSFP](https://sites.google.com/site/jpopgen/dbNSFP).

This is set up as follows,

```bash
wget ftp://dbnsfp:dbnsfp@dbnsfp.softgenetics.com/dbNSFP4.1a.zip
unzip dbNSFP4.1a.zip -d dbNSFP4.1a
cd dbNSFP4.1a
# code for 4.0a
# zcat dbNSFP4.0a_variant.chr1.gz | head -n1 > h
# zgrep -h -v ^#chr dbNSFP4.0a_variant.chr* | sort -k1,1 -k2,2n - | cat h - | bgzip -c > dbNSFP4.0a.gz
# efficient version
(
  zcat dbNSFP4.1a_variant.chr1.gz | head -n1
  export prefix=dbNSFP4.1a_variant.chr
  echo ${prefix}{1..22}.gz ${prefix}M.gz ${prefix}X.gz ${prefix}Y.gz | \
  xargs -I {} bash -c "zcat {} | sed '1d'"
) | bgzip -c > dbNSFP4.1a.gz
tabix -s 1 -b 2 -e 2 dbNSFP4.1a.gz
cd -
vep -i examples/homo_sapiens_GRCh37.vcf -o test --cache --force_overwrite --offline \
    --plugin dbNSFP,dbNSFP4.1a/dbNSFP4.1a.gz,LRT_score,FATHMM_score,MutationTaster_score
```

Since this release is frozen on Ensembl 94's transcript set, one may prefer to use it independently via its Java programs, e.g.,

```bash
java -jar search_dbNSFP41a.jar -i tryhg19.in -o tryhg19.out -v hg19
java -jar search_dbNSFP41a.jar -i tryhg38.in -o tryhg38.out
```

### **GeneSplicer**

Web: [https://ccb.jhu.edu/software/genesplicer/](https://ccb.jhu.edu/software/genesplicer/).

#### Setup

```bash
wget -qO- ftp://ftp.ccb.jhu.edu/pub/software/genesplicer/GeneSplicer.tar.gz | \
tar xvfz -
mv GeneSplicer.pm ~/.vep/Plugins
./vep -i variants.vcf --plugin GeneSplicer,[path_to_genesplicer_bin],[path_to_training_dir],[option1=value],[option2=value]
```

#### Reference

M. Pertea , X. Lin , S. L. Salzberg. GeneSplicer: a new computational method for splice site prediction. Nucleic Acids Res. 2001 Mar 1;29(5):1185-90.

### **loftee**

GitHub page: [https://github.com/konradjk/loftee](https://github.com/konradjk/loftee).

Reference: MacArthur DG et al (2012). A systematic survey of loss-of-function variants in human protein-coding genes. _Science_ 335:823–828

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
# conservation_file -- note the data, schema and GERP files are required only to build the sql file
wget -qO- https://personal.broadinstitute.org/konradk/loftee_data/GRCh37/phylocsf_gerp.sql.gz | \
gunzip -c > phylocsf_gerp.sql
# wget https://www.broadinstitute.org/~konradk/loftee/phylocsf_data.tsv.gz
# wget https://www.broadinstitute.org/~konradk/loftee/phylocsf_data_schema.sql
# wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh37/GERP_scores.final.sorted.txt.gz
# wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh37/GERP_scores.exons.txt.gz
# annotation
vep --id "1 154426970 154426970 A/C 1" --species homo_sapiens -o rs2228145 --cache --offline --force_overwrite \
    --assembly GRCh37 --plugin LoF,loftee_path:.,human_ancestor_fa:human_ancestor.fa.gz,conservation_file:phylocsf_gerp.sql.gz
# VEP documentation example
vep --input_file homo_sapiens_GRCh37.vcf --output_file test --cache --dir_cache ${HPC_WORK}/ensembl-vep/.vep --dir_plugins ${HPC_WORK}/loftee --offline \
    --pick --force_overwrite --species homo_sapiens --assembly GRCh37 \
    --plugin LoF,loftee_path:.,human_ancestor_fa:human_ancestor.fa.gz,conservation_file:phylocsf_gerp.sql
```

If offers implementation for parsing CSQ field but is also possible with R as described below. Note that if loftee_path uses an absolute path, that path should also be within PERL5LIB, e.g.,

```
export PERL5LIB=$PERL5LIB:$HPC_WORK/loftee
```

is put in .bashrc. We see now all files are provided, and there are complaints over rz was not generated by bgzip, so we do

```bash
# error
samtools faidx human_ancestor.fa.rz
# rework
gunzip -c human_ancestor.fa.rz | bgzip -c > output.fa.gz
# check and put it back
ll human_ancestor.fa.rz output.fa.gz
mv output.fa.gz human_ancestor.fa.rz
# now possible and check
samtools faidx human_ancestor.fa.rz
ll human_ancestor.fa.*
```

### **BigWig file**

One can have additional features installed such as JSON, Set::IntervalTree, Bio::DB::BigFile, PerlIO::gzip and ensembl-xs. We exemplify JSON and Bio::DB::BigFile here,

Also see [https://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#bigfile](https://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#bigfile).

```bash
# 1. Download and extract source code
cd $HOME
wget -qO- https://github.com/ucscGenomeBrowser/kent/archive/v335_base.tar.gz | \
tar xzf -
# 2. Set up compiling flags
export KENT_SRC=$HOME/kent-335_base/src
export MACHTYPE=$(uname -m)
export CFLAGS="-fPIC"
export MYSQLINC=`mysql_config --include | sed -e 's/^-I//g'`
export MYSQLLIBS=`mysql_config --libs`
# 3. Amend parameters
cd $KENT_SRC/lib
echo 'CFLAGS="-fPIC"' > ../inc/localEnvironment.mk
# 4. Build library
make clean && make
cd ../jkOwnLib
make clean && make
# 5. On Mac OSX
ln -s $KENT_SRC/lib/x86_64/* $KENT_SRC/lib/
# 6. Install Perl modules
cd ${HPC_WORK}/ensembl-vep
cpan JSON
cpan Bio::DB::BigFile
# 7. Test
perl -Imodules t/AnnotationSource_File_BigWig.t
```

We have from step 7 above

```
ok 1 - use Bio::EnsEMBL::VEP::AnnotationSource::File;
ok 2 - use Bio::EnsEMBL::VEP::AnnotationSource::File::BigWig;
ok 3 - use Bio::EnsEMBL::VEP::Config;
ok 4 - get new config object
ok 5 - new is defined
Couldn't open foo
ok 6 - new with invalid file throws
ok 7 - use Bio::EnsEMBL::VEP::Parser::VCF;
ok 8 - get parser object
ok 9 - use Bio::EnsEMBL::VEP::InputBuffer;
ok 10 - check class
ok 11 - check buffer next
ok 12 - annotate_InputBuffer - overlap
ok 13 - annotate_InputBuffer - exact, additive
ok 14 - annotate_InputBuffer - out by 1 (5')
ok 15 - annotate_InputBuffer - out by 1 (3')
ok 16 - overlap fixedStep
1..16
```

We have the GRCh38 branch, `git clone --depth 1 --branch grch38 https://github.com/konradjk/loftee.git`.

```bash
# GRCh38 files
# wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/gerp_conservation_scores.homo_sapiens.GRCh38.bw
# wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/human_ancestor.fa.gz
# wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/human_ancestor.fa.gz.fai
# wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/human_ancestor.fa.gz.gzi
# wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/loftee.sql.gz

# Annotation
export ENSEMBL=~/rds/rds-jmmh2-public_databases/ensembl-vep
export LOFTEE38=${ENSEMBL}/loftee/loftee_data/GRCh38
export LOFTEE38GERP=${LOFTEE38}/gerp_conservation_scores.homo_sapiens.GRCh38.bw
export LOFTEE38HA=${LOFTEE38}/human_ancestor.fa.gz
export LOFTEE38SQL=${LOFTEE38}/loftee.sql
export rds=..  # ~/rds/rds-jmmh2-public_databases/ensembl-vep will be user-specific
vep --input_file for_VEP.txt --format ensembl --output_file ${rds}/for_VEP_output2.txt --force_overwrite --offline --symbol --merged \
    --fasta Homo_sapiens.GRCh38.dna.toplevel.fa --dir_cache ${rds}/.vep --dir_plugins . \
    --protein --symbol --tsl --canonical --mane_select --biotype --check_existing --sift b --polyphen b \
    --plugin LoF,loftee_path:.,gerp_bigwig:${LOFTEE38GERP},human_ancestor_fa:${LOFTEE38HA},conservation_file:${LOFTEE38SQL}
```

See also [https://docs.databricks.com/applications/genomics/secondary/vep-pipeline.html](https://docs.databricks.com/applications/genomics/secondary/vep-pipeline.html).

### **REVEL**

REVEL: Rare Exome Variant Ensemble Learning

Plugin: [https://m.ensembl.org/info/docs/tools/vep/script/vep_plugins.html#revel](https://m.ensembl.org/info/docs/tools/vep/script/vep_plugins.html#revel)

Data: [https://sites.google.com/site/revelgenomics/downloads](https://sites.google.com/site/revelgenomics/downloads).

#### Setup

```bash
mkdir REVEL
cd REVEL
wget https://rothsj06.u.hpc.mssm.edu/revel-v1.3_all_chromosomes.zip
unzip revel-v1.3_all_chromosomes.zip
cat revel_with_transcript_ids | tr "," "\t" > tabbed_revel.tsv
sed '1s/.*/#&/' tabbed_revel.tsv > new_tabbed_revel.tsv
bgzip new_tabbed_revel.tsv
# GRCh37:
tabix -f -s 1 -b 2 -e 2 new_tabbed_revel.tsv.gz
# GRCh38:
zcat new_tabbed_revel.tsv.gz | head -n1 > h
zgrep -h -v ^#chr new_tabbed_revel.tsv.gz | awk '$3 != "." ' | sort -k1,1 -k3,3n - | cat h - | bgzip -c > new_tabbed_revel_grch38.tsv.gz
tabix -f -s 1 -b 3 -e 3 new_tabbed_revel_grch38.tsv.gz
```

#### Example

```bash
vep --input_file <input> --plugin REVEL,${ENSEMBL}/.vep/Plugins/new_tabbed_revel.tsv.gz
```

#### Reference

Ioannidis NM, et al. REVEL: An ensemble method for predicting the pathogenicity of rare missense variants. _Am J Hum Genet_ 2016; 99(4):877-885. http://dx.doi.org/10.1016/j.ajhg.2016.08.016

## --- R ---

This is a wrapper and `the Ensembl VEP perl script must be installed in your path`. Expected to be slower than the `--offline` mode above, it is
relatively easy to set up,

```r
BiocManager::install("ensemblVEP")
vignette("ensemblVEP")
library(ensemblVEP)
file <- system.file("extdata", "ex2.vcf", package="VariantAnnotation")
param <- VEPFlags(flags=list(vcf=TRUE,check_existing=TRUE,symbol=TRUE,terms="SO",sift="b",polyphen="p"))
vep <- ensemblVEP(file, param)
info(vep)$CSQ
csq <- parseCSQToGRanges(vep)
head(csq, 2)
# clinvar
param <- VEPFlags(flags=list(vcf=TRUE,output_file="clinvar.vcf",force_overwrite=TRUE,assembly="GRCh37",port=3337,
                  custom="clinvar_GRCh37.vcf.gz,ClinVar,vcf,exact,0,CLNSIG,CLNREVSTAT,CLNDN"))
ensemblVEP(file, param)
```

The second `ensemblVEP` obtains `clinvar.vcf` and `clinvar.vcf_summary.html`. Annotation is made to a VCF file, and returns data with unparsed 'CSQ'.

The facility to parse the CSQ column of a VCF object is done for the documentation example.

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

Note that the CSQ field could also be handled by bcftools split-vep plugin, see [http://samtools.github.io/bcftools/howtos/plugin.split-vep.html](http://samtools.github.io/bcftools/howtos/plugin.split-vep.html).

## --- docker ---

See `docker/Dockerfile ` from the GitHub directory above, or [https://github.com/Ensembl/ensembl-vep](https://github.com/Ensembl/ensembl-vep).

## --- Virtual machine ---

See [http://www.ensembl.org/info/data/virtual_machine.html](http://www.ensembl.org/info/data/virtual_machine.html) which is possibly best for MicroSoft Windows and is not pursued here.

ENSEMBL-synonym translation (hg19) file
