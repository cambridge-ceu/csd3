---
sort: 16
---

# hail

Web: [https://hail.is/](https://hail.is/) as with [hail on cloud](https://github.com/danking/hail-cloud-docs/blob/master/how-to-cloud.md).

## Preparations

We will need to set up an virtual environment as follows,

```bash
module load python/3.7 hadoop/2.7.7
virtualenv py37
source py37/bin/activate
```

Later, only two of the commands are necessary, i.e.,

```bash
module load python/3.7 hadoop/2.7.7
source py37/bin/activate
```

## Installation

We proceed with,

```bash
pip install hail
pip install gnomAD
pip install pyensembl
pip install varcode
pyensembl install --release 99 --species human
```

where `gnomAD, `pyensembl` ([https://github.com/openvax/pyensembl](https://github.com/openvax/pyensembl)) and `varcode` ([https://github.com/openvax/varcode](https://github.com/openvax/varcode)) are optional, and we could invoke Python as follows,

```python
python
>>> import hail as hl
>>> mt = hl.balding_nichols_model(n_populations=3, n_samples=50, n_variants=100)
>>> mt.describe()
>>> mt.summarize()
>>> mt.count()
>>> mt.show()
>>> mt.write("hail")
>>> at = hl.import_vcf("INTERVAL.vcf.bgz")
>>> hl.export_vcf(at,"at.vcf.bgz")
```

Alternatively, we could also start a session using `ipython`.

## Tutorials

We can get the tutorials at the current directory,

```bash
wget -qO- https://hail.is/docs/0.2/tutorials.tar.gz | tar xf -
```

and cut/paste code from the hail website to our command-line session. A better quality can be achieved with a browser, which unfortunately does not function so well on csd3 and requires some tweak from elsewhere,

First, from a csd3 session we issue commands,

```bash
hostname
jupyter notebook tutorials/ --ip=127.0.0.1 --no-browser --port 8081
```

and for this instance we have `hostname` as `login-e-12` and additional information as follows,

```
[I 20:21:59.258 NotebookApp] Serving notebooks from local directory: /rds/project/jmmh2/rds-jmmh2-results/public/gwas/ukb_exomes/tutorials
[I 20:21:59.258 NotebookApp] The Jupyter Notebook is running at:
[I 20:21:59.258 NotebookApp] http://127.0.0.1:8081/?token=2d4ba02d3d0d782ad1dbafc73f96a3fc3d0bdff4573899c9
[I 20:21:59.258 NotebookApp]  or http://127.0.0.1:8081/?token=2d4ba02d3d0d782ad1dbafc73f96a3fc3d0bdff4573899c9
[I 20:21:59.258 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 20:21:59.300 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///home/jhz22/.local/share/jupyter/runtime/nbserver-235186-open.html
    Or copy and paste one of these URLs:
        http://127.0.0.1:8081/?token=2d4ba02d3d0d782ad1dbafc73f96a3fc3d0bdff4573899c9
     or http://127.0.0.1:8081/?token=2d4ba02d3d0d782ad1dbafc73f96a3fc3d0bdff4573899c9
```

from a console other than a csd3 session (e.g., from a `srcf` or `ds` or Windows `virtualbox` virtual machine) we access the csd3 session above.

```bash
ssh -4 -L 8081:127.0.0.1:8081 -fN login-e-12.hpc.cam.ac.uk
firefox http://127.0.0.1:8081/?token=2d4ba02d3d0d782ad1dbafc73f96a3fc3d0bdff4573899c9
```

and run the tutorial from firefox. Similar process is also described at the system/software section on Python.

For convenience, we list the code from the tutorials on 1000Genomes data, see https://notebook.community/danking/hail/notebook/images/hail/resources/Hail-Workshop-Notebook.

```python
import hail as hl
import os
dir=os.environ['HPC_WORK']+"/lib64/"
files=dir+"libblas.so:"+dir+"libcblas.so:"+dir+"liblapack.so"
print(files)
# os.environ['PYENSEMBL_CACHE_DIR'] = '/custom/cache/dir'
hl.init(spark_conf={"spark.executor.extraClassPath": files})
# 1000Genomes data from the tutorials
sa = hl.import_table('tutorials/data/1kg_annotations.txt', impute=True, key='Sample')
sa.describe()
sa.show()
mt = hl.read_matrix_table('tutorials/data/1kg.mt')
mt = mt.annotate_rows(gene_info = gene_ht[mt.locus])
mt.s.show(5)
mt.locus.show(5)
hl.summarize_variants(mt)
mt = mt.annotate_cols(pheno = sa[mt.s])
mt = hl.sample_qc(mt)
mt.sample_qc.describe()
p = hl.plot.scatter(x=mt.sample_qc.r_het_hom_var,
                    y=mt.sample_qc.call_rate)
show(p)
mt = mt.filter_cols(mt.sample_qc.dp_stats.mean >= 4)
mt = mt.filter_cols(mt.sample_qc.call_rate >= 0.97)
mt.aggregate_entries(hl.agg.fraction(hl.is_defined(mt.GT)))
ab = mt.AD[1] / hl.sum(mt.AD)
filter_condition_ab = (
    hl.case()
    .when(mt.GT.is_hom_ref(), ab <= 0.1)
    .when(mt.GT.is_het(), (ab >= 0.25) & (ab <= 0.75))
    .default(ab >= 0.9) # hom-var
)
mt = mt.filter_entries(filter_condition_ab)
mt.aggregate_entries(hl.agg.fraction(hl.is_defined(mt.GT)))
mt = hl.variant_qc(mt)
mt.variant_qc.describe()
mt.variant_qc.AF.show()
mt = mt.filter_rows(hl.min(mt.variant_qc.AF) > 1e-6)
mt = mt.filter_rows(mt.variant_qc.p_value_hwe > 0.005)
gene_ht = hl.import_table('tutorials/data/ensembl_gene_annotations.txt', impute=True)
gene_ht.show()
gene_ht.count()
gene_ht = gene_ht.transmute(interval = hl.locus_interval(gene_ht['Chromosome'],
                                                         gene_ht['Gene start'],
                                                         gene_ht['Gene end'], 
                                                         reference_genome='GRCh37'))
gene_ht = gene_ht.key_by('interval')
mt = mt.annotate_rows(gene_info = gene_ht[mt.locus])
mt.gene_info.show()
burden_mt = (
    mt
    .group_rows_by(gene = mt.gene_info['Gene name'])
    .aggregate(n_variants = hl.agg.count_where(mt.GT.n_alt_alleles() > 0))
)
burden_mt.describe()
pca_eigenvalues, pca_scores, pca_loadings = hl.hwe_normalized_pca(mt.GT, compute_loadings=True)
pca_eigenvalues
pca_scores.describe()
pca_scores.scores[0].show()
pca_loadings.describe()
mt = mt.annotate_cols(pca = pca_scores[mt.s])
p = hl.plot.scatter(mt.pca.scores[0], 
                    mt.pca.scores[1],
                    label=mt.pheno.SuperPopulation)
show(p)
# errors from here though hl.init() above
# https://discuss.hail.is/t/undefined-symbol-cblas-dgemm/1488
gwas = hl.linear_regression_rows(y=mt.pheno.CaffeineConsumption, 
                                 x=mt.GT.n_alt_alleles(), 
                                 covariates=[1.0])
gwas.describe()
p = hl.plot.manhattan(gwas.p_value)
show(p)
p = hl.plot.qq(gwas.p_value)
show(p)
gwas = hl.linear_regression_rows(
    y=mt.pheno.CaffeineConsumption, 
    x=mt.GT.n_alt_alleles(),
    covariates=[1.0, mt.pheno.isFemale, mt.pca.scores[0], mt.pca.scores[1], mt.pca.scores[2]])```
```

## Resources

Some files can be made available with `gsutil` installed, e.g.,

* The HGDP release 3.1, `gs://gcp-public-data--gnomad/release/3.1`.
  * See also, `gs://gnomad-public/release`.
* UK Biobank results, `gs://hail-datasets/ukbb_imputed_v3_gwas_results_both_sexes.GRCh37.mt`.
* Pan-ancestry genetic analysis of the UK Biobank, [https://pan.ukbb.broadinstitute.org/docs/hail-format](https://pan.ukbb.broadinstitute.org/docs/hail-format).
* Exome-based association statistics, see below.

## genebass

Web: [https://genebass.org/](https://genebass.org/)

### Download

```bash
# genebass and csd3 locations
export src=gs://ukbb-exome-public/300k/results
export dest=~/rds/results/public/gwas/ukb_exomes
mkdir -p ${dest}
cd ${dest}
# Gene burden results
gsutil -m cp -r ${src}/results.mt .
# Single variant association results
gsutil -m cp -r ${src}/variant_results.mt .
```

### Access

We could run the script directly as follows,

```bash
cd ~/rds/results/public/gwas/ukb_exomes
python <<END

import hail as hl

# Gene (burden) results
gr = hl.read_matrix_table('results.mt')

## Summaries
gr.count()
gr.describe()
gr.show()
gr.cols().show()
gr.rows().show()
gr.entry.take(5)
gr.summarize()

## filtering
FGR = gr.filter_rows(gr.gene_symbol=="FGR")
FGR1065 = FGR.filter_cols(FGR.coding == '1065')
FGR1065burden = FGR1065.select_entries(FGR1065.BETA_Burden)

## col operations
trait_gr = gr.cols().collect_by_key()
trait_gr.group_by('trait_type').aggregate(n_phenos=hl.agg.count()).show()
gr_cols = gr.cols()
gr_cols.count()
gr_cols.show(truncate=40, width=85)
gr_cols.phenocode.show()
gr_cols.filter(gb_cols.phenocode == '1777').show()
fields_to_drop = ['category', 'coding_description', 'description_more', 'inv_normalized',
                  'n_cases_both_sexes', 'n_cases_females', 'n_cases_males', 'saige_version']
gr_cols_reduced=gb_cols.drop(*fields_to_drop)

# Variant results
vr = hl.read_matrix_table('variant_results.mt')
vr.count()
vr.describe()
vr.select_cols().show(1)
vr.select_rows().show(1)
vr.locus.show(1)
hl.summarize_variants(vr)

# IL12B
END
```
