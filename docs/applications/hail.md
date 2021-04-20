---
sort: 14
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
