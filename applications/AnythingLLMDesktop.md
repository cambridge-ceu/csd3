---
sort: 5
---

# AnythingLLM Desktop

Web: <https://anythingllm.com/>

The environment suppresses the usual screen outputs, keeps query histories and allows for document embedding.

## Installation

```bash
export root=/rds/project/rds-4o5vpvAowP0/software
mkdir -p ${root}/AnythingLLMDesktop
curl -fsSL https://cdn.anythingllm.com/latest/installer.sh | \
sed "/OUTDIR/d; /Downloading/i\
OUTDIR=${root}/AnythingLLMDesktop
" | sh

# $HOME/AnythingLLMDesktop by default
ln -s /rds/project/rds-4o5vpvAowP0/software/AnythingLLMDesktop ~/AnythingLLMDesktop
```

Our batch script is `start.sh` indead of the `start` provided,

```bash
export STORAGE_DIR=root=/rds/project/rds-4o5vpvAowP0/software/AnythingLLMDesktop
export desktop=anythingllm-desktop
cd ${STORAGE_DIR}
$desktop/$desktop --no-sandbox > /dev/null 2>&1
```

## Ollama

First, we allocate a directory which can hold large file,

```bash
export OLLAMA_MODELS=/rds/usr/$USER/hpc-work/ollama
ln -sf ${OLLAMA_MODELS} $HOME/.ollama
```

then we make models visible,

```bash
module load ceuadmin/ollama
ollama serve &
ollama list
```

Handling of GGUF format is possible, as shown here

```bash
huggingface-cli download TheBloke/MistralLite-7B-GGUF mistrallite.Q4_K_M.gguf --local-dir ./models
echo FROM ./models/mistrallite.Q4_K_M.gguf > Modelfile
ollama create mistrallite -f Modelfile
ollama list
```

## llama.cpp

Since it is extremely slow from the console, this is considered on two aspects:

1. No use of AnythingLLM Desktop, e.g., `llama-run deepseek-r1`. The speed is very impressive.
2. Multithreading under AnythingLLM Desktop, e.g., `llama-server -m deepseek-r1 --port 8080 -t 8`. This is furnished by selecting `Local AI` and the right end point, e.g., `http://localhost:8080/v1`.
