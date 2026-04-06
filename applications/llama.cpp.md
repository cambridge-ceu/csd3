---
sort: 43
---

# llama.cpp

GitHub: <https://github.com/ggml-org/llama.cpp>

## Installation[^macOS]

Version b5558 or later requires gcc/9 and above.

```bash
export version=b8676
wget -qO- https://github.com/ggml-org/llama.cpp/archive/refs/tags/${version}.tar.gz | tar xvfz -
cd llama.cpp-${version}
module load gcc/11.3.0/gcc/4zpip55j
# note there is a misnomer with openssl/3.3.0-dev
module load openssl/3.3.0-dev
mkdir build && cd build
cmake .. -DLLAMA_OPENSSL=ON \
  -DCMAKE_PREFIX_PATH=/usr/local/Cluster-Apps/openssl/3.2.1 \
  -DCMAKE_INSTALL_PREFIX=$CEUADMIN/llama.cpp/${version}
make && make install
```

Recent distributions also require openssl; from above we see from `ldd ./bin/llama-server | grep ssl`:

```
libssl.so.3 => /usr/local/Cluster-Apps/openssl/3.2.1/lib64/libssl.so.3 (0x000014c78627c000)
libcrypto.so.3 => /usr/local/Cluster-Apps/openssl/3.2.1/lib64/libcrypto.so.3 (0x000014c785b30000)
```

We can the use `module load ceuadmin/llama.cpp` for operations below.

## GGUF

GGML Unified Format (GGUF) is the binary model format used by llama.cpp and related tools.

It appears more efficient to use /rds/user/$USER/hpc-work/cache due to larger space, i.e.,

```bash
ln -sf /rds/user/$USER/hpc-work/cache ~/.cache
# An earlier attempt is more restrictive
ln -sf /rds/user/$USER/hpc-work/HuggingFace/cache/llama.cpp ~/.cache/llama.cpp
```

An example with `/DeepSeek-V3-0324`,

```bash
wget https://huggingface.co/unsloth/DeepSeek-V3-0324-GGUF/resolve/main/UD-IQ2_XXS/DeepSeek-V3-0324-UD-IQ2_XXS-00001-of-00005.gguf
wget https://huggingface.co/unsloth/DeepSeek-V3-0324-GGUF/resolve/main/UD-IQ2_XXS/DeepSeek-V3-0324-UD-IQ2_XXS-00002-of-00005.gguf
wget https://huggingface.co/unsloth/DeepSeek-V3-0324-GGUF/resolve/main/UD-IQ2_XXS/DeepSeek-V3-0324-UD-IQ2_XXS-00003-of-00005.gguf
wget https://huggingface.co/unsloth/DeepSeek-V3-0324-GGUF/resolve/main/UD-IQ2_XXS/DeepSeek-V3-0324-UD-IQ2_XXS-00004-of-00005.gguf
wget https://huggingface.co/unsloth/DeepSeek-V3-0324-GGUF/resolve/main/UD-IQ2_XXS/DeepSeek-V3-0324-UD-IQ2_XXS-00005-of-00005.gguf
module load ceuadmin/llama.cpp
llama-gguf-split --merge DeepSeek-V3-0324-UD-IQ2_XXS-00001-of-00005.gguf DeepSeek-V3-0324-UD-IQ2_XXS.gguf
```

## llama-server

### Gemma 4

URL, <https://huggingface.co/collections/ggml-org/gemma-4>.

```bash
export SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
llama-server -hf ggml-org/gemma-4-26B-A4B-it-GGUF
```

then access `http://localhost:8080`.

### gpt-oss-20b

