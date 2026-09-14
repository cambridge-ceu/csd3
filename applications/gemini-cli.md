---
sort: 37
---

# gemini-cli

Web: <https://geminicli.com/> ([GitHub](https://github.com/google-gemini/gemini-cli))

## 0.59.0

```bash
module load ceuadmin/node/24.15.0
npm i -g @google/gemini-cli@0.59.0 --prefix=$CEUADMIN/gemini-cli/0.59.0
$CEUADMIN/gemini-cli/0.59.0/bin/gemini --version
```

and again

```bash
export GEMINI_API_KEY=$(cat $HOME/doc/gemini-cli)
module load ceuadmin/gemini-cli/0.59.0
gemini "why the sky is blue; make a simple poem in Chinese"
```

to get

```

 ▝▜▄     Gemini CLI v0.59.0
   ▝▜▄
  ▗▟▀    Authenticated with gemini-api-key /auth
 ▝▀


ℹ Positional arguments now default to interactive mode. To run in non-interactive mode, use the --prompt (-p) flag.

 > why the sky is blue; make a simple poem in Chinese

✦ Why the Sky is Blue
  The sky is blue because of a phenomenon called Rayleigh scattering. Sunlight contains all the colors of the rainbow, but when it passes
  through the Earth's atmosphere, the gases and particles scatter the light in all directions. Since blue light travels in shorter, smaller
  waves than other colors, it is scattered much more than the other colors, making the sky appear blue to our eyes.

  ---

  Chinese Poem (关于蓝天的诗)

  《晴空》

  抬头望晴空，
  万里湛蓝同。
  白云如白浪，
  悠悠入画中。

  (Translation: Looking up at the clear sky, ten thousand miles of deep blue. White clouds are like white waves, leisurely drifting into the
  painting.)

 > /quit

╭────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│                                                                                                                                            │
│  Agent powering down. Goodbye!                                                                                                             │
│                                                                                                                                            │
│  Interaction Summary                                                                                                                       │
│  Session ID:                 03df147d-eb90-4b36-bc33-c0a315974297                                                                          │
│  Tool Calls:                 0 ( ✓ 0 x 0 )                                                                                                 │
│  Success Rate:               0.0%                                                                                                          │
│                                                                                                                                            │
│  Performance                                                                                                                               │
│  Wall Time:                  58.2s                                                                                                         │
│  Agent Active:               12.0s                                                                                                         │
│    » API Time:               12.0s (100.0%)                                                                                                │
│    » Tool Time:              0s (0.0%)                                                                                                     │
│                                                                                                                                            │
│                                                                                                                                            │
│  Model Usage                                                                                                                               │
│  Use /model to view model quota information                                                                                                │
│                                                                                                                                            │
│  Model                           Reqs  Input Tokens   Cache Reads Output Tokens                                                            │
│  ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────  │
│  gemini-3.1-flash-lite              2         2,682             0            43                                                            │
│    ↳ utility_router                 1         2,413             0            39                                                            │
│    ↳ utility_summarizer             1           269             0             4                                                            │
│  gemini-3.5-flash                   1        12,157             0           161                                                            │
│    ↳ main                           1        12,157             0           161                                                            │
│  To resume this session: gemini --resume 03df147d-eb90-4b36-bc33-c0a315974297                                                              │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

```

> ✦ Between version 0.34.0 and the current version 0.59.0, Gemini CLI has transitioned from a straightforward helper CLI into an advanced,
>   context-aware, and sandboxed autonomous agent platform.

>   Here are the key enhancements, structured by area:

>   1. New Autonomous & Intelligence Features
>    * Auto Memory & Background Skill Extraction (experimental.autoMemory): Periodically analyzes idle local session history to extract
>      recurring workflows, team conventions, and user preferences. It proposes updates (patches and .md files) in an interactive inbox via the
>      new /memory inbox command.
>    * Real-Time Voice Mode (experimental.voiceMode): Enables hands-free interactions with voice dictation, featuring dual backends: a
>      cloud-based gemini-live option and a local offline option powered by whisper.
>    * Agent-to-Agent (A2A) Protocols: Deeply integrates with caretaker automated runners (such as PR automation, caretaker issue triage, and
>      evals reporting against issue suites).
>    * Unified Auto Mode: Streamlined all automated running styles into a cohesive, single autonomous mode.

>   2. Sandbox, Safety & Redaction Upgrades
>    * Context-Aware Security Checker (Conseca): On-the-fly prompt inspection that dynamically crafts and enforces strict security policies for
>      tools before execution.
>    * Tool-Level Sandboxing: Granular isolation on a per-tool level (using OS-native mechanisms like Linux Bubblewrap/seccomp and macOS
>      Seatbelt profiles) instead of process-wide sandboxing.
>    * Credential Redaction & Approval Policies: Automated best-effort redaction of API keys, passwords, and tokens during tool runtimes,
>      alongside the ability to set persistent, context-aware "Always Allow" tool approvals.

