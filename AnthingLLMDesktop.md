---
sort: 30
---

# AnythingLLM Desktop

Web: <https://anythingllm.com/>

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

## GGUF

This showcases its use

```bash
huggingface-cli download TheBloke/MistralLite-7B-GGUF mistrallite.Q4_K_M.gguf --local-dir ./models
echo FROM ./models/mistrallite.Q4_K_M.gguf > Modelfile
ollama create mistrallite -f Modelfile
ollama list
```
