---
sort: 40
---

# hermes-agent

GitHub, <https://github.com/NousResearch/hermes-agent>

## 2026.4.13 (0.9.0)

```bash
VERSION=2026.4.13
PREFIX=$CEUADMIN/hermes-agent/$VERSION
mkdir -p "$PREFIX"
cd "$PREFIX"
wget -qO- https://github.com/NousResearch/hermes-agent/archive/refs/tags/v${VERSION}.tar.gz \
  | tar -xz --strip-components=1
module load ceuadmin/python/3.12.10
python -m venv $PREFIX/venv
source $PREFIX/venv/bin/activate
pip install .
```

The module file is as follows,

```
#%Module -*- tcl -*-
##
## hermes-agent modulefile
##

proc ModulesHelp { } {

  puts stderr "\thermes-agent: NousResearch CLI agent\n"
  puts stderr "\tInstalled under: /usr/local/Cluster-Apps/ceuadmin/hermes-agent/2026.4.13\n"
  puts stderr "\tHomepage: https://github.com/NousResearch/hermes-agent"
}

module-whatis "NousResearch Hermes Agent CLI tool."

set               root                 /usr/local/Cluster-Apps/ceuadmin/hermes-agent/2026.4.13/venv

prepend-path      PATH                 $root/bin
setenv            VIRTUAL_ENV          $root
```

## Usage

```bash
module load ceuadmin/hermes-agent
which hermes-agent
hermes setup
hermes-agent --help
```

## Ollama

URL, <https://docs.ollama.com/integrations/hermes>

```bash
module load ceuadmin/ollama
ollama serve > /dev/null 2>&1 &
hermes setup
```

The screen shot is given below,

