module load python/3.9.12/gcc/pdcqf4o5
python -m venv drugassist
source drugassist/bin/activate
pip install --upgrade pip
git clone https://github.com/blazerye/DrugAssist.git
cd DrugAssist
pip install packaging
pip install torch==2.0.1
pip install scipy==1.8.0
sed -i 's/^scipy==.*$/scipy==1.8.0/' requirements.txt
pip install -r requirements.txt
huggingface-cli login

export HF_DATASETS_CACHE=~/.cache/huggingface/datasets/
python <<END
from datasets import load_dataset

# Login using e.g. `huggingface-cli login` to access this dataset
ds = load_dataset("blazerye/MolOpt-Instructions")
END

# It only supports GPUs
sh run_sft_lora.sh

https://huggingface.co/blazerye/DrugAssist-7B
