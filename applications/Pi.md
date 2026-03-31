---
sort: 58
---

# Pi

## Installation

Pi is a minimal coding harness for workflows and coding agents.

```bash
module load ceuadmin/node/22.16.0
export BASE="$CEUADMIN/Pi/0.64.0"
npm install -g @mariozechner/pi-coding-agent --prefix "$BASE"
module load ceuadmin/Pi/0.64.0
which pi
pi --version
ln -fs "$BASE" ~/.pi
npm install -g pi-subagents --prefix "$BASE"
pi install "$BASE/lib/node_modules/pi-subagents"
pi install https://github.com/davebcn87/pi-autoresearch
pi list
```

Specifically, `pi list` ensures the location of modules is consistent,

```
User packages:
  ../../../../usr/local/Cluster-Apps/ceuadmin/Pi/0.64.0/lib/node_modules/pi-subagents
    /usr/local/Cluster-Apps/ceuadmin/Pi/0.64.0/lib/node_modules/pi-subagents
  https://github.com/davebcn87/pi-autoresearch
    /home/jhz22/.pi/agent/git/github.com/davebcn87/pi-autoresearch
```

We couple with Ollama,

```bash
module load ceuadmin/ollama
ollama serve > /dev/null 2>&1 &
ollama list
module load ceuadmin/OpenClaw/2026.3.28
ollama launch pi --model kimi-k2.5:cloud
```
The pi-autoresearch module enables /autoresearch.

```
→ autoresearch                 [u:git:github.com/davebcn87/pi-autoresearch] Start, stop, clear, or resume autoresearch mode
  skill:autoresearch-create    [u:git:github.com/davebcn87/pi-autoresearch] Set up and run an autonomous experiment loop for any optimizatio
  skill:autoresearch-finalize  [u:git:github.com/davebcn87/pi-autoresearch] Finalize an autoresearch session into clean, reviewable branches
```

and use Ctrl+C to interrupt the process.

## Application

The gap/ccsize example is to be added.
