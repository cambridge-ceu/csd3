---
sort: 48
---

# llama.cpp

GitHub: <https://github.com/ggml-org/llama.cpp>

## Installation[^macOS]

### 0.8.0

```bash
export version=0.8.0
wget -qO- https://github.com/ggml-org/llama.cpp/archive/refs/tags/v${version}.tar.gz | tar xfz -
cd llama.cpp-${version}
module load gcc/11.3.0/gcc/4zpip55j
module load openssl/3.3.0-dev
mkdir build && cd build
cmake .. \
  -DLLAMA_OPENSSL=ON \
  -DCMAKE_PREFIX_PATH=/usr/local/Cluster-Apps/openssl/3.2.1 \
  -DCMAKE_INSTALL_PREFIX=$CEUADMIN/llama.cpp/${version} \
  -DCMAKE_C_FLAGS="-pthread" \
  -DCMAKE_CXX_FLAGS="-pthread"
make -j$(nproc) && make install
```

and also for 0.8.0-cuda,

```bash
export version=0.8.0
wget -qO- https://github.com/ggml-org/llama.cpp/archive/refs/tags/v${version}.tar.gz | tar xfz -
cd llama.cpp-0.8.0

module load cuda/12.1
module load gcc/11.3.0/gcc/4zpip55j
module load openssl/3.3.0-dev

export CUDA_HOME=/usr/local/software/cuda/12.1
export PATH="$CUDA_HOME/bin:$PATH"
export LLAMA_PREFIX="$CEUADMIN/llama.cpp/$version-cuda"
export CPATH="$(printf '%s' "${CPATH:-}" | tr ':' '\n' |
  grep -v '/cuda/11\.4/' | paste -sd: -)"

cmake -S . -B build-cuda-121 \
  -DCMAKE_C_COMPILER="$CC" \
  -DCMAKE_CXX_COMPILER="$CXX" \
  -DGGML_CUDA=ON \
  -DGGML_NATIVE=OFF \
  -DCMAKE_CUDA_COMPILER="$CUDA_HOME/bin/nvcc" \
  -DCUDAToolkit_ROOT="$CUDA_HOME" \
  -DLLAMA_OPENSSL=ON \
  -DCMAKE_PREFIX_PATH=/usr/local/Cluster-Apps/openssl/3.2.1 \
  -DCMAKE_INSTALL_PREFIX="$LLAMA_PREFIX" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_FLAGS="-pthread" \
  -DCMAKE_CXX_FLAGS="-pthread" \
  -DGGML_BUILD_TESTS=OFF \
  -DBUILD_TESTING=OFF \
  -DLLAMA_BUILD_TESTS=OFF \
  -DLLAMA_BUILD_EXAMPLES=OFF

cmake --build build-cuda-121 -j5
cmake --install build-cuda-121

"$LLAMA_PREFIX/bin/llama" --help
"$LLAMA_PREFIX/bin/llama" cli --list-devices
```

### deepseek41-cuda

This module is created since 0.8.0 fails the promised support for DeepSeek-V4.1-Flash.

```bash
git clone --branch runtime/deepseek41 --single-branch \
  https://github.com/vcruz305/llama.cpp.git llama.cpp-deepseek41
cd llama.cpp-deepseek41
git status --short
git log -1 --oneline

module load cuda/12.1
module load gcc/11.3.0/gcc/4zpip55j
module load openssl/3.3.0-dev

export CUDA_HOME=/usr/local/software/cuda/12.1
export PATH="$CUDA_HOME/bin:$PATH"

# Remove CUDA 11.4 include paths, as in the earlier CSD3 build
export CPATH="$(printf '%s' "$CPATH" |
  tr ':' '\n' |
  grep -v '/cuda/11\.4/' |
  paste -sd: -)"

cmake -S . -B build-cuda-121 \
  -DCMAKE_C_COMPILER="$CC" \
  -DCMAKE_CXX_COMPILER="$CXX" \
  -DGGML_CUDA=ON \
  -DGGML_NATIVE=OFF \
  -DCMAKE_CUDA_COMPILER="$CUDA_HOME/bin/nvcc" \
  -DCUDAToolkit_ROOT="$CUDA_HOME" \
  -DCMAKE_CUDA_ARCHITECTURES=89 \
  -DLLAMA_OPENSSL=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="$CEUADMIN/llama.cpp/deepseek41-cuda" \
  -DGGML_BUILD_TESTS=OFF \
  -DBUILD_TESTING=OFF \
  -DLLAMA_BUILD_TESTS=OFF \
  -DLLAMA_BUILD_EXAMPLES=OFF

cmake --build build-cuda-121 -j5
cmake --install build-cuda-121
```

