---
sort: 61
---

# Pi

Web, <https://pi.dev/>

## 0.67.68

```bash
module load ceuadmin/node/22.16.0
npm view @mariozechner/pi-coding-agent version
export version="0.67.68"
export BASE="$CEUADMIN/Pi/${version}"
npm install -g @mariozechner/pi-coding-agent@${version} --prefix "$BASE"
npm install -g pi-subagents @ollama/pi-web-search --prefix "$BASE"
export PATH="$BASE/bin:$PATH"
ln -fs "$BASE" ~/.pi
pi install "$BASE/lib/node_modules/pi-subagents"
pi install "$BASE/lib/node_modules/@ollama/pi-web-search"
pi install https://github.com/davebcn87/pi-autoresearch
pi list
```

which gives,

```
User packages:
  https://github.com/davebcn87/pi-autoresearch
    /home/jhz22/.pi/agent/git/github.com/davebcn87/pi-autoresearch
  ../../../../usr/local/Cluster-Apps/ceuadmin/Pi/0.67.68/lib/node_modules/pi-subagents
    /usr/local/Cluster-Apps/ceuadmin/Pi/0.67.68/lib/node_modules/pi-subagents
  ../../../../usr/local/Cluster-Apps/ceuadmin/Pi/0.67.68/lib/node_modules/@ollama/pi-web-search
    /usr/local/Cluster-Apps/ceuadmin/Pi/0.67.68/lib/node_modules/@ollama/pi-web-search
```

## 0.65.2

```bash
module load ceuadmin/node/22.16.0
npm view @mariozechner/pi-coding-agent version
export version="0.65.2"
export BASE="$CEUADMIN/Pi/${version}"
npm install -g @mariozechner/pi-coding-agent@${version} --prefix "$BASE"
npm install -g pi-subagents @ollama/pi-web-search --prefix "$BASE"
export PATH="$BASE/bin:$PATH"
ln -fs "$BASE" ~/.pi
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
ollama launch pi --yes --model kimi-k2.5:cloud -- @context.md \
| tr '\r' '\n' \
| perl -pe 's/\e\[[0-9;?]*[ -\/]*[@-~]//g; s/\e\].*?(\a|\e\\)//g' \
> kimi2.5.txt
pi -p --mode text \
  --provider ollama --model kimi-k2.5:cloud \
  --system-prompt "Return only the final answer. No questions, no options, no explanations." \
  @context.md > kim2.5.txt
pi run --provider ollama --model gemma4:e2B @context.md
```
The pi-autoresearch module enables /autoresearch.

```
→ autoresearch                 [u:git:github.com/davebcn87/pi-autoresearch] Start, stop, clear, or resume autoresearch mode
  skill:autoresearch-create    [u:git:github.com/davebcn87/pi-autoresearch] Set up and run an autonomous experiment loop for any optimizatio
  skill:autoresearch-finalize  [u:git:github.com/davebcn87/pi-autoresearch] Finalize an autoresearch session into clean, reviewable branches
```

and use /quit to quit the interactive session (Ctrl+C twice to exit), and we also showcase the use of a context file.

## ccsize

The gap/ccsize example is now added from use of context.md above.

