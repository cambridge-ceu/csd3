---
sort: 4
---

# ANNOVAR

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
