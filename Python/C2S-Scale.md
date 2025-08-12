---
sort: 2
---

# C2S-Scale

Blog, [Teaching machines the language of biology: Scaling large language models for next-generation single-cell analysis](https://research.google/blog/teaching-machines-the-language-of-biology-scaling-large-language-models-for-next-generation-single-cell-analysis/)

The setup is as usual,

```bash
git clone https://github.com/vandijklab/cell2sentence.git
cd cell2sentence/
module load python/3.9.12/gcc/pdcqf4o5
python -m venv cell2sentence
source cell2sentence/bin/activate
make install
pip install flash-attn==1.0.4 --no-build-isolation
```

Usage notes on tutorials 1-3, posted at <https://github.com/vandijklab/cell2sentence/issues/14>:

1). `src/cell2sentence/utils.py`, line 280: "r_squared": [r_squared_score.item()], --> "r_squared": [r_squared_score];

```python
reconstructed_adata = anndata.AnnData(
X=all_reconstructed_expression_vectors,
obs=adata.obs.copy(),
var=adata.var.copy()
)
reconstructed_adata
```

==>

```python
from scipy.sparse import csr_matrix
# Convert csr_array to csr_matrix
X_converted = csr_matrix(all_reconstructed_expression_vectors)

# Create the AnnData object
reconstructed_adata = anndata.AnnData(
X=X_converted,
obs=adata.obs.copy(),
var=adata.var.copy()
)
```

2). `cell_type_prediction_model_path` needs to be changed, e.g.,

```python
# Define CSModel object
cell_type_prediction_model_path = "vandijklab/C2S-Pythia-410m-cell-type-prediction"
save_dir = "../C2S_Files_Syed/c2s_api_testing/csmodel_tutorial_2"
save_name = "cell_embedding_prediction_pythia_410M_1"
csmodel = cs.CSModel(
    model_name_or_path=cell_type_prediction_model_path,
    save_dir=save_dir,
    save_name=save_name
)
```

3). Note that `eval_strategy="steps"` instead of `evaluation_strategy="steps"` below,

```python
train_args = TrainingArguments(
 bf16=True,
 fp16=False,
 per_device_train_batch_size=8,
 per_device_eval_batch_size=8,
 gradient_accumulation_steps=4,
 gradient_checkpointing=False,
 learning_rate=1e-5,
 load_best_model_at_end=True,
 logging_steps=50,
 logging_strategy="steps",
 lr_scheduler_type="cosine",
 num_train_epochs=5,
 eval_steps=50,
 eval_strategy="steps",
 save_steps=100,
 save_strategy="steps",
 save_total_limit=3,
 warmup_ratio=0.05,
 output_dir=output_dir
)
```