```
How would you like to set up Hermes?
  ↑↓ navigate  ENTER/SPACE select  ESC cancel

 → (●) Quick setup — provider, model & messaging (recommended)
   (○) Full setup — configure everything

Select provider:
  ↑↓ navigate  ENTER/SPACE select  ESC cancel

   (●) Nous Portal (Nous Research subscription)
   (○) OpenRouter (100+ models, pay-per-use)
   (○) Anthropic (Claude models — API key or Claude Code)
   (○) OpenAI Codex
   (○) Qwen OAuth (reuses local Qwen CLI login)
   (○) GitHub Copilot (uses GITHUB_TOKEN or gh auth token)
   (○) Hugging Face Inference Providers (20+ open models)
   (○) Local (127.0.0.1:11434) (127.0.0.1:11434/v1) — kimi-k2.5:cloud
 → (○) More providers...
   (○) Cancel

Select provider:
  ↑↓ navigate  ENTER/SPACE select  ESC cancel

   (●) GitHub Copilot ACP (spawns `copilot --acp --stdio`)
   (○) Google AI Studio (Gemini models — OpenAI-compatible endpoint)
   (○) Z.AI / GLM (Zhipu AI direct API)
   (○) Kimi / Moonshot (Moonshot AI direct API)
   (○) Kimi / Moonshot China (Moonshot CN direct API)
   (○) MiniMax (global direct API)
   (○) MiniMax China (domestic direct API)
   (○) Kilo Code (Kilo Gateway API)
   (○) OpenCode Zen (35+ curated models, pay-as-you-go)
   (○) OpenCode Go (open models, $10/month subscription)
   (○) AI Gateway (Vercel — 200+ models, pay-per-use)
   (○) Alibaba Cloud / DashScope Coding (Qwen + multi-provider)
   (○) Xiaomi MiMo (MiMo-V2 models — pro, omni, flash)
 → (○) Custom endpoint (enter URL manually)
   (○) Remove a saved custom provider
   (○) Cancel

Custom OpenAI-compatible endpoint configuration:

API base URL [e.g. https://api.example.com/v1]: http://127.0.0.1:11434/v1
API key [optional]:
Verified endpoint via http://127.0.0.1:11434/v1/models (20 model(s) visible)
  Available models:
    1. gemma4:26b
    2. glm-5.1:cloud
    3. gemma4:e4b
    4. gemma4:e2B
    5. glm-4.7-flash:latest
    6. gemma4:31b-cloud
    7. qwen3.5:9b
    8. qwen3.5:27b
    9. kimi-k2.5:cloud
    10. minimax-m2.7:cloud
    11. minimax-m2.5:cloud
    12. qwen3-coder:480b-cloud
    13. deepseek-v3.1:671b-cloud
    14. gpt-oss:20b
    15. llava:7b
    16. phi4:latest
    17. gemma3:latest
    18. qwen:latest
    19. mistral:latest
    20. vicuna:latest
  Select model [1-20] or type name: 9
Model name (e.g. gpt-4, llama-3-70b): kimi-k2.5:cloud
Context length in tokens [leave blank for auto-detect]:
Connect a messaging platform? (Telegram, Discord, etc.)
  ↑↓ navigate  ENTER/SPACE select  ESC cancel

   (●) Set up messaging now (recommended)
 → (○) Skip — set up later with 'hermes setup gateway'
Default model set to: kimi-k2.5:cloud (via http://127.0.0.1:11434/v1)
✓ Applied recommended defaults:
    Max iterations: 90
    Tool progress: all
    Compression threshold: 0.50
    Session reset: inactivity (1440 min) + daily (4:00)
    Run `hermes setup agent` later to customize.



✓ Setup complete! You're ready to go.

    Configure all settings:    hermes setup
    Connect Telegram/Discord:  hermes setup gateway



◆ Tool Availability Summary
  5/11 tool categories available:

   ✓ Vision (image analysis)
   ✗ Mixture of Agents (missing OPENROUTER_API_KEY)
   ✗ Web Search & Extract (missing EXA_API_KEY, PARALLEL_API_KEY, FIRECRAWL_API_KEY/FIRECRAWL_API_URL, or TAVILY_API_KEY)
   ✗ Browser Automation (missing npm install -g agent-browser)
   ✗ Image Generation (missing FAL_KEY)
   ✓ Text-to-Speech (Edge TTS)
   ✗ RL Training (Tinker) (missing TINKER_API_KEY)
   ✗ Skills Hub (GitHub) (missing GITHUB_TOKEN)
   ✓ Terminal/Commands
   ✓ Task Planning (todo)
   ✓ Skills (view, create, edit)

⚠ Some tools are disabled. Run 'hermes setup tools' to configure them,
⚠ or edit ~/.hermes/.env directly to add the missing API keys.


┌─────────────────────────────────────────────────────────┐
│              ✓ Setup Complete!                          │
└─────────────────────────────────────────────────────────┘

📁 All your files are in ~/.hermes/:

   Settings:  /home/jhz22/.hermes/config.yaml
   API Keys:  /home/jhz22/.hermes/.env
   Data:      /home/jhz22/.hermes/cron/, sessions/, logs/

────────────────────────────────────────────────────────────

📝 To edit your configuration:

   hermes setup          Re-run the full wizard
   hermes setup model    Change model/provider
   hermes setup terminal Change terminal backend
   hermes setup gateway  Configure messaging
   hermes setup tools    Configure tool providers

   hermes config         View current settings
   hermes config edit    Open config in your editor
   hermes config set <key> <value>
                          Set a specific value

   Or edit the files directly:
   nano /home/jhz22/.hermes/config.yaml
   nano /home/jhz22/.hermes/.env

────────────────────────────────────────────────────────────

🚀 Ready to go!

   hermes              Start chatting
   hermes gateway      Start messaging gateway
   hermes doctor       Check for issues


Launch hermes chat now? [Y/n]: y
```

We see