### 0.7.0

```bash
export version=0.7.0
wget -qO- https://github.com/ggml-org/llama.cpp/archive/refs/tags/v${version}.tar.gz | tar xfz -
cd llama.cpp-${version}
module load gcc/11.3.0/gcc/4zpip55j
module load openssl/3.3.0-dev
mkdir build && cd build
cmake .. \
  -DLLAMA_OPENSSL=ON \
  -DCMAKE_PREFIX_PATH=/usr/local/Cluster-Apps/openssl/3.2.1 \
  -DCMAKE_INSTALL_PREFIX=$CEUADMIN/llama.cpp/${version} \
  -DCMAKE_C_FLAGS="-pthread" \
  -DCMAKE_CXX_FLAGS="-pthread"
make -j$(nproc) && make install
```

### 0.7.0-cuda[^CPATH]

This is the first attempt.

#### 1. Configure and build

```bash
cd ~/rds/software/llama.cpp-0.7.0

module load cuda/12.1
module load gcc/11.3.0/gcc/4zpip55j
module load openssl/3.3.0-dev

export CUDA_HOME=/usr/local/software/cuda/12.1
export PATH="$CUDA_HOME/bin:$PATH"

# Remove CUDA 11.4 include paths from CPATH
export CPATH="$(printf '%s' "$CPATH" |
  tr ':' '\n' |
  grep -v '/cuda/11\.4/' |
  paste -sd: -)"

export LLAMA_PREFIX="$CEUADMIN/llama.cpp/0.7.0-cuda"

cmake -S . -B build-cuda-121 \
  -DCMAKE_C_COMPILER="$CC" \
  -DCMAKE_CXX_COMPILER="$CXX" \
  -DGGML_CUDA=ON \
  -DGGML_NATIVE=OFF \
  -DCMAKE_CUDA_COMPILER="$CUDA_HOME/bin/nvcc" \
  -DCUDAToolkit_ROOT="$CUDA_HOME" \
  -DLLAMA_OPENSSL=ON \
  -DCMAKE_PREFIX_PATH=/usr/local/Cluster-Apps/openssl/3.2.1 \
  -DCMAKE_INSTALL_PREFIX="$LLAMA_PREFIX" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_FLAGS="-pthread" \
  -DCMAKE_CXX_FLAGS="-pthread" \
  -DGGML_BUILD_TESTS=OFF \
  -DBUILD_TESTING=OFF \
  -DLLAMA_BUILD_TESTS=OFF \
  -DLLAMA_BUILD_EXAMPLES=OFF

cmake --build build-cuda-121 --target llama-cli -j5
```

#### 2. Install the core libraries and CLI

```bash
cmake -DCMAKE_INSTALL_LOCAL_ONLY=ON \
  -P build-cuda-121/cmake_install.cmake

cmake -DCMAKE_INSTALL_PREFIX="$LLAMA_PREFIX" \
  -P build-cuda-121/tools/cli/cmake_install.cmake

cmake -DCMAKE_INSTALL_PREFIX="$LLAMA_PREFIX" \
  -P build-cuda-121/tools/server/cmake_install.cmake

cmake -DCMAKE_INSTALL_PREFIX="$LLAMA_PREFIX" \
  -P build-cuda-121/tools/mtmd/cmake_install.cmake

export LD_LIBRARY_PATH="$LLAMA_PREFIX/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
```

#### 3. Build and install the other utilities

```bash
cmake --build build-cuda-121 \
  --target \
    llama-server \
    llama-bench \
    llama-quantize \
    llama-perplexity \
    llama-imatrix \
    llama-gguf-split \
    llama-tokenize \
    llama-tts \
  -j5
for tool in \
  server llama-bench quantize perplexity imatrix \
  gguf-split tokenize tts
do
  echo "===== Installing $tool ====="
  cmake \
    -DCMAKE_INSTALL_PREFIX="$LLAMA_PREFIX" \
    -P "build-cuda-121/tools/$tool/cmake_install.cmake" || break
done
cmake --build build-cuda-121 --target llama-app -j5
cmake --build build-cuda-121 \
  --target \
    llama-batched-bench \
    llama-completion \
    llama-cvector-generator \
    llama-export-lora \
    llama-fit-params \
    llama-gemma3-cli \
    llama-llava-cli \
    llama-minicpmv-cli \
    llama-qwen2vl-cli \
    llama-mtmd-cli \
  -j5
find build-cuda-121/bin -maxdepth 1 \
  -type f -executable -name 'llama*' \
  -exec cp -v -t "$LLAMA_PREFIX/bin" {} +
```

