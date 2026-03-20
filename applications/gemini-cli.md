---
sort: 33
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

✦ 七色祥光下九霄，
  微尘作弄舞风标。
  长波过隙无踪影，
  独留蔚蓝画碧涛。

  (Translation)
  Seven colors of light descend from the highest heavens,
  Dancing with the particles in the wind.
  Long waves (reds/yellows) pass through without a trace,
  Only the blue remains to paint the azure waves.

```

## 0.34.0

This showcases a more formal setup analogous to the OpenClaw module, say,

```bash
module load ceuadmin/node/22.16.0
npm install -g gemini-cli@0.34.0 --prefix $CEUADMIN/gemini-cli/0.34.0
```
