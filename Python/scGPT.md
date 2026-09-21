---
sort: 13
---

# scGPT

GitHub: <https://github.com/bowang-lab/scGPT>, <https://scgpt.readthedocs.io/en/latest/>

The procedures are posted on scGPT site, <https://github.com/bowang-lab/scGPT/issues/306>.

## scGPT/0.2.4

This is based on PyPI and Python/3.9.12.

```bash
module load python/3.9.12/gcc/pdcqf4o5
python -m venv scGPT-models
source scGPT-models/bin/activate
python -m pip install --upgrade pip
pip install "setuptools<70" wheel
pip install numpy==1.26.4
pip install matplotlib==3.7.5
pip install torch==2.0.1+cu117 torchvision==0.15.2+cu117 torchaudio==2.0.2+cu117 \
  torchtext==0.15.2 torchdata==0.6.1 \
  --extra-index-url https://download.pytorch.org/whl/cu117
pip install scvi-tools==0.20.3 anndata==0.9.2 scanpy==1.9.3
pip install scgpt==0.2.4
pip install "flash-attn==1.0.4" --no-build-isolation
pip install wandb faiss-cpu nbformat ipykernel
pip install gseapy
pip install torch-geometric
python -m pip check
python -m ipykernel install --user \
  --name scGPT-models \
  --display-name "Python (scGPT-models)"
python -c "import sys; print(sys.version)"
python -c "import torch, numpy, scanpy, anndata, scvi, scgpt; print('torch:', torch.__version__); print('cuda:', torch.version.cuda);
print('numpy:', numpy.__version__); print('scanpy:', scanpy.__version__); print('anndata:', anndata.__version__); print('scvi:',
scvi.__version__); print('scgpt:', scgpt.__version__); print('CUDA available:', torch.cuda.is_available())"
python -c "from torch_geometric.nn import SGConv; print('torch-geometric OK')"
pip list | awk '/gseapy|scanpy|scib|scvi|scgpt|flash-attn|torch|wandb/'
```

giving

```
No broken requirements found.
3.9.12 (main, Jul 20 2022, 11:04:08)
torch: 2.0.1+cu117
cuda: 11.7
numpy: 1.26.4
scanpy: 1.9.3
anndata: 0.9.2
scvi: 0.20.3
scgpt: 0.2.4
CUDA available: True
torch-geometric OK
flash-attn                1.0.4
gseapy                    1.3.1
pytorch-lightning         1.9.5
scanpy                    1.9.3
scgpt                     0.2.4
scib                      1.1.7        1
scvi-tools                0.20.3
torch                     2.0.1+cu117
torchaudio                2.0.2+cu117
torchdata                 0.6.1
torchmetrics              1.8.2
torchtext                 0.15.2+cpu
torchvision               0.15.2+cu117
wandb                     0.26.1
```

One hiccup regards scib 1.1.7 which requires pandas > 2 and for now we use `pip install pandas==1.5.3` to run through `Tutorial_GRN.ipynb`.

Our installation shows that,

```
$ pip show scgpt
Name: scgpt
Version: 0.2.4
Summary: Large-scale generative pretrain of single cell using transformer.
Home-page: https://github.com/bowang-lab/scGPT
Author: Haotian
Author-email: subercui@gmail.com
License: MIT
Location: /rds/project/rds-4o5vpvAowP0/software/scGPT-models/lib/python3.9/site-packages
Requires: cell-gears, datasets, leidenalg, numba, orbax, pandas, scanpy, scib, scikit-misc, scvi-tools, torch, torchtext, typing-extensions, umap-learn
Required-by:

$ pip index versions scgpt
scgpt (0.2.4)
Available versions: 0.2.4, 0.2.2, 0.2.1, 0.2.0, 0.1.9, 0.1.8, 0.1.7, 0.1.6, 0.1.5, 0.1.3, 0.1.2.post1, 0.1.2, 0.1.1, 0.1.0
  INSTALLED: 0.2.4
  LATEST:    0.2.4
```

## tutorials/

The directory contains several tutorials covering cell annotation, GRN, multiomics.

We proceed with

```bash
module load ceuadmin/VSCode/1.133.0
module load ceuadmin/scGPT/0.2.4
cd ~/rds/software/scGPT-tests
code tutorials/
```

The following changes are required to run the scGPT 0.2.4 tutorials with the current environment.

### 1. `Tutorial_GRN.ipynb`

It runs successfully from **Run All** without additional modifications.

### 2. `Tutorial_Attention_GRN.ipynb`

Several changes are required.

#### 2.1 Fix `model.bn`

The pretrained model contains BatchNorm parameters:

```python
state = torch.load(model_file, map_location="cpu")
print([k for k in state.keys() if "bn" in k.lower()])
```

which returns:

```text
['bn.weight', 'bn.bias', 'bn.running_mean', 'bn.running_var', 'bn.num_batches_tracked']
```

Therefore, the model needs to be instantiated with:

```python
model = TransformerModel(
    ntokens,
    embsize,
    nhead,
    d_hid,
    nlayers,
    vocab=vocab,
    pad_value=pad_value,
    n_input_bins=n_input_bins,
    use_fast_transformer=True,
    fast_transformer_backend="flash",
    domain_spec_batchnorm="batchnorm",
    pre_norm=False,
)
```

With this change, `len(df_atten)` is 28 rather than 6.

#### 2.2 Fix the reference-file path

Change:

```python
df = pd.read_csv('./reference/BHLHE40.10.tsv', delimiter='\t')
```

to:

```python
df = pd.read_csv('../reference/BHLHE40.10.tsv', delimiter='\t')
```

