---
sort: 3
---

# delphi (aka delphi-2M)

GitHub: <https://github.com/gerstung-lab/delphi>

## ceuadmin/delphi/github

```bash
module load ceuadmin/python/3.12.10
python -m venv github
source github/bin/activate
git clone https://github.com/gerstung-lab/delphi src
cd src
pip install -r requirements.txt
pip cache purge
pip list
```

The last command gives,

```
Package                  Version
------------------------ -----------
cloudpickle              3.1.1
contourpy                1.3.3
cycler                   0.12.1
filelock                 3.19.1
fonttools                4.60.0
fsspec                   2025.9.0
Jinja2                   3.1.6
joblib                   1.5.2
kiwisolver               1.4.9
llvmlite                 0.45.0
MarkupSafe               3.0.2
matplotlib               3.10.6
mpmath                   1.3.0
networkx                 3.5
numba                    0.62.0
numpy                    1.26.4
nvidia-cublas-cu12       12.1.3.1
nvidia-cuda-cupti-cu12   12.1.105
nvidia-cuda-nvrtc-cu12   12.1.105
nvidia-cuda-runtime-cu12 12.1.105
nvidia-cudnn-cu12        8.9.2.26
nvidia-cufft-cu12        11.0.2.54
nvidia-curand-cu12       10.3.2.106
nvidia-cusolver-cu12     11.4.5.107
nvidia-cusparse-cu12     12.1.0.106
nvidia-nccl-cu12         2.20.5
nvidia-nvjitlink-cu12    12.9.86
nvidia-nvtx-cu12         12.1.105
packaging                25.0
pandas                   2.3.2
patsy                    1.0.1
pillow                   11.3.0
pip                      25.0.1
pynndescent              0.5.13
pyparsing                3.2.5
python-dateutil          2.9.0.post0
pytz                     2025.2
scikit-learn             1.7.2
scipy                    1.16.2
seaborn                  0.13.2
shap                     0.48.0
six                      1.17.0
slicer                   0.0.8
statsmodels              0.14.5
sympy                    1.14.0
threadpoolctl            3.6.0
torch                    2.3.0
tqdm                     4.67.1
typing_extensions        4.15.0
tzdata                   2025.2
umap-learn               0.5.9.post2
```

## Reference

**Shmatko, Artem, Alexander Wolfgang Jung, Kumar Gaurav, Søren Brunak, Laust Hvas Mortensen, Ewan Birney, Tom Fitzgerald, and Moritz Gerstung. 2025.** "Learning the Natural History of Human Disease with Generative Transformers." _Nature_. [https://doi.org/10.1038/s41586-025-09529-3](https://doi.org/10.1038/s41586-025-09529-3).
