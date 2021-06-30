---
sort: 16
---

# hail

## Installation

Web: [https://hail.is/](https://hail.is/) as with [hail on cloud](https://github.com/danking/hail-cloud-docs/blob/master/how-to-cloud.md). We proceed as follows,

```bash
module load python/3.7 hadoop/2.7.7
virtualenv py37
source py37/bin/activate
pip install hail
pip install gnomAD
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

## Resources

Some files can be made available with `gsutil` installed, e.g.,

- The HGDP release 3.1, `gs://gcp-public-data--gnomad/release/3.1` (`gs://gnomad-public/release`).
- UK Biobank results, `gs://hail-datasets/ukbb_imputed_v3_gwas_results_both_sexes.GRCh37.mt`
- Pan-ancestry genetic analysis of the UK Biobank, `https://pan.ukbb.broadinstitute.org/docs/hail-format`.
- Exome-based association statistics ([genebass](https://genebass.org/)), `gs://ukbb-exome-public/300k/results`.

## genebass

### Download

```bash
# genebass and csd3 locations
export src=gs://ukbb-exome-public/300k/results
export dest=~/rds/results/public/gwas/ukb_excomes
mkdir -p ${dest}
cd ${dest}
# Gene burden results
gsutil -m cp -r ${src}/results.mt .
# Single variant association results
gsutil -m cp -r ${src}/variant_results.mt .
```

### Access

This mirrors the setup above,

```bash
module load python/3.7 hadoop/2.7.7
# we start from location where there is our py37
source py37/bin/activate
cd ~/rds/results/public/gwas/ukb_excomes
python <<END

# Gene burden results
import hail as hl
mt = hl.read_matrix_table('results.mt')

# Summaries
mt.count()
mt.describe()
mt.show()
mt.cols().show()
mt.rows().show()
mt.entry.take(5)
mt.summarize()

# filtering
FGR=mt.filter_rows(mt.gene_symbol=="FGR")
FGR1065 = FGR.filter_cols(FGR.coding == '1065')
FGR1065.filter_entries(FGR1065.BETA_Burden>0)

# col operations
trait_mt = mt.cols().collect_by_key()
trait_mt.group_by('trait_type').aggregate(n_phenos=hl.agg.count()).show()
mt_cols = mt.cols()
mt_cols.count()
mt_cols.show(truncate=40, width=85)
mt_cols.phenocode.show()
mt_cols.filter(mt_cols.phenocode == '1777').show()
fields_to_drop = ['category', 'coding_description', 'description_more', 'inv_normalized',
                  'n_cases_both_sexes', 'n_cases_females', 'n_cases_males', 'saige_version']
mt_cols_reduced=mt_cols.drop(*fields_to_drop)

END
```