```

██╗  ██╗███████╗██████╗ ███╗   ███╗███████╗███████╗       █████╗  ██████╗ ███████╗███╗   ██╗████████╗
██║  ██║██╔════╝██╔══██╗████╗ ████║██╔════╝██╔════╝      ██╔══██╗██╔════╝ ██╔════╝████╗  ██║╚══██╔══╝
███████║█████╗  ██████╔╝██╔████╔██║█████╗  ███████╗█████╗███████║██║  ███╗█████╗  ██╔██╗ ██║   ██║
██╔══██║██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══╝  ╚════██║╚════╝██╔══██║██║   ██║██╔══╝  ██║╚██╗██║   ██║
██║  ██║███████╗██║  ██║██║ ╚═╝ ██║███████╗███████║      ██║  ██║╚██████╔╝███████╗██║ ╚████║   ██║
╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝      ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝   ╚═╝

╭───────────────────────────────────────────────────── Hermes Agent v0.9.0 (2026.4.13) ──────────────────────────────────────────────────────╮
│                                   Available Tools                                                                                          │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⡀⠀⣀⣀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   browser: browser_back, browser_click, ...                                                                │
│  ⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣇⠸⣿⣿⠇⣸⣿⣿⣷⣦⣄⡀⠀⠀⠀⠀⠀⠀   clarify: clarify                                                                                         │
│  ⠀⢀⣠⣴⣶⠿⠋⣩⡿⣿⡿⠻⣿⡇⢠⡄⢸⣿⠟⢿⣿⢿⣍⠙⠿⣶⣦⣄⡀⠀   code_execution: execute_code                                                                             │
│  ⠀⠀⠉⠉⠁⠶⠟⠋⠀⠉⠀⢀⣈⣁⡈⢁⣈⣁⡀⠀⠉⠀⠙⠻⠶⠈⠉⠉⠀⠀   cronjob: cronjob                                                                                         │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⡿⠛⢁⡈⠛⢿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   delegation: delegate_task                                                                                │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⣿⣦⣤⣈⠁⢠⣴⣿⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   file: patch, read_file, search_files, write_file                                                         │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠻⢿⣿⣦⡉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   homeassistant: ha_call_service, ha_get_state, ...                                                        │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢷⣦⣈⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   image_gen: image_generate                                                                                │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣴⠦⠈⠙⠿⣦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   (and 11 more toolsets...)                                                                                │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣤⡈⠁⢤⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                                                                                                            │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠷⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   Available Skills                                                                                         │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠑⢶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   No skills installed                                                                                      │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠁⢰⡆⠈⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                                                                                                            │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⠈⣡⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   18 tools · 0 skills · /help for commands                                                                 │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                                                                                                            │
│                                                                                                                                            │
│  kimi-k2.5:cloud · Nous Research                                                                                                           │
│            /home/jhz22                                                                                                                     │
│  Session: 20260415_221510_71ca6d                                                                                                           │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

Welcome to Hermes Agent! Type your message or /help for commands.
✦ Tip: hermes auth add lets you add multiple API keys for credential pool rotation.

  ⚠ tirith security scanner enabled but not available — command scanning will use pattern matching only
 ⚕ kimi-k2.5:cloud │ ctx -- │ [░░░░░░░░░░] -- │ 20s
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
❯

Welcome to Hermes Agent! Type your message or /help for commands.
✦ Tip: Smart routing can auto-route simple queries to a cheaper model — set smart_model_routing.enabled: true.

  ⚠ tirith security scanner enabled but not available — command scanning will use pattern matching only
────────────────────────────────────────

● why the sky is blue
Initializing agent...
────────────────────────────────────────

 ─  ⚕ Hermes  ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

   The sky appears blue due to a phenomenon called **Rayleigh scattering**.

   Here's the simple explanation:

   Sunlight appears white, but it's actually made of all colors mixed together. When sunlight enters Earth's atmosphere, it hits gas
   molecules (mostly nitrogen and oxygen). These tiny particles scatter the light in all directions.

   **Blue light gets scattered much more than other colors** because it has a shorter wavelength. In fact, blue light scatters about 10
   times more than red light. This scattered blue light comes at us from all directions, making the sky appear blue.

   Violet light actually scatters even more than blue, but two things work against it:
   1. The sun emits less violet light to begin with
   2. Our eyes are less sensitive to violet compared to blue

   **Why is the sky red at sunset?** When the sun is near the horizon, light travels through more atmosphere. Most of the blue light has
   already been scattered away by the time it reaches you, leaving the longer wavelengths (red, orange) to dominate what you see.

   The same principle explains why the Moon can look orange near the horizon - it's the same scattering effect removing blue light from the
   path.

 ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 ⚕ kimi-k2.5:cloud │ 6.32K/262.1K │ [░░░░░░░░░░] 2% │ 47s
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
❯
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

⚙️  /exit

Resume this session with:
  hermes --resume 20260415_223117_c220bb

Session:        20260415_223117_c220bb
Duration:       47s
Messages:       2 (1 user, 0 tool calls)
```
