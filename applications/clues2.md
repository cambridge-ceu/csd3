---
sort: 17
layout: default
---

# CLUES2

GitHub: <https://github.com/avaughn271/CLUES2>

## Installation

```bash
export CLUES2_DIR=$CEUADMIN/clues2
export ENV_DIR=$CLUES2_DIR/envs/clues2
export ENV_METHOD=venv

cd "$CEUADMIN" || exit

if [[ "$ENV_METHOD" == "conda" ]]; then
    echo "Creating conda environment..."
    module load ceuadmin/Anaconda3
    conda create -p "$ENV_DIR" python=3.10 -y
    source "$(conda info --base)/etc/profile.d/conda.sh"
    conda activate "$ENV_DIR"
else
    echo "Creating virtualenv..."
    python3 -m venv "$CLUES2_DIR"
    source "$CLUES2_DIR/bin/activate"
fi

pip install --upgrade pip
pip install numba scipy numpy matplotlib biopython pandas

cd "$CLUES2_DIR" || exit
git clone https://github.com/avaughn271/CLUES2.git src
python src/inference.py --help
```

giving

```
usage: inference.py [-h] [--times TIMES] [--popFreq POPFREQ]
                    [--ancientSamps ANCIENTSAMPS] [--ancientHaps ANCIENTHAPS]
                    [--out OUT] [--N N] [--coal COAL] [--tCutoff TCUTOFF]
                    [--timeBins TIMEBINS [TIMEBINS ...]] [--CI CI [CI ...]]
                    [--sMax SMAX] [--df DF] [--noAlleleTraj]
                    [--integration_points INTEGRATION_POINTS] [--h H]

optional arguments:
  -h, --help            show this help message and exit
  --times TIMES
  --popFreq POPFREQ
  --ancientSamps ANCIENTSAMPS
  --ancientHaps ANCIENTHAPS
  --out OUT
  --N N
  --coal COAL           path to Relate .coal file. Negates --N option.
  --tCutoff TCUTOFF
  --timeBins TIMEBINS [TIMEBINS ...]
  --CI CI [CI ...]
  --sMax SMAX
  --df DF
  --noAlleleTraj        whether to compute the posterior allele frequency
                        trajectory or not.
  --integration_points INTEGRATION_POINTS
  --h H
```

## Testing

Run through nicely, this is rather casual instance.

```bash
echo "Preparing test data..."
TEST_DIR=$CLUES2_DIR/tests
mkdir -p $TEST_DIR && cd "$TEST_DIR" || exit

echo -e "0.01\n0.05\n0.07\n0.12\n0.2" > test_times.txt

python "$CLUES2_DIR/src/inference.py" \
  --times test_times.txt \
  --popFreq 0.35 \
  --N 30000 \
  --tCutoff 1000 \
  --df 500 \
  --timeBins 200 500 \
  --out results_test

python "$CLUES2_DIR/src/plot_traj.py" \
  --freqs results_test_freqs.txt \
  --post results_test_post.txt \
  --figure traj_plot_test \
  --generation_time 28

echo "✅ CLUES2 test complete. Output files:"
ls -lh results_test*
```

📁 Output files

* `results_test_freqs.txt`: inferred allele frequencies over time
* `results_test_inference.txt`: statistical inference such as LRT.
* `results_test_post.txt`: posterior samples of selection coefficient
* `traj_plot_test.png`: visual plot of trajectory

## Benchmarks

See src/examples/ directory.

```bash
python3 inference.py \
    --N 30000 \
    --popFreq 0.52 \
    --times examples/MCM6_times.txt \
    --df 600 \
    --tCutoff 536 \
    --noAlleleTraj \
    --out examples/ALL_MCM6
```

giving `examples/ALL_MCM6_inference.txt`:

```
logLR   -log10(p-value) Epoch1_start    Epoch1_end      SelectionMLE1
31.2746 14.59   0       536     0.01223
```

## References

Stern AJ, Wilton PR, Nielsen R. An approximate full-likelihood method for inferring selection and allele frequency trajectories from
DNA sequence data. *PLoS Genet* 2019, 15(9):1–32. <https://doi.org/10.1371/journal.pgen.1008384>.

Vaughn AH, Nielsen R, Fast and accurate estimation of selection coefficients and allele histories from ancient and modern DNA, *Mol Biol Evol* 2024, 41(8): msae156, <https://doi.org/10.1093/molbev/msae156>.