A 12GB model is downloaded from [ggml-org/gpt-oss-20b-GGUF](https://huggingface.co/ggml-org/gpt-oss-20b-GGUF/)

```bash
llama-server -hf ggml-org/gpt-oss-20b-GGUF --ctx-size 0 --jinja -ub 2048 -b 2048 -ngl 99 -fa
module load ceuadmin/chrome
chrome [--user-data-dir=/tmp/chrome] http://localhost:8080/
```

where we point the default llama.cpp cache folder to a location with more space and [.] is optional such that it is used when Chrome fails to start.

## llama-run/llama-cli/llama-mtmd-cli

To proceed, we obtain a HuggingFace token from <https://huggingface.co/settings/tokens>, then login and down a model with vision projector.

```bash
source ~/rds/software/py3.11/bin/activate
huggingface-cli login

huggingface-cli download \
  second-state/Llava-v1.5-7B-GGUF \
  llava-v1.5-7b-Q4_K_M.gguf \
  --local-dir models/llava

huggingface-cli download \
  second-state/Llava-v1.5-7B-GGUF \
  llava-v1.5-7b-mmproj-model-f16.gguf \
  --local-dir models/llava
```

and make an attempt to dicipher text in the image:

```bash
module load ceuadmin/b7673
llama-mtmd-cli \
  -m models/llava/llava-v1.5-7b-Q4_K_M.gguf \
  --mmproj models/llava/llava-v1.5-7b-mmproj-model-f16.gguf \
  --image /home/jhz22/work/calligraphy.jpg \
  --chat-template vicuna \
  -p "Extract and transcribe all visible calligraphy text." \
  -n 256 \
  --temp 0.95
```

### Qwen3-4B

We here apply updates to the Hugging Face package,

```bash
source ~/rds/software/py3.11/bin/activate
pip install -U huggingface_hub
python - <<'PY'
from huggingface_hub import list_repo_files
for f in list_repo_files("Qwen/Qwen3-4B-GGUF"):
    print(f)
PY
hg auth login
hf download Qwen/Qwen3-4B-GGUF Qwen3-4B-Q4_K_M.gguf --local-dir .
module load ceuadmin/llama.cpp
llama-cli -m Qwen3-4B-Q4_K_M.gguf --color on --ctx-size 2048 --threads 8
```

### vicuna

We have a considerable faster session, `llama-run vicuna`,

> why the sky is blue

The sky appears blue because the Earth's atmosphere scatters sunlight in all directions and blue light is scattered more than other colors because it travels as shorter, smaller waves. The blue light is scattered in all directions, which makes it appear as if it's coming from all around the sky, giving the impression of a blue dome.

> write an essay on precision medicine

Precision medicine is an approach to healthcare that tailors medical treatment to an individual's unique genetic, lifestyle, and environmental factors. It involves using advanced technologies, such as genomics and personalized medicine, to develop highly targeted therapies that can improve treatment outcomes and reduce side effects.

One of the key principles of precision medicine is the use of genomics, which involves analyzing an individual's genetic makeup to identify genetic mutations or variations that may be driving a disease or condition. By understanding an individual's genetic profile, doctors can develop targeted therapies that are designed to specifically target the underlying cause of the disease.

Another important aspect of precision medicine is the use of personalized medicine, which involves tailoring treatment to an individual's specific needs and preferences. This can include factors such as lifestyle habits, environmental factors, and patient-reported outcomes. By taking into account all of these factors, doctors can develop a personalized treatment plan that is tailored to the individual's unique needs.

Precision medicine has the potential to revolutionize healthcare by improving treatment outcomes and reducing side effects. It has already been used to develop highly effective targeted therapies for a range of diseases, including cancer, heart disease, and diabetes. In the future, precision medicine has the potential to be used to develop personalized medications, which could be tailored to an individual's specific needs and could be taken orally, rather than through invasive procedures such as injections.

In conclusion, precision medicine is an approach to healthcare that involves using advanced technologies to develop highly targeted therapies that can improve treatment outcomes and reduce side effects. It has the potential to revolutionize healthcare by improving treatment outcomes and reducing side effects, and could be used to develop personalized medications in the future.

### deepseek-r1

This is from `llama-run deepseek-r1`, [precision-medicine-deepseek-r1.md](files/precision-medicine-deepseek-r1.md).

[^macOS]: **macOS**

    `brew install llama.cpp`.
