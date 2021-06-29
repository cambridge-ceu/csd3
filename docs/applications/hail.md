---
sort: 16
---

# hail

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

Some files can be made available with `gsutil` installed. The HGDP data comes with release 3.1, `gs://gcp-public-data--gnomad/release/`.

We now attempt to access the latest [genebass](https://genebass.org/). First, we download the data as follows,

```bash
# csd3 location
export dest=~/rds/results/public/gwas/ukb_excomes
mkdir -p ${dest}
cd ${dest}
# Gene burden results
gsutil -m cp -r gs://ukbb-exome-public/300k/results/results.mt .
# Single variant association results
gsutil -m cp -r gs://ukbb-exome-public/300k/results/variant_results.mt .
```

and then mirror the setup above and invoke hail for basic information of the gene burden results,

```bash
module load python/3.7 hadoop/2.7.7
# we start from location where there is our py37
source py37/bin/activate
cd ~/rds/results/public/gwas/ukb_excomes
python <<END
import hail as hl
mt = hl.read_matrix_table('results.mt')
mt.describe()
mt.summarize()
mt.show()
mt_cols = mt.cols()
END
```