#### 4. Verify the installation

```bash
"$LLAMA_PREFIX/bin/llama-cli" --version
"$LLAMA_PREFIX/bin/llama-cli" --list-devices
for tool in \
  llama-cli llama-server llama-bench llama-quantize \
  llama-perplexity llama-imatrix llama-gguf-split \
  llama-tokenize llama-tts
do
  printf '\n===== %s =====\n' "$tool"
  ldd "$LLAMA_PREFIX/bin/$tool" | grep 'not found' || true
done
```

Now, from

```bash
module load ceuadmin/llama.cpp/0.7.0-cuda
llama --help
llama cli --list-devices
```

we have

```
$ llama --help
Usage: llama <command> [options]

Available commands:
  serve           HTTP API server
  cli             Command-line interactive interface
  download        Download a model
  version         Show version
  licenses        Show third-party licenses
  help            Show available commands

Run 'llama help all' to show additional commands.
Run 'llama <command> --help' for command-specific usage.
$ llama cli --list-devices
Available devices:
  CUDA0: NVIDIA L40 (48513 MiB, 47935 MiB free)
  CUDA1: NVIDIA L40 (48513 MiB, 47935 MiB free)
  CUDA2: NVIDIA L40 (48513 MiB, 47935 MiB free)
  CUDA3: NVIDIA L40 (48513 MiB, 47935 MiB free)
```

### b8676

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

### DeepSeek-V3-0324

```bash
wget https://huggingface.co/unsloth/DeepSeek-V3-0324-GGUF/resolve/main/UD-IQ2_XXS/DeepSeek-V3-0324-UD-IQ2_XXS-00001-of-00005.gguf
wget https://huggingface.co/unsloth/DeepSeek-V3-0324-GGUF/resolve/main/UD-IQ2_XXS/DeepSeek-V3-0324-UD-IQ2_XXS-00002-of-00005.gguf
wget https://huggingface.co/unsloth/DeepSeek-V3-0324-GGUF/resolve/main/UD-IQ2_XXS/DeepSeek-V3-0324-UD-IQ2_XXS-00003-of-00005.gguf
wget https://huggingface.co/unsloth/DeepSeek-V3-0324-GGUF/resolve/main/UD-IQ2_XXS/DeepSeek-V3-0324-UD-IQ2_XXS-00004-of-00005.gguf
wget https://huggingface.co/unsloth/DeepSeek-V3-0324-GGUF/resolve/main/UD-IQ2_XXS/DeepSeek-V3-0324-UD-IQ2_XXS-00005-of-00005.gguf
module load ceuadmin/llama.cpp
llama-gguf-split --merge DeepSeek-V3-0324-UD-IQ2_XXS-00001-of-00005.gguf DeepSeek-V3-0324-UD-IQ2_XXS.gguf
```

### DeepSeek-V4.1-Flash-Q4_K_M

```bash
source ~/rds/software/py3.11/bin/activate
hf auth login
hf download vcruz305/DeepSeek-V4.1-Flash-GGUF \
  --include "*Q4_K_M*.gguf" \
  --local-dir .
module load ceuadmin/llama.cpp/0.8.0-cuda
llama-gguf-split --merge \
  DeepSeek-V4.1-Flash-Q4_K_M-00001-of-00011.gguf \
  DeepSeek-V4.1-Flash-Q4_K_M.gguf
llama cli -m DeepSeek-V4.1-Flash-Q4_K_M.gguf \
  -p "Aspirin" -c 8192 -ngl 99
```

showing `gguf_merge: DeepSeek-V4.1-Flash-Q4_K_M.gguf merged from 11 split with 1046 tensors.` and also note that 0.8.0 still has difficulty with this model. We resort to

```bash
module load ceuadmin/llama.cpp/deepseek41-cuda
llama cli -m DeepSeek-V4.1-Flash-Q4_K_M.gguf -p "aspirin" 
```

with the following screenshot

