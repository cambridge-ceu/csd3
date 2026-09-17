---
sort: 13
---

# scGPT

GitHub: <https://github.com/bowang-lab/scGPT>, <https://scgpt.readthedocs.io/en/latest/>

The procedures are posted on scGPT site, <https://github.com/bowang-lab/scGPT/issues/306>.

## Python/3.9.12

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

## Release

A separate attempt to use a released version is made but appears to have issues with `anndata` and `mudata`, which is resolved by mirroring modules (`mudata`==0.2.3 and `anndata`==0.9.2) and the trick for `torch`, etc. as above.

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
pip list | awk '/scanpy|scib|scvi|scgpt|flash-attn|torch|wandb/'
```

giving

```
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
