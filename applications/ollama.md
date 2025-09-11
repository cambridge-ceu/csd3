---
sort: 48
---

# ollama

Web: <https://ollama.com/>.

## Setup

```bash
curl -L https://ollama.com/download/ollama-linux-amd64.tgz | \
tar xvfz -
ollama --help
ollama serve &
ollama list
ollama pull vicuna
ollama run vicuna
ollama run llava:7b cafe.png > cafe.txt 2>&1 &
```

We see that it is listening on 127.0.0.1:11434 and the list gives,

```
NAME             ID              SIZE      MODIFIED
vicuna:latest    370739dc897b    3.8 GB    About an hour ago
```

For information, we start

```bash
module load ceuadmin/chrome
chrome 127.0.0.1:11434 &
```

so upon visiting <http://127.0.0.1:11434/>, we see the message: `Ollama is running`.

The port number can be reset as follows,

```bash
export OLLAMA_HOST=127.0.0.1:8000
```

Lastly, use

`ollama serve > ollama.log 2>&1 &`

to run `ollama serve` in the background with proper output redirection; so for `ollama run llava:7b cafe.png > cafe.txt 2>&1 &`, we have `cafe.txt`,

```
This image shows the interior of a café, with a focus on the counter and bar area. There is a menu board displaying various food and
drink options, which suggests that this establishment offers a variety of beverages and possibly some light bites to its patrons. The
atmosphere appears warm and inviting, with natural light filtering in through the windows. It's a common type of establishment found in
many urban areas where people can relax, grab a coffee or tea, or have a quick meal while socializing with friends or colleagues.
```

## REST API: /api/generate

From the information given above, our benchmark query is

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "vicuna",
  "prompt":"Why is the sky blue?"
}'
```

for

```
{"model":"vicuna","created_at":"2025-02-26T15:52:08.033372608Z","response":"The","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:52:19.013203585Z","response":" sky","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:52:30.169018453Z","response":" appears","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:52:38.610246706Z","response":" blue","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:52:51.112631597Z","response":" because","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:53:04.658534982Z","response":" the","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:53:16.545709472Z","response":" Earth","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:53:25.847381482Z","response":"'","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:53:38.26035216Z","response":"s","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:53:50.284336659Z","response":" atmosphere","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:54:01.882921844Z","response":" sc","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:54:13.02017634Z","response":"at","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:54:52.380050323Z","response":"ters","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:55:31.189141976Z","response":" sun","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:56:10.51627649Z","response":"light","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:56:54.358850128Z","response":" in","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:57:37.112980093Z","response":" all","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:58:18.925277666Z","response":" directions","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:59:00.970326803Z","response":" and","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:59:32.906412411Z","response":" blue","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:00:13.823243117Z","response":" light","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:00:51.289339579Z","response":" is","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:01:23.171158404Z","response":" scattered","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:01:57.156218709Z","response":" more","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:02:34.033815548Z","response":" than","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:03:10.703723612Z","response":" other","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:03:47.831095477Z","response":" colors","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:04:23.606689219Z","response":" because","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:04:58.280022861Z","response":" it","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:05:31.74819872Z","response":" travel","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:06:10.808630811Z","response":"s","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:06:50.031448392Z","response":" as","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:07:34.415700349Z","response":" shorter","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:08:11.074102396Z","response":",","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:08:48.048098059Z","response":" smaller","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:09:24.265911278Z","response":" waves","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:10:02.628471441Z","response":".","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:10:44.617544189Z","response":" This","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:11:20.059551286Z","response":" is","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:11:57.277295769Z","response":" why","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:12:31.618643207Z","response":" the","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:13:03.279528158Z","response":" sky","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:13:36.181278012Z","response":" appears","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:14:12.171329827Z","response":" blue","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:14:51.749555584Z","response":" during","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:15:32.594256988Z","response":" the","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:16:11.214666904Z","response":" day","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:16:45.836110502Z","response":"time","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:17:17.724983503Z","response":".","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:17:50.696229461Z","response":" At","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:18:23.257469228Z","response":" night","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:18:57.557381563Z","response":",","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:19:30.689885735Z","response":" when","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:20:06.602847917Z","response":" the","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:20:40.877262517Z","response":" Sun","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:21:19.590447669Z","response":" is","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:21:53.013907482Z","response":" not","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:22:27.903756015Z","response":" visible","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:23:00.580469912Z","response":",","done":false}
...
```

## Chat: /api/chat

From

```bash
curl http://localhost:11434/api/chat -d '{
  "model": "vicuna",
  "messages": [
    { "role": "user", "content": "why is the sky blue?" }
  ]
}' > answers.json
```

We get a json output, or equivalently from the CLI,

```
>>> /?
Available Commands:
  /set            Set session variables
  /show           Show model information
  /load <model>   Load a session or model
  /save <model>   Save your current session
  /clear          Clear session context
  /bye            Exit
  /?, /help       Help for a command
  /? shortcuts    Help for keyboard shortcuts

