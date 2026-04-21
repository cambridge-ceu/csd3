---
sort: 19
---

# codex-cli

Official page: <https://openai.com/codex/>

## 0.120.0

Web, <https://www.npmjs.com/package/@openai/codex>

This following is is in line with setup for OpenClaw, Pi, etc., which is more explicit.

```bash
module load ceuadmin/node/22.16.0
npm i -g @openai/codex@0.120.0 --prefix=$CEUADMIN/codex-cli/0.120.0
```

A profile is with `~/.codex/config.toml`.

## Integration with Ollama & llama.cpp

URL, <https://docs.ollama.com/integrations/codex>

```
[model_providers.ollama-launch]
name = "Ollama"
base_url = "http://localhost:11434/v1"

[profiles.ollama-launch]
model = "gpt-oss:120b"
model_provider = "ollama-launch"

[profiles.ollama-cloud]
model = "gpt-oss:120b-cloud"
model_provider = "ollama-launch"
```

which enables,

```bash
codex --profile ollama-launch
codex --profile ollama-cloud
```

The [article](https://medium.com/google-cloud/i-ran-gemma-4-as-a-local-model-in-codex-cli-7fda754dc0d4) recommeneds use of Ollama 0.20.5, 

```bash
ollama launch codex --config
codex --oss -m gpt-oss:120b
codex --oss -m gpt-oss:120b-cloud
ollama pull gemma4:31b
codex --oss -m gemma4:31b
```

and llama.cpp with these options.

```bash
llama-server \
  -m gemma-4-26B-A4B-it-Q4_K_M.gguf \
  --port 1234 -ngl 99 -c 32768 -np 1 --jinja \
  -ctk q8_0 -ctv q8_0
```

> The -np 1 limits to a single slot, because multiple slots multiply KV cache memory. The -ctk q8_0 -ctv q8_0 quantises the KV cache, reducing it from 940 MB to 499 MB. The --jinja flag is required for Gemma 4's tool-calling template. And -m with a direct path avoids the -hf flag, which silently downloads a 1.1 GB vision projector that causes an out-of-memory crash.
> The Codex CLI config also needs web_search = "disabled", because Codex CLI sends a web_search_preview tool type that llama.cpp rejects. 
