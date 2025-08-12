---
sort: 7
---

# awscli

Web: <https://docs.aws.amazon.com/cli/latest/>

```bash
curl -Lo awscli-src.tar.gz https://awscli.amazonaws.com/awscli.tar.gz
tar xvfz awscli-src.tar.gz
cd awscli-2.27.52/
./configure --prefix=$CEUADMIN/awscli/2.27.52 --with-download-deps
make
make install
```

For instance, the following are variations of ONT data accces,

```bash
aws configure set default.region eu-west-1
aws s3 ls s3://ont-open-data/ --no-sign-request
aws s3 sync --no-sign-request s3://ont-open-data/giab_2025.01/ giab_2025.01/
aws s3 cp s3://ont-open-data/giab_2025.01/ ./giab_2025.01/ \
    --recursive --no-sign-request --region eu-west-1
```
