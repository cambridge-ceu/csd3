---
sort: 20
---

# gsutil

## Installation

Web site: [https://cloud.google.com/storage/docs/gsutil_install#linux](https://cloud.google.com/storage/docs/gsutil_install#linux)

the authentification is achieved via Google SDK (e.g. [301.0.0](https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-301.0.0-linux-x86_64.tar.gz))

```bash
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-301.0.0-linux-x86_64.tar.gz
tar xfz google-cloud-sdk-301.0.0-linux-x86_64.tar.gz
cd google-cloud-sdk
./install.sh
# to gain a bit flexibility by not using the awkward browser (Konqueror) at CSD3
gcloud auto login --no-launch-browser
# to set PROJECT_ID=divine-aegis-278909
gcloud config set divine-aegis-278909
```

followed by `gsutil config` where `gsutil` is installed via `virtualenv` as follows,

```bash
module load python/3.7
virtualenv py37
source py37/bin/activate
pip install gsutil==4.50
cd ${dir}/py37/bin
gsutil ls
# gsutil cp test gs::/covid19-hg-upload-bugbank
gsutil cp test gs://covid19-hg-upload-uk--blood-donors-cohort
```

Less useful is the usual way to install.

```bash
wget https://storage.googleapis.com/pub/gsutil.tar.gz
tar xvfz gsutil.tar.gz -C ..
cd ../gsutil
pip install pyasn1==0.4.8  --user
python setup.py install --prefix=$HPC_WORK
```

## Examples

## FinnGen

Web: [https://www.finngen.fi/en/access_results](https://www.finngen.fi/en/access_results)

The GWAS summary statistics from R7 public data can be downloaded as follows,

```bash
gsutil -m cp -r \
  "gs://finngen-public-data-r7/summary_stats" \
  .
```

and with all results lined up together we could use

```bash
gsutil -m cp -r \
  "gs://finngen-public-data-r7/annotations" \
  "gs://finngen-public-data-r7/covid" \
  "gs://finngen-public-data-r7/finemapping" \
  "gs://finngen-public-data-r7/summary_stats" \
  .
```

This could be very space hungry and we could make a list of files and select by phenocode, e.g.,

```bash
gsutil ls gs://finngen-public-data-r7/summary_stats > finngen-r7.list
grep -e JUVEN_ARTHR -e L12_PSORIASIS -e D3_SARCOIDOSIS finngen-r7.list | \
xargs -l -I {} gsutil -m cp {} .
```

The phenocode can be found from [https://r7.finngen.fi/](https://r7.finngen.fi/).

### GTEx

The GTEx v8 QTL resources,

```bash
gsutil -m cp -r \
  "gs://gtex-resources/GTEx_Analysis_v8_QTLs/" \
  .
```

or Europeans individually,

```bash
gsutil -m cp -r \
  "gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_EUR_eQTL_all_associations/" \
  "gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_EUR_sQTL/" \
  "gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_EUR_sQTL_all_associations/" \
  "gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/" \
  "gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_sQTL/" \
  "gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_sQTL_all_associations/" \
  "gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_sQTL_leafcutter_counts.tar" \
  .
```

as described here, [https://cloud.google.com/storage/docs/downloading-objects](https://cloud.google.com/storage/docs/downloading-objects).
