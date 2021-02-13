---
sort: 16
---

# MetaXcan

Web: https://github.com/hakyimlab/MetaXcan

Installation and a test run,

```bash
git clone https://github.com/hakyimlab/MetaXcan
cd MetaXcan/software
# download sample_data.tar.gz
tar -xzvpf sample_data.tar.gz
module load miniconda3/4.5.1
conda env create -f $HPC_WORK/MetaXcan/software/conda_env.yaml
conda activate imlabtools
conda install pandas
python setup.py install --user

./SPrediXcan.py \
--model_db_path data/DGN-WB_0.5.db \
--covariance data/covariance.DGN-WB_0.5.txt.gz \
--gwas_folder data/GWAS \
--gwas_file_pattern ".*gz" \
--snp_column SNP \
--effect_allele_column A1 \
--non_effect_allele_column A2 \
--beta_column BETA \
--pvalue_column P \
--output_file results/test.csv
```