>   3. Core Tooling & UX Enhancements
>   * Surgical Editing: Optimization of model behaviors to strictly prefer targeted, partial edits (via tools like replace) over complete file
>     rewrites, resulting in faster execution and significantly lower token usage.
>   * Chapters Narrative Flow: Grouped agent executions and actions into thematic "Chapters" that represent distinct logical phases (Research,
>     Strategy, Execution, Validation), enhancing flow readability.
>   * Flicker-Free Terminal Buffer & Mouse Support: Introduced a custom rendering layer to resolve flicker, alongside mouse-click focus and
>     custom/extended Kitty keyboard protocols.
>   * Advanced Vim Mode: Expanded modal bindings to fully support missing motions (like X, ~, r, f/F/t/T) and unnamed register actions.

>  4. CLI Arguments & Configuration
>   * Unified Approval: New --approval-mode <mode> command-line flag (default, auto_edit, yolo, plan).
>   * Multi-Directory Ingestion: Allows specifying up to 5 custom directories using --include-directories.
>   * Headless Streaming: Support for --output-format stream-json to emit structured JSONL events programmatically.
>   * Schema Restructuring: Standardized settings in settings.json into clean categories like ui, billing, model, tools, mcp, security, and
>     experimental.

## 0.34.0

This showcases a more formal setup analogous to the OpenClaw module, say,

```bash
module load ceuadmin/node/22.16.0
npm install -g gemini-cli@0.34.0 --prefix $CEUADMIN/gemini-cli/0.34.0
```

so that

```bash
export GEMINI_API_KEY=$(cat $HOME/doc/gemini-cli)
module load ceuadmin/gemini-cli/0.34.0
gemini "why the sky is blue; make a simple poem in Chinese"
```

gives

```
▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
✦ The sky is blue due to Rayleigh scattering. As sunlight enters Earth's atmosphere, it collides with gas molecules and scatters in all
  directions. Blue light travels in shorter, smaller waves and is scattered more strongly than other colors, making the sky appear blue to our
  eyes.

  Here is a simple poem in Chinese about the blue sky:

  蓝天 (Lántiān) — Blue Sky

  晴空万里深， (Qíngkōng wànlǐ shēn,)
  碧色照人心。 (Bìsè zhào rénxīn.)
  悠悠白云过， (Yōuyōu báiyún guò,)
  此景最怡神。 (Cǐ jǐng zuì yíshén.)

  Translation:
  The clear sky stretches for ten thousand miles, deep and vast,
  Its emerald-blue color shines upon the heart.
  Leisurely, the white clouds pass by,
  This view is the most refreshing of all.
```

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

Optionally, it can be made available separately with --prefix specified.

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

## gcloud

The session above may fail with message

```
[API Error: You have exhausted your daily quota on this model.]
```

We turn to gcloud; in this case the authentication is enabled via Firefox:

```bash
module load ceuadmin/firefox
firefox &
gcloud auth login
gcloud config set project PROJECT_ID
gcloud auth print-access-token
module load ceuadmin/node/22.16.0
gemini
```

with prompt, `why the sky is blue`

```

> why the sky is blue

✦ The sky appears blue due to a phenomenon called Rayleigh scattering.

  Here is a simple explanation of how it works:

   1. Sunlight is White: Light from the sun looks white, but it is actually made up of all the colors of the rainbow.
   2. The Atmosphere acts as a Prism: As sunlight reaches Earth, it collides with gas molecules and particles in the air.
   3. Blue Scatters More: Colors with shorter wavelengths (like blue and violet) are scattered much more strongly by these molecules than
      colors with longer wavelengths (like red and yellow).
   4. We See the Blue: Because blue light is scattered in all directions, it reaches our eyes from every part of the sky, making it look blue.

  Note: While violet light is scattered even more than blue, our eyes are more sensitive to blue light, and the sun emits less violet light to
  begin with, which is why the sky appears blue rather than violet.

> write a short peom about this

✦ The sun spills white, a prism’s gold,
  A rainbow tale yet to be told.
  Through air and gas the colors race,
  To find their path through empty space.

  But blue is swift and blue is short,
  Of every beam, the scattered sort.
  It bounces wide, it fills the height,
  And paints the day in azure light.

> a short peom in Chinese?

  七色祥光下九霄，
  微尘作弄舞风标。
  长波过隙无踪影，
  独留蔚蓝画碧涛。

  (Translation)
  Seven colors of light descend from the highest heavens,
  Dancing with the particles in the wind.
  Long waves (reds/yellows) pass through without a trace,
  Only the blue remains to paint the azure waves.

```