```
Loading model...

▄▄ ▄▄
██ ██
██ ██  ▀▀█▄ ███▄███▄  ▀▀█▄    ▄████ ████▄ ████▄
██ ██ ▄█▀██ ██ ██ ██ ▄█▀██    ██    ██ ██ ██ ██
██ ██ ▀█▄██ ██ ██ ██ ▀█▄██ ██ ▀████ ████▀ ████▀
                                    ██    ██
                                    ▀▀    ▀▀

build      : b10905-5210c7c5e
model      : DeepSeek-V4.1-Flash-Q4_K_M.gguf
ftype      : Q4_K - Medium
modalities : text

available commands:
  /exit or Ctrl+C     stop or exit
  /regen              regenerate the last response
  /clear              clear the chat history
  /read <file>        add a text file
  /glob <pattern>     add text files using globbing pattern


 > aspirin
```

[Start thinking]

We need answer. User just "aspirin". Need likely provide info. We need respond. Could ask what they want? But likely wants info about aspirin. Need maybe concise. We can give overview: what it is, uses, dosage, safety, side effects, contraindications. Need be careful medical advice. Since query just aspirin, maybe define. We can say aspirin is acetylsalicylic acid, NSAID, analgesic/antipyretic/anti-inflammatory, antiplatelet. Uses: pain, fever, inflammation, cardiovascular prevention. Risks: GI bleeding, ulcers, bleeding, Reye's syndrome in children/teens with viral illness, asthma exacerbation, kidney issues. Interactions: warfarin, other NSAIDs, steroids, alcohol, methotrexate, etc. Dosage varies. Not medical advice. Ask if you want specific.

Need maybe mention low-dose 75-100 mg for cardiovascular. Pain/fever 325-650 mg every 4-6 hours, max 4g? But that's medical advice. We can include general info with caveat. Since user just says aspirin, maybe answer "Aspirin (acetylsalicylic acid) is..." Could be enough.

Need decide final length. Desired oververbosity 5. We can structure. We must not provide diagnosis. We can mention emergency: suspected overdose, allergic reaction, signs of bleeding. Also Reye's syndrome. Also not for children under 16/18 unless doctor. Actually UK: not for under 16. US: avoid in children/teens with viral illness due to Reye's. We can state.

Maybe user might be asking for "aspirin" as a drug. We can answer in general. We can ask clarifying if they want dosage for a specific condition. But final should satisfy. Maybe include "If you're asking about a specific use, tell me your age, condition, other meds, and whether pregnant."

Need maybe mention enteric-coated, chewable, suppository. Aspirin is also used after heart attack/stroke. Antiplatelet effect lasts 7-10 days due to platelet lifespan. That's important before surgery.

Let's craft final:

