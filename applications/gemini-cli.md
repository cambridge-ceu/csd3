---
sort: 32
---

# gemini-cli

Web: <https://geminicli.com/>

## Setup

This takes advanatage of ceuadmin/node modules.

```bash
module avail ceuadmin/node
# --------------------------------------------------- /usr/local/Cluster-Config/modulefiles ----------------------------------------------------
# ceuadmin/node/18.20.5  ceuadmin/node/20.18.2  ceuadmin/node/22.16.0
module load ceuadmin/node/22.16.0
which node
# /usr/local/Cluster-Apps/ceuadmin/node/22.16.0/bin/node
npm i -g @google/gemini-cli
# ls /usr/local/Cluster-Apps/ceuadmin/node/22.16.0/lib/node_modules/@google
gemini --version
# 0.22.4
```

Run `npm install -g @google/gemini-cli@latest` for the latest version.

## A session

```bash
# Get your key from https://aistudio.google.com/apikey
export GEMINI_API_KEY=$(cat $HOME/doc/gemini-cli)
module load ceuadmin/node/22.16.0
gemini
```

```
 ███            █████████  ██████████ ██████   ██████ █████ ██████   █████ █████
░░░███         ███░░░░░███░░███░░░░░█░░██████ ██████ ░░███ ░░██████ ░░███ ░░███
  ░░░███      ███     ░░░  ░███  █ ░  ░███░█████░███  ░███  ░███░███ ░███  ░███
    ░░░███   ░███          ░██████    ░███░░███ ░███  ░███  ░███░░███░███  ░███
     ███░    ░███    █████ ░███░░█    ░███ ░░░  ░███  ░███  ░███ ░░██████  ░███
   ███░      ░░███  ░░███  ░███ ░   █ ░███      ░███  ░███  ░███  ░░█████  ░███
 ███░         ░░█████████  ██████████ █████     █████ █████ █████  ░░█████ █████
░░░            ░░░░░░░░░  ░░░░░░░░░░ ░░░░░     ░░░░░ ░░░░░ ░░░░░    ░░░░░ ░░░░░

Tips for getting started:
1. Ask questions, edit files, or run commands.
2. Be specific for the best results.
3. Create GEMINI.md files to customize your interactions with Gemini.
4. /help for more information.


> /quit

╭────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│                                                                                                                                            │
│  Agent powering down. Goodbye!                                                                                                             │
│                                                                                                                                            │
│  Interaction Summary                                                                                                                       │
│  Session ID:                 809de783-3404-44dd-86e6-bc73d3f16280                                                                          │
│  Tool Calls:                 0 ( ✓ 0 x 0 )                                                                                                 │
│  Success Rate:               0.0%                                                                                                          │
│                                                                                                                                            │
│  Performance                                                                                                                               │
│  Wall Time:                  20.6s                                                                                                         │
│  Agent Active:               0s                                                                                                            │
│    » API Time:               0s (0.0%)                                                                                                     │
│    » Tool Time:              0s (0.0%)                                                                                                     │
│                                                                                                                                            │
│                                                                                                                                            │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

To switch model, use `/model` and `/settings`.