Use """ to begin a multi-line message.

>>> /show info

  Model
    architecture        llama
    parameters          6.7B
    context length      4096
    embedding length    4096
    quantization        Q4_0

  Parameters
    stop    "USER:"
    stop    "ASSISTANT:"

  System
    A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful,
      detailed, and polite answers to the user's questions.

>>>  why the sky is blue
```

> The sky appears blue because of a phenomenon called Rayleigh scattering. This occurs when shorter wavelengths of light, like blue and
> violet, are scattered in all directions by tiny molecules of gases such as nitrogen and oxygen that make up the Earth's atmosphere. The
> scattering of these wavelengths causes them to be spread out over the entire visible spectrum, making the sky appear white or bright.
>
> However, the sun's rays are mainly blue during daylight hours, so when the sun is in the sky, the blue light from the sun is scattered
> all around and reaches our eyes, which makes the sky appear blue.

The answer could be slightly different in form, e.g.,

> The color of the sky appears blue because the Earth's atmosphere scatters sunlight in all directions and blue light is scattered more
> than other colors because it travels as shorter, smaller waves. This scattering of light makes it appear as if the sky is blue,
> especially during the daytime when the Sun is high in the sky. The color of the sky can also be affected by the amount of water vapor and
> dust particles in the atmosphere, which can make the sky appear more hazy or gray.

This is from deepseek-r1.32b,

> The sky appears blue due to Rayleigh scattering. Sunlight consists of various colors, each with different wavelengths. Blue light has a shorter wavelength and is scattered more by
> molecules in the atmosphere, like nitrogen and oxygen. This scattering occurs predominantly during the day when the sun is high, making the sky appear blue. At sunrise or sunset,
> longer paths through the atmosphere scatter out much of the blue light, revealing reds and oranges. Additionally, higher altitudes with thinner air result in a deeper blue sky due to
> reduced scattering.

## Llama 4

Web, <https://ollama.com/library/llama4>

This requires a recent version of ollama, nevertheless can be more specific,

```bash
ollama run llama4:scout
ollama run llama4:maverick
```

## A big or many model(s)

We could use the same trick elsewhere, e.g.,

```bash
export OLLAMA_MODELS=/rds/usr/$USER/hpc-work/HuggingFace
ln -sf ${OLLAMA_MODELS} $HOME/.ollama
```

## SLURM

It is lengthy from the login session, so an attempt is made for a batch job,

```bash
#!/usr/bin/bash

#SBATCH --job-name=_ollama
#SBATCH --account PETERS-SL3-CPU
#SBATCH --partition icelake-himem
#SBATCH --mem=28800
#SBATCH --time=12:00:00
#SBATCH --error=/rds/user/jhz22/hpc-work/ollama/_ollama_%A_%a.err
#SBATCH --output=/rds/user/jhz22/hpc-work/ollama/_ollama_%A_%a.out
#SBATCH --export ALL

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl
module load ceuadmin/ollama

export TMPDIR=/rds/user/jhz22/hpc-work/work
export output=/rds/user/jhz22/hpc-work/ollama/gemma3.txt

ollama serve &
sleep 1m
touch $output
ollama run gemma3 "Why the sky is blue?" >> $output
```

where 1 minute is granted to establish the server, followed by a call with our prompt as a command-line argument.

## GGUF

> ​GGUF, which stands for Generic GPT Unified Format, is a binary file format designed for efficiently storing and loading large language models (LLMs). Developed as an extension of the GGML format, GGUF addresses the need for scalable and efficient deployment of extensive models, particularly those exceeding 100GB in size.

Next, we build Llama-4-Maverick-17B-128E as described in <https://cambridge-ceu.github.io/csd3/systems/setup.html#fn:llama_cpp>

```bash
echo FROM ./Llama-4-Maverick-17B-128E-Instruct.gguf > Modelfile
ollama create llama4maverick -f Modelfile
ollama list
```

to get

```
NAME                                                       ID              SIZE      MODIFIED
llama4maverick:latest                                      46d3f0108969    425 GB    About an hour ago
mistrallite:latest                                         19594c72ecfd    4.4 GB    2 hours ago
llama3.2:3b-instruct-q4_K_M                                a80c4f17acd5    2.0 GB    12 days ago
gemma3:latest                                              c0494fe00251    3.3 GB    6 weeks ago
hf.co/unsloth/DeepSeek-R1-Distill-Llama-70B-GGUF:Q3_K_M    f24fb6af4e5f    34 GB     6 weeks ago
qwen:latest                                                d53d04290064    2.3 GB    7 weeks ago
mistral:latest                                             f974a74358d6    4.1 GB    7 weeks ago
r1-1776:latest                                             140ea940f21d    42 GB     2 months ago
gemma2:latest                                              ff02c3702f32    5.4 GB    2 months ago
gemma2:27b                                                 53261bc9c192    15 GB     2 months ago
phi4:latest                                                ac896e5b8b34    9.1 GB    2 months ago
llama3.3:latest                                            a6eb4748fd29    42 GB     2 months ago
deepseek-r1:32b                                            38056bbcbb2d    19 GB     2 months ago
vicuna:latest                                              370739dc897b    3.8 GB    2 months ago
```

One can also avoid explicitly using a `Modelfile`,

```bash
#!/usr/bin/env bash

module load ceuadmin/ollama
ollama serve &
OLLAMA_PID=$!
sleep 10
if [ -z "$1" ]; then
    INPUT_FILE="DeepSeek-V3-0324-UD-IQ2_XXS.gguf"
    OUTPUT_MODEL="deepseekv3"
else
    INPUT_FILE="$1"
    OUTPUT_MODEL="$2"
fi
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found."
    kill $OLLAMA_PID
    exit 1
fi
echo "FROM ./$INPUT_FILE" | \
ollama create "$OUTPUT_MODEL" -f -
ollama run "$OUTPUT_MODEL"
kill $OLLAMA_PID
```

To get the latest (as of 6/8/2025) GPT-oss models from OpenAI,

```bash
ollama run gpt-oss:20b
ollama run gpt-oss:120b
ollama run gpt-oss:20b --enable-web-search
```

as in <https://ollama.com/blog/gpt-oss> and/or <https://simonwillison.net/2025/Aug/5/gpt-oss/>.
