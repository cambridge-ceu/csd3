---
sort: 42
---

# llama.cpp

GitHub: <https://github.com/ggml-org/llama.cpp>

## Installation[^macOS]

```bash
# Initially, we build from GitHub
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$CEUADMIN/llama.cpp/b4991 ..
make && make install
# It is recommended to build from release to avoid possible intermediate updates
wget -qO- https://github.com/ggml-org/llama.cpp/archive/refs/tags/b5303.tar.gz | tar xvfz -
cd llama.cpp-b5303/
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$CEUADMIN/llama.cpp/b5303 ..
make && make install
# b5558 requires gcc/9 and above
export version=b7673
module load gcc/11.3.0/gcc/4zpip55j
wget -qO- https://github.com/ggml-org/llama.cpp/archive/refs/tags/${version}.tar.gz | tar xvfz -
cd llama.cpp-${version}
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$CEUADMIN/llama.cpp/${version} ..
make && make install
```

We can the use `module load ceuadmin/llama.cpp` for operations below.

## GGUF

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

### gpt-oss-20b

A 12GB model is downloaded from [ggml-org/gpt-oss-20b-GGUF](https://huggingface.co/ggml-org/gpt-oss-20b-GGUF/)

```bash
ln -sf /rds/user/$USER/hpc-work/HuggingFace/cache/llama.cpp ~/.cache/llama.cpp
llama-server -hf ggml-org/gpt-oss-20b-GGUF --ctx-size 0 --jinja -ub 2048 -b 2048 -ngl 99 -fa
module load ceuadmin/chrome
chrome [--user-data-dir=/tmp/chrome] http://localhost:8080/
```

where we point the default llama.cpp cache folder to a location with more space and [.] is optional such that it is used when Chrome fails to start.

## llama-run/llama-cli/llama-mtmd-cli

To proceed, we obtain a HuggingFace token from <https://huggingface.co/settings/tokens>.

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
