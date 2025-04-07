#!/usr/bin/bash

module load python/3.11.0-icl
python -m venv scGPT-models
source scGPT-models/bin/activate
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117
pip install packaging
pip install ipykernel
pip install scgpt flash-attn==1.0.4 pybind11>=2.12
pip uninstall numpy
pip install numpy===1.25.2
pip install scvi-tools==0.20.3 anndata==0.9.2 scanpy==1.9.3

python <<END
import pkg_resources
packages = ['scgpt', 'torch', 'torchaudio', 'torchtext', 'torchvision', 'scanpy', 'wandb']
for package_name in packages:
    try:
        dist = pkg_resources.get_distribution(package_name)
        print(f'{package_name}: {dist.version}')
    except pkg_resources.DistributionNotFound:
        print(f'{package_name} is not installed.')

END
