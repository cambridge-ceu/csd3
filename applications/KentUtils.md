---
sort: 36
---

# KentUtils

This is part of the Kent utilities in module `kentutils-302.1-gcc-5.4.0-kbiujaa` nevertheless without the appropriate chain file.

To download the latest utilitiess, try `rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./`.

The most notable is liftOver from UCSC here, [https://genome.ucsc.edu/cgi-bin/hgLiftOver](https://genome.ucsc.edu/cgi-bin/hgLiftOver).

## bigWig utilities

Description, <https://genome.ucsc.edu/goldenPath/help/bigWig.html>

This is used to view bigWig file, e.g.,

```bash
bigWigInfo LINSIGHT.bw
bigWigToBedGraph -chrom=chr1 -start=11200 -end=20000 LINSIGHT.bw chr1:11200-20000.txt
```

## liftOver

### A toy example

Suppose we have `r6-b38-A2.bed`,

```
#CHROM	start	end	SNP
chr1	841851	841852	1:841852:C:T
chr1	856472	856473	1:856473:G:A
chr1	858951	858952	1:858952:G:A
chr1	859841	859842	1:859842:C:G
chr1	863420	863421	1:863421:G:A
chr1	863578	863579	1:863579:G:A
chr1	864118	864119	1:864119:T:C
chr1	866155	866156	1:866156:T:G
chr1	866280	866281	1:866281:C:T
```

To convert back to b37, our syntax is as follows,

```bash
liftOver r6-b38-A2.bed hg38ToHg19.over.chain.gz r6-b37-A2.bed r6-b37-A2.unlifted.bed
```

with `r6-b37-A2.bed` containing these lines,

```
chr1	777231	777232	1:841852:C:T
chr1	791852	791853	1:856473:G:A
chr1	794331	794332	1:858952:G:A
chr1	795221	795222	1:859842:C:G
chr1	798800	798801	1:863421:G:A
chr1	798958	798959	1:863579:G:A
chr1	799498	799499	1:864119:T:C
chr1	801535	801536	1:866156:T:G
chr1	801660	801661	1:866281:C:T
```

### A real application

The first few lines of our input file, `gtex_cis_etls_alltissues_b38.gz`, are listed as follows,

```
gene_id	num_var	beta_shape1	beta_shape2	true_df	pval_true_df	chr	pos	ref	alt	tss_distance	minor_allele_samples	minor_allele_count	maf	ref_factor	pval_nominal	slope	slope_se	pval_perm	pval_beta	rank	tissue	SNP
ENSG00000227232.5	1364	1.02984	294.487	455.958	6.29063e-08	chr1	64764	C	T	35211	70	71	0.0611015	1	1.01661e-08	0.586346	0.100677	9.999e-05	1.32112e-05	1	Adipose_Subcutaneous	chr1_64764_C_T_b38
ENSG00000269981.1	1868	1.0494	358.23	449.483	0.000308725	chr1	108826	G	C	-29139	40	40	0.0344234	1	0.000119525	0.431229	0.111226	0.0926907	0.0917911	1	Adipose_Subcutaneous	chr1_108826_G_C_b38
ENSG00000241860.6	2066	1.05338	383.252	448.902	1.40124e-05	chr1	14677	G	A	-159185	60	60	0.0516351	1	3.65408e-06	0.604055	0.129028	0.00329967	0.00395793	1	Adipose_Subcutaneous	chr1_14677_G_A_b38
ENSG00000241860.6	2066	1.0289	396.232	452.737	0.000183718	chr1	17722	A	G	-156140	19	19	0.0163511	1	7.18231e-05	0.86963	0.217243	0.0625937	0.0642549	2	Adipose_Subcutaneous	chr1_17722_A_G_b38
ENSG00000279457.4	2234	1.04051	412.351	448.342	7.805e-07	chr1	599167	G	A	403756	50	51	0.0438898	1	1.36949e-07	-0.681414	0.127498	0.00019998	0.000228269	1	Adipose_Subcutaneous	chr1_599167_G_A_b38
```

which are subject to the following script

```bash
#!/usr/bin/bash

module load ceuadmin/KentUtils/2022-11-14
export chain_file=~/rds/public_databases/software/bin/hg38ToHg19.over.chain.gz

cat <(echo -e "#CHROM\tstart\tend\tid") \
    <(gunzip -c gtex_cis_etls_alltissues_b38.gz | \
      awk -v OFS="\t" 'NR>1{print $7,$8,$8,$1"-"$22"-"$23}') > b38.bed
liftOver b38.bed $chain_file b37.bed b37-unlifted.bed
cat <(echo -e "#CHROM\tpos37\t" | paste - <(gunzip -c gtex_cis_etls_alltissues_b38.gz | head -1)) \
    <(awk '{print $4,$1,$2,$3}' b37.bed | \
      sort -k1,1 | \
      join - <(gunzip -c gtex_cis_etls_alltissues_b38.gz | awk 'NR>1{$1=$1"-"$22"-"$23 "\t" $1;print}' | sort -k1,1) | \
      tr ' ' '\t' | \
      cut -f1,4 --complement | \
      sort -k1,1 -k2,2n) | \
bgzip -f > gtex_cis_etls_alltissues_b37.gz
tabix -S1 -s1 -b2 -e2 gtex_cis_etls_alltissues_b37.gz
```

for an output file `gtex_cis_etls_alltissues_b37.gz` with these,

```
#CHROM	pos37		gene_id	num_var	beta_shape1	beta_shape2	true_df	pval_true_df	chr	pos	ref	alt	tss_distance	minor_allele_samples	minor_allele_count	maf	ref_factor	pval_nominal	slope	slope_se	pval_perm	pval_beta	rank	tissue	SNP
chr1	14677	ENSG00000228327.3	4834	1.01655	782.917	245.807	2.03768e-06	chr1	14677	G	A	-763949	29	29	0.0439394	1	5.55759e-07	0.580304	0.113164	0.00129987	0.00142281	2	Esophagus_Gastroesophageal_Junction	chr1_14677_G_A_b38
chr1	14677	ENSG00000228327.3	4834	1.01886	759.054	222.179	1.07156e-05	chr1	14677	G	A	-763949	24	24	0.0393443	1	3.14814e-06	0.784703	0.164529	0.00489951	0.00733826	2	Pancreas	chr1_14677_G_A_b38
chr1	14677	ENSG00000228327.3	4834	1.02493	667.097	121.685	1.39526e-06	chr1	14677	G	A	-763949	20	20	0.0571429	1	3.69825e-07	1.01642	0.190059	0.00079992	0.000773417	1	Brain_Frontal_Cortex_BA9	chr1_14677_G_A_b38
chr1	14677	ENSG00000228327.3	4834	1.02538	717.947	387.192	1.1425e-08	chr1	14677	G	A	-763949	46	46	0.0446602	1	1.0209e-09	0.607113	0.0972857	9.999e-05	6.02735e-06	2	Lung	chr1_14677_G_A_b38
chr1	14677	ENSG00000228327.3	4834	1.0307	761.357	343.977	1.06967e-05	chr1	14677	G	A	-763949	45	45	0.0483871	1	2.6754e-06	0.397244	0.0833788	0.00629937	0.00690477	3	Esophagus_Muscularis	chr1_14677_G_A_b38
```

Note that to facilitate lookup it is sorted by chromosome and position instead.
