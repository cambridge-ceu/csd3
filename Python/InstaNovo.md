---
sort: 9
---

# InstaNovo

Web: <https://github.com/instadeepai/InstaNovo>

The installation is standard.

```bash
module load python/3.11.0-icl
python -m venv InstaNovo
source InstaNovo/bin/activate
pip install "instanovo"
instanovo version
instanovo predict --data-path=sample_data/*mgf --output-path=sample_data/spectra.csv
```

The versioning for GPU from `instanovo version` is as follows.

```
┏━━━━━━━━━━━━┳━━━━━━━━━━━━━┓
┃ Package    ┃ Version     ┃
┡━━━━━━━━━━━━╇━━━━━━━━━━━━━┩
│ InstaNovo  │ 1.1.1       │
│ InstaNovo+ │ 1.1.1       │
│ NumPy      │ 2.0.2       │
│ PyTorch    │ 2.6.0+cu124 │
│ Lightning  │ 2.5.1       │
└────────────┴─────────────┘
```

The last line uses the toy data provided, downloading `instanovoplus-v1.1.0-alpha.ckpt` and `instanovo-v1.1.0.ckpt` to `~/.cache/instanovo`.

We reuse `tensorflow/`[^singularity] which contains `Python` 3.11 and `InstaNovo` 1.1.1,

```bash
singularity exec tensorflow/ /usr/local/bin/instanovo version
singularity exec tensorflow/ /usr/local/bin/instanovo predict --data-path=InstaNovo/src/sample_data/*.mgf --output-path=spectra.csv
singularity build instanovo-1.1.1.sif tensorflow/
singularity run instanovo-1.1.1.sif /usr/local/bin/instanovo predict --data-path=sample_data/*mgf --output-path=new.csv
```

which gives the same versioning information and uses GPU.

The CPU version is furnished with CPU-specific `PyTorch` via `uv`, designed for development,

```bash
git clone https://github.com/instadeepai/InstaNovo.git
cd InstaNovo
module load ceuadmin/uv/0.6.14
uv sync --extra cpu
uv run pre-commit install
source .venv/bin/activate
instanovo predict --data-path=sample_data/*mgf --output-path=spectrum.csv
```

giving `spectrum.csv`

```
scan_number,precursor_mz,precursor_charge,experiment_name,spectrum_id,diffusion_predictions_tokenised,diffusion_predictions,diffusion_log_probabilities,transformer_predictions,transformer_predictions_tokenised,transformer_log_probabilities,transformer_token_log_probabilities
0,451.25348,2,spectra,spectra:0,"['Y', 'A', 'H', 'Y', 'K', 'R']",YAHYKR,-0.05671021342277527,LAHYNKR,"L, A, H, Y, N, K, R",-1.7666722536087036,"[-0.030482856556773186, -0.001450797077268362, -5.352353764465079e-05, -0.0014650813536718488, -0.022426443174481392, -0.5744566917419434, -0.25638389587402344]"
```