```
fd not found. Downloading...
ripgrep not found. Downloading...
fd installed to /home/jhz22/.pi/agent/bin/fd
ripgrep installed to /home/jhz22/.pi/agent/bin/rg

 pi v0.65.2
 escape to interrupt
 ctrl+c to clear
 ctrl+c twice to exit
 ctrl+d to exit (empty)
 ctrl+z to suspend
 ctrl+k to delete to end
 shift+tab to cycle thinking level
 ctrl+p/shift+ctrl+p to cycle models
 ctrl+l to select model
 ctrl+o to expand tools
 ctrl+t to expand thinking
 ctrl+g for external editor
 / for commands
 ! to run bash
 !! to run bash (no context)
 alt+enter to queue follow-up
 alt+up to edit all queued messages
 ctrl+v to paste image
 drop files to attach

 Pi can explain its own features and look up its docs. Ask it how to use or extend Pi.


[Context]
  /rds/user/jhz22/hpc-work/tests/gap/ccsize/CLAUDE.md

[Skills]
  user
    ~/.pi/agent/git/github.com/davebcn87/pi-autoresearch/skills/autoresearch-create/SKILL.md
    ~/.pi/agent/git/github.com/davebcn87/pi-autoresearch/skills/autoresearch-finalize/SKILL.md

[Extensions]
  user
    ~/.pi/agent/git/github.com/davebcn87/pi-autoresearch/extensions/pi-autoresearch/index.ts
    /usr/local/Cluster-Apps/ceuadmin/Pi/0.65.2/lib/node_modules/@ollama/pi-web-search/index.ts
    /usr/local/Cluster-Apps/ceuadmin/Pi/0.65.2/lib/node_modules/pi-subagents/index.ts
    /usr/local/Cluster-Apps/ceuadmin/Pi/0.65.2/lib/node_modules/pi-subagents/notify.ts



 <file name="/rds/user/jhz22/hpc-work/tests/gap/ccsize/context.md">
 # context.md
 This file provides guidance working with code in this repository.

 Project Overview

 R implementations for power and sample size calculations in case-cohort studies:
 - ccsize() — Cai & Zeng (2004) for rare events (pD < 0.05)
 - ccsize07() — Cai & Zeng (2007) for non-rare events (pD ≥ 0.05)

 Goal is numerical correctness and reproducibility against published tables and
 possibility to have a unified code for all scenarios, e.g., ccsize() in R.

 Key Files

 ┌──────────────────────┬───────────────────────────────────────────────────────┐
 │ File                 │ Purpose                                               │
 ├──────────────────────┼───────────────────────────────────────────────────────┤
 │ ccsize04.md          │ Rare-event implementation (R roxygen + code)          │
 ├──────────────────────┼───────────────────────────────────────────────────────┤
 │ ccsize07.md          │ Non-rare implementation with methods "2004"/"A1"/"A2" │
 ├──────────────────────┼───────────────────────────────────────────────────────┤
 │ table1.md            │ Validation data for Cai & Zeng (2004)                 │
 ├──────────────────────┼───────────────────────────────────────────────────────┤
 │ table3.md            │ Validation data for Cai & Zeng (2007)                 │
 ├──────────────────────┼───────────────────────────────────────────────────────┤
 │ cai04.pdf, cai07.pdf │ Original papers for reference                         │
 └──────────────────────┴───────────────────────────────────────────────────────┘

 Working with .md R Files

 Source R code from markdown files (roxygen comments + R code):

 ```r
   source("ccsize04.md")
   source("ccsize07.md")
 ```

 Quick Test

 ```r
   source("ccsize04.md")
   source("ccsize07.md")

   # Rare event
   ccsize(n=10000, q=0.1, pD=0.01, p1=0.5, theta=log(1.2), alpha=0.05, beta=0.2)

   # Non-rare event
   ccsize07(n=1000, q=0.1, pD=0.2, p1=0.1, theta=log(1.25), alpha=0.05, method="A1")
 ```

 Method Selection

 - pD < 0.05: Use ccsize() or ccsize07(method="2004")
 - pD ≥ 0.05: Use ccsize07(method="A1") (default)
 - Never use "2004" for large pD unless explicitly requested

 R Implementation Rules

 - Use explicit numeric types; avoid implicit coercion
 - Avoid partial argument matching
 - Use log(hr) internally (not raw HR)
 - Prefer vectorized operations over loops
 - Preallocate outputs

 Numerical Stability

 - Prefer log-scale computations
 - Avoid subtracting nearly equal numbers
 - Validate domains: probabilities ∈ (0,1), log arguments > 0
 - Explicitly check is.nan, is.infinite, negative variance
 - Return NA with warning if invalid

 Input Validation (All Functions)

 Must enforce: n > 0, 0 < q < 1, 0 < pD < 1, 0 < p1 < 1, alpha ∈ (0,1), beta ∈ (0,1)

 Invalid input → stop() with clear message.

 Output Constraints

 - Sample size: positive and finite
 - If ssize ≤ 0 → return NA
 - Power: must be within [0,1]

 Debugging

 - Use message() (not print())
 - Provide optional verbose=TRUE
 - No debug output in final results

 Testing Protocol

 All changes must reproduce table1.md and table3.md values within relative error < 1%.

 Run edge-case tests: small/large pD, extreme HR, large n.

 Reference Example

 Expected: n=25000, pD=0.3, p1=0.2, hr=1.3 → sample size ≈ 5099

 Anti-Patterns

 - Do not return negative sample sizes
 - Do not silently coerce types
 - Do not ignore warnings
 - Do not hardcode unexplained constants

 </file>
 run
```
