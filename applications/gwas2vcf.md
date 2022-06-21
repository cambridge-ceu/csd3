---
sort: 20
---

# gwas2vcf

Web: https://github.com/MRCIEU/gwas2vcf

The required setup script is as follows,

```bash
module load jdk-8u141-b15-gcc-5.4.0-p4aaopt
module load gatk
module load python/3.7
git clone https://github.com/MRCIEU/gwas2vcf
cd gwas2vcf
python -m venv env
source env/bin/activate
pip install -r requirements.txt
pip install git+git://github.com/bioinformed/vgraph@v1.4.0#egg=vgraph
ln -s ~/rds/public_databases/GRCh37_reference_fasta/human_g1k_v37.fasta
ln -s ~/rds/public_databases/GRCh37_reference_fasta/human_g1k_v37.fasta.fai
python -m pytest -v test
python main.py -h

## these are not necessarily required and GRC37 is here, ~/rds/public_databases/GRCh37_reference_fasta/
# GRCh36/hg18/b36
wget http://fileserve.mrcieu.ac.uk/ref/2.8/b36/human_b36_both.fasta
wget http://fileserve.mrcieu.ac.uk/ref/2.8/b36/human_b36_both.fasta.fai

# GRCh37/hg19/b37
wget http://fileserve.mrcieu.ac.uk/ref/2.8/b37/human_g1k_v37.fasta
wget http://fileserve.mrcieu.ac.uk/ref/2.8/b37/human_g1k_v37.fasta.fai

# GRCh38/hg38/b38
wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta
wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai
```