#### 2.3 Fix the Reactome organism name

Change:

```python
enr_Reactome = gp.enrichr(...)
```

so that the organism argument uses: `organism="human"`
rather than: `organism="Human"`.

### 3. `Tutorial_Integration.ipynb`

The integration tutorial uses: `scvi-tools == 0.20.3` 
which contains deprecated NumPy aliases such as `np.str` and `np.bool` 
that were removed from NumPy, so they produce errors when using:
`numpy == 1.26.4`.

For example:

```text
AttributeError: module 'numpy' has no attribute 'str'
AttributeError: module 'numpy' has no attribute 'bool'
```

We keep `numpy == 1.26.4` because the GRN tutorial requires a newer NumPy version, and patch the obsolete aliases in the installed `scvi-tools` code.

For example, in: `scvi/data/_built_in_data/_pbmc.py` change:

```python
barcodes_metadata = pbmc_metadata["barcodes"].index.values.ravel().astype(np.str)
```

to:

```python
barcodes_metadata = pbmc_metadata["barcodes"].index.values.ravel().astype(str)
```

Similarly, change: `dtype=np.bool` to: `dtype=bool`

### Check for additional deprecated aliases

Use:

```bash
SCVI_DIR=/rds/project/rds-4o5vpvAowP0/software/scGPT-models/lib/python3.9/site-packages/scvi
grep -RInE 'np\.(bool|int|float|str|object|complex)\b' "$SCVI_DIR"
```

When interpreting the output, note that valid types such as:

```text
np.float32
np.float64
np.int32
np.int64
```

are **not deprecated aliases** and must not be replaced.

The aliases that need attention are specifically:

```text
np.bool
np.int
np.float
np.str
np.object
np.complex
```

For this environment, the actual problematic aliases encountered in the PBMC loader are:

```python
np.str
np.bool
```

which should be replaced by:

```python
str
bool
```

respectively.

Before making the changes:

```bash
SCVI_DIR=/rds/project/rds-4o5vpvAowP0/software/scGPT-models/lib/python3.9/site-packages/scvi

cp -r "$SCVI_DIR" "${SCVI_DIR}.backup"
```

A quick automatied patch is possible but with the possibility of affecting comments/docstrings,

```bash
grep -RIlE 'np\.(bool|int|float|str|object|complex)' "$SCVI_DIR" |
while read f; do
    sed -i \
        -e 's/np\.bool\b/bool/g' \
        -e 's/np\.int\b/int/g' \
        -e 's/np\.float\b/float/g' \
        -e 's/np\.str\b/str/g' \
        -e 's/np\.object\b/object/g' \
        -e 's/np\.complex\b/complex/g' \
        "$f"
done
```

After patching, restart the Jupyter kernel and test:

```python
import numpy as np
import scvi

print("NumPy:", np.__version__)
print("scvi:", scvi.__version__)

adata = scvi.data.pbmc_dataset()
print(adata)
```

The important point is that **NumPy 1.26.4 is retained** rather than downgraded, allowing the GRN tutorial and integration tutorial to coexist in the same environment.

## scGPT/0.2.4-Release

This uses the released version is made but appears to have issues with `anndata` and `mudata`, which is resolved by mirroring modules (`mudata`==0.2.3 and `anndata`==0.9.2) and the trick for `torch`, etc. as above.

```bash
module load python/3.9.12/gcc/pdcqf4o5
python -m venv scGPT-release
source scGPT-release/bin/activate
wget -qO- https://github.com/bowang-lab/scGPT/archive/refs/tags/v0.2.4.tar.gz | tar xvfz -
cd scGPT-0.2.4/
pip install -e .
pip install ipykernel
pip install gseapy
pip install torch.geometric
pip install einops
pip list
pip uninstall torch -y
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117
pip install flash-attn==1.0.4
pip uninstall numpy -y
pip install numpy==1.25.2
pip install wandb
pip install iprogress
pip install nbformat
pip check
pip list | awk '/scanpy|scib|scvi|scgpt|flash-attn|torch|wandb/'
```

giving

```
No broken requirements found
flash-attn               1.0.4
pytorch-lightning        1.9.5
scanpy                   1.10.3
scib                     1.1.7
scvi-tools               0.20.3
torch                    2.0.1+cu117
torch-geometric          2.6.1
torchaudio               2.0.2+cu117
torchmetrics             1.7.1
torchvision              0.15.2+cu117
wandb                    0.19.9
```

## Earlier attempt

The installation is done as follows ([scGPT.sh](files/scGPT.sh) with additional verification inside Python),

```bash
module load python/3.11.0-icl
python -m venv scGPT-models
source scGPT-models/bin/activate
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117
pip install packaging
pip install ipykernel
pip install scgpt flash-attn==1.0.4
pip uninstall numpy -y
pip install numpy==1.25.2
pip install scvi-tools==0.20.3 anndata==0.9.2 scanpy==1.9.3
pip install wandb
pip install faiss-cpu
pip install nbformat
pip list | awk '/scanpy|scib|scvi|scgpt|flash-attn|torch|wandb/'
```

As it happens, `numpy` 2.1.2 causes issues with `scvi-tools` and a compatible one is chosen.

```
flash-attn              1.0.4
pytorch-lightning       1.9.5
scanpy                  1.9.3
scgpt                   0.2.4
scib                    1.1.7
scvi-tools              0.20.3
torch                   2.0.1+cu117
torchaudio              2.0.2+cu117
torchdata               0.6.1
torchmetrics            1.7.0
torchtext               0.15.2
torchvision             0.15.2+cu117
wandb                   0.19.9
```
