---
sort: 58
---

# Pi

Web, <https://pi.dev/>

## 0.65.2

```bash
module load ceuadmin/node/22.16.0
export version="0.65.2"
export BASE="$CEUADMIN/Pi/${version}"
export PATH="$BASE/bin:$PATH"
npm install -g @mariozechner/pi-coding-agent@${version} --prefix "$BASE"
export PATH="$BASE/bin:$PATH"
ln -fs "$BASE" ~/.pi
npm install -g pi-subagents @ollama/pi-web-search --prefix "$BASE"
pi install "$BASE/lib/node_modules/pi-subagents"
pi install "$BASE/lib/node_modules/@ollama/pi-web-search"
pi install https://github.com/davebcn87/pi-autoresearch
pi list
```

and now we have

```
User packages:
  ../../../../usr/local/Cluster-Apps/ceuadmin/Pi/0.65.2/lib/node_modules/pi-subagents
    /usr/local/Cluster-Apps/ceuadmin/Pi/0.65.2/lib/node_modules/pi-subagents
  ../../../../usr/local/Cluster-Apps/ceuadmin/Pi/0.65.2/lib/node_modules/@ollama/pi-web-search
    /usr/local/Cluster-Apps/ceuadmin/Pi/0.65.2/lib/node_modules/@ollama/pi-web-search
  https://github.com/davebcn87/pi-autoresearch
    /home/jhz22/.pi/agent/git/github.com/davebcn87/pi-autoresearch
```

Note that ~/.pi is but a symbolic link though we can also get a simpler pi-autoresearch location similarly to pi-subagents, etc., e.g.,

```bash
git clone https://github.com/davebcn87/pi-autoresearch $BASE/agent/pi-autoresearch
pi install "$BASE/agent/pi-autoresearch"
```

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

## Application

We couple with Ollama,

```bash
module load ceuadmin/ollama
ollama serve > /dev/null 2>&1 &
until ollama list; do
  sleep 1
done
ollama list
module load ceuadmin/Pi/0.65.2
ollama launch pi --model kimi-k2.5:cloud
```
The pi-autoresearch module enables /autoresearch.

```
→ autoresearch                 [u:git:github.com/davebcn87/pi-autoresearch] Start, stop, clear, or resume autoresearch mode
  skill:autoresearch-create    [u:git:github.com/davebcn87/pi-autoresearch] Set up and run an autonomous experiment loop for any optimizatio
  skill:autoresearch-finalize  [u:git:github.com/davebcn87/pi-autoresearch] Finalize an autoresearch session into clean, reviewable branches
```

and use /quit to quit the session (Ctrl+C to interrupt the process).

The gap/ccsize example is to be added.
