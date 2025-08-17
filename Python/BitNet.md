---
sort: 1
---

# BitNet

GitHub, <https://github.com/microsoft/BitNet>

```bash
git clone --recursive https://github.com/microsoft/BitNet.git b1.58-2B-4T
cd b1.58-2B-4T/
module load python/3.9.12/gcc/pdcqf4o5
python -m venv BitNet
source BitNet/bin/activate
pip install -r requirements.txt
huggingface-cli download microsoft/BitNet-b1.58-2B-4T-gguf --local-dir models/BitNet-b1.58-2B-4T
python setup_env.py -md models/BitNet-b1.58-2B-4T -q i2_s
python run_inference.py -m models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf -p "You are a helpful assistant" -cnv
```

The last line allows for prompt engineering,

```
> why the sky is blue

The sky appears blue due to a phenomenon called Rayleigh scattering. This effect occurs when sunlight, which appears white, passes through Earth's atmosphere and interacts with molecules and small particles in the air.

Sunlight is made up of many different wavelengths of light, each with its own specific color. Blue light has a shorter wavelength than red light. When sunlight enters the Earth's atmosphere, it collides with these molecules and small particles. The shorter blue light waves are scattered in all directions by the molecules and particles much more than the longer red light waves. This scattering of shorter wavelengths is

> what is the result of 10 + 45

The result of 10 + 45 is 55.
```

The module is much simplier to use, however,

```bash
module load ceuadmin/BitNet
run_inference -p "In this chapter, we'll discuss first steps with generative AI in Python."
run_inference -p "Write an essay about precision medicine" -n 900 -t 8
run_inference -p "Why the sky is blue" -n 900 -t 1
```

We have the first output as follows,

---

In this chapter, we'll discuss first steps with generative AI in Python. You will learn how to create and train a simple AI model using PyTorch, a deep learning library. This is a basic introduction to the topic and will not cover advanced topics. If you're new to machine learning, you might want to start with more basic tutorials. But, if you're interested in learning more about generative AI, this chapter will give you a good foundation.

## 1. Introduction

Generative AI refers to a class of AI systems that generate new data. These systems can produce text, images, audio, and more. They can be used in various applications, such as content creation, data augmentation,

---

We then have the essay [precision-medicine.md](files/precision-medicine.md) and an updated answer [why-the-sky-is-blue.md](files/why-the-sky-is-blue.md). The usage is also quoted here,

```
usage: run_inference.py [-h] [-m MODEL] [-n N_PREDICT] -p PROMPT [-t THREADS] [-c CTX_SIZE] [-temp TEMPERATURE] [-cnv]

Run inference

optional arguments:
 -h, --help           show this help message and exit
 -m MODEL, --model MODEL
                      Path to model file
 -n N_PREDICT, --n-predict N_PREDICT
                      Number of tokens to predict when generating text
 -p PROMPT, --prompt PROMPT
                      Prompt to generate text from
 -t THREADS, --threads THREADS
                      Number of threads to use
 -c CTX_SIZE, --ctx-size CTX_SIZE
                      Size of the prompt context
 -temp TEMPERATURE, --temperature TEMPERATURE
                      Temperature, a hyperparameter that controls the randomness of the generated text
 -cnv, --conversation  Whether to enable chat mode or not (for instruct models.)
                      (When this option is turned on, the prompt specified by -p will be used as the system prompt.)
```