Aspirin = acetylsalicylic acid (ASA). Class: NSAID, salicylate. Effects: pain relief, fever reduction, anti-inflammatory, antiplatelet (irreversible COX inhibition). Uses:
- Pain/fever/inflammation: headaches, muscle aches, arthritis, etc.
- Cardiovascular: low-dose for secondary prevention after MI/stroke, sometimes primary prevention in selected high-risk patients.
- Acute MI: chewed 162-325 mg if instructed/emergency.
Dosing: varies. OTC adult pain/fever: 325-650 mg every 4-6h, max 4g/day. Low-dose CV: 75-100 mg daily. But follow label/doctor.
Side effects: stomach upset, heartburn, nausea, GI bleeding/ulcers, easy bruising/bleeding, tinnitus (overdose), kidney issues, allergic reactions/asthma.
Do not use: children/teens with viral illness (Reye's), active bleeding/ulcer, aspirin allergy, severe kidney/liver disease, pregnancy third trimester, before surgery unless told, with blood thinners unless supervised.
Interactions: warfarin, DOACs, other NSAIDs, corticosteroids, alcohol, methotrexate, some antidepressants.
Emergency: overdose, ringing in ears, rapid breathing, confusion, severe bleeding, allergic reaction -> seek help.
Not medical advice.

Maybe mention "If you meant something else, clarify." That is good.

Need maybe answer "aspirin" as just word. Could also mention "Aspirin is also known as Bayer." But no.

We need final only. Ensure no mention of policy. Good.

Maybe we can add "What do you want to know? Uses, dosage, safety, history?" But final can include. The user may just want definition. We can start with definition.

Need maybe include "Aspirin is not recommended for routine primary prevention in most people due to bleeding risk." That's good.

Let's compose final with headings and bullet list. Keep concise. Desired oververbosity 5. We'll produce maybe 300-400 words. That's okay.

Check for accuracy: Max OTC dose 4g/day. Some labels 3g? In US max 4g. Low-dose 81 mg. UK 75 mg. Acute MI 162-325 mg chewed. Reye's syndrome in children and teens during viral illness. Pregnancy: avoid in third trimester; low-dose may be prescribed for preeclampsia. Antiplatelet effect 7-10 days. Tinnitus is salicylism. Good.

Need maybe mention "aspirin can cause bronchospasm in aspirin-exacerbated respiratory disease." Fine.

Final.

[End thinking]

**Aspirin** (acetylsalicylic acid, ASA) is a common medication in the **NSAID** family. It works by blocking COX enzymes, which reduces pain, fever, and inflammation. At low doses, it also **thins the blood** by irreversibly inhibiting platelets.

**Common uses**
- Pain, headache, fever, and inflammation
- Arthritis and other inflammatory conditions
- **Low-dose cardiovascular prevention**: after heart attack, stroke, or stent placement; sometimes in selected high-risk people
- **Acute heart attack**: chewed aspirin may be used in an emergency, if instructed by emergency services

**Typical dosing**
- Adult pain/fever: often **325–650 mg every 4–6 hours**, max about **4 g/day**
- Cardiovascular prevention: often **75–100 mg daily**
- Dosing depends on age, condition, and other medicines. Follow the label or a clinician’s instructions.

**Important risks/side effects**
- Stomach upset, heartburn, nausea
- **GI bleeding and ulcers**
- Increased bleeding/bruising
- Allergic reactions, asthma worsening in some people
- Kidney problems
- Ringing in the ears (tinnitus) can be a sign of too much aspirin
- **Reye’s syndrome**: avoid in children/teenagers with viral illness unless a doctor says otherwise

**Do not use without medical advice if you have**
- Active bleeding, ulcer, or bleeding disorder
- Aspirin/NSAID allergy
- Severe kidney or liver disease
- Pregnancy, especially the third trimester
- Surgery planned soon
- Are taking blood thinners, steroids, other NSAIDs, or some antidepressants

**Emergency signs**: severe bleeding, allergic reaction, confusion, rapid breathing, or suspected overdose — seek immediate medical help.

This is general information, not medical advice. If you want details for a specific situation, tell me your age, symptoms, other medicines, and whether you’re pregnant.


### DrugAssist-7B.Q8_0

We see from `llama cli -m DrugAssist-7B.Q8_0.gguf -p "Aspirin"`.

```
Loading model...

▄▄ ▄▄
██ ██
██ ██  ▀▀█▄ ███▄███▄  ▀▀█▄    ▄████ ████▄ ████▄
██ ██ ▄█▀██ ██ ██ ██ ▄█▀██    ██    ██ ██ ██ ██
██ ██ ▀█▄██ ██ ██ ██ ▀█▄██ ██ ▀████ ████▀ ████▀
                                    ██    ██
                                    ▀▀    ▀▀

build      : b0-unknown
model      : DrugAssist-7B.Q8_0.gguf
ftype      : Q8_0
modalities : text

available commands:
  /exit or Ctrl+C     stop or exit
  /regen              regenerate the last response
  /clear              clear the chat history
  /read <file>        add a text file
  /glob <pattern>     add text files using globbing pattern



> Aspirin
```

 Aspirin is a non-steroidal anti-inflammatory drug (NSAID) that is commonly used to relieve mild-to-moderate pain, reduce fever, and alleviate inflammation. The most common side effects of aspirin are gastrointestinal disturbances such as stomach irritation, nausea, and vomiting. It can also cause changes in heart rate and blood pressure, and might lead to allergic reactions in some individuals. It is important to consult a doctor before taking aspirin, as it can interact with other medications and can cause serious health problems in certain conditions.

[ Prompt: 410.0 t/s | Generation: 101.6 t/s ]

> pQTLs
 PQTLs (pharmacogenetic links) are genetic variations that can affect the response of an individual to drugs. They can identify people who are more likely to respond to a certain drug or have a higher risk of experiencing side effects. By understanding the PQTLs, doctors can better assess the potential benefits and risks of a certain medication.

[ Prompt: 981.2 t/s | Generation: 101.9 t/s ]

> pQTL-associated with aspirin
 The pQTLs associated with aspirin are genetic variations in the genes that code for cyclooxygenase (COX) enzymes. These enzymes are responsible for breaking down aspirin, and people with certain genetic variations can metabolize aspirin more or less efficiently. This can affect the effectiveness of aspirin in preventing heart attacks and strokes, as well as the risk of side effects. By identifying these pQTLs, doctors can better assess the appropriate dosage and long-term effectiveness of aspirin therapy.

[ Prompt: 896.5 t/s | Generation: 99.9 t/s ]

### TxGemma 9B Chat -  Q8_0

We see from `llama cli   -m txgemma-9b-chat-Q8_0-GGUF -p "Aspirin" -c 8192 -ngl 99`.

```
Loading model...

▄▄ ▄▄
██ ██
██ ██  ▀▀█▄ ███▄███▄  ▀▀█▄    ▄████ ████▄ ████▄
██ ██ ▄█▀██ ██ ██ ██ ▄█▀██    ██    ██ ██ ██ ██
██ ██ ▀█▄██ ██ ██ ██ ▀█▄██ ██ ▀████ ████▀ ████▀
                                    ██    ██
                                    ▀▀    ▀▀

build      : b0-unknown
model      : txgemma-9b-chat-Q8_0-GGUF
ftype      : Q8_0
modalities : text

available commands:
  /exit or Ctrl+C     stop or exit
  /regen              regenerate the last response
  /clear              clear the chat history
  /read <file>        add a text file
  /glob <pattern>     add text files using globbing pattern


> Aspirin
```

## Aspirin: An Overview

Aspirin, also known by its chemical name acetylsalicylic acid, is a **nonsteroidal anti-inflammatory drug (NSAID)** widely used for its pain-relieving, fever-reducing, and anti-inflammatory properties.

**Uses:**

* **Pain relief:**  Headaches, muscle aches, toothaches, menstrual cramps, arthritis pain
* **Fever reduction:** Flu, colds, other infections
* **Inflammation reduction:** Arthritis, other inflammatory conditions
* **Prevention:** Heart attacks, strokes, certain types of cancer

**How it works:**

Aspirin works by blocking the production of prostaglandins, chemicals that contribute to pain, fever, and inflammation.

**Forms:**

* **Tablets:** Available in various strengths (e.g., 81mg, 325mg, 500mg, 650mg)
* **Capsules:**  Often enteric-coated to protect the stomach lining
* **Liquid suspensions:** For children and those who have difficulty swallowing pills
* **Chewable tablets:** For faster absorption

**Dosage:**

* **Always follow your doctor's instructions.**
* **Read the label carefully.**
* **Do not exceed the recommended dosage.**

**Side effects:**

* **Common:** Stomach upset, heartburn, nausea, ringing in the ears, drowsiness
* **Serious (rare):** Stomach bleeding, internal bleeding, allergic reaction, Reye's syndrome (in children and teenagers recovering from chickenpox or flu-like symptoms)

**Interactions:**

Aspirin can interact with other medications, including:

* **Blood thinners**
* **Antibiotics**
* **Blood pressure medications**
* **Other NSAIDs**

**Important considerations:**

* **Children and teenagers:** Reye's syndrome is a rare but serious condition that can occur in children and teenagers taking aspirin. Aspirin should not be given to children or teenagers recovering from chickenpox or flu-like symptoms unless specifically directed by a doctor.
* **Stomach problems:** Aspirin can irritate the stomach lining. Taking it with food can help reduce the risk of stomach upset.
* **Bleeding risk:** Aspirin can increase the risk of bleeding. Talk to your doctor before taking aspirin if you have a bleeding disorder or are taking blood thinners.
* **Allergic reaction:** Some people are allergic to aspirin. If you experience any signs of an allergic reaction (e.g., hives, swelling, difficulty breathing), seek medical attention immediately.

**Disclaimer:**

This information is for general knowledge purposes only and should not be considered medical advice. Always consult with a qualified healthcare professional for any health concerns or before making any decisions related to your health or treatment.

[ Prompt: 220.1 t/s | Generation: 69.7 t/s ]


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
llama-server -hf ggml-org/gpt-oss-20b-GGUF --ctx-size 0 --jinja -ub 2048 -b 2048 -ngl 99
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
hf auth login
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

[^CPATH]: **CPATH**

    CUDA 11.4 may be seen from this

    ```
    printf '%s\n' "$CPATH" | tr ':' '\n' | grep -E '/cuda/11\.4(/|$)'
    ```   

    showing `/usr/local/software/cuda/11.4/include`.
