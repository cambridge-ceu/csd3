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
