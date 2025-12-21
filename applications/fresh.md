---
sort: 26
---

# fresh

Web: <https://sinelaw.github.io/fresh/> ([release](https://github.com/sinelaw/fresh/releases))

## Pre-built binaries

### 1. The latest release

```bash
wget -qO- "$(
  curl -s https://api.github.com/repos/sinelaw/fresh/releases/latest \
  | grep '"browser_download_url"' \
  | grep 'x86_64-unknown-linux-gnu.tar.xz"' \
  | head -n1 \
  | cut -d '"' -f 4
)" | tar xJ --strip-components=1 -C . -f -
```

The official syntax for download of the latest release comes with plugins/ but requires higher version of GLIBC; so we turn to an explicit no-plugin download (below), for which an apparent permission issue is reported (`module load ceuadmin/fresh;which fresh;` shows that fresh is not found) and fixed with `chmod -R a+r fresh/0.1.42`, so we get around via `--strip-components=1`.

### 2. Release with no plugins

The GitHub releases provide stable executables with no support for plugins,

```bash
wget -qO- https://github.com/sinelaw/fresh/releases/download/v0.1.44/fresh-editor-no-plugins-x86_64-unknown-linux-musl.tar.gz \
| tar -xz --strip-components=1 -f -
```

## Compiling from source

This is preferable though slightly more involved.

```bash
export version=0.1.58
wget -qO- https://github.com/sinelaw/fresh/archive/refs/tags/v${version}.tar.gz | \
tar fvxz -
cd fresh-${version}
module load ceuadmin/rust/nightly
export PREFIX=$CEUADMIN/fresh/${version}
mkdir -p "$PREFIX"
cargo install --path . --root "$PREFIX"
rsync -av plugins themes queries types config.example.json $PREFIX/
```

where several folders are copied.

## Module file

```
#%Module -*- tcl -*-
##
## fresh 0.1.58
##
proc ModulesHelp { } {

  puts stderr "\tfresh: The Terminal Text Editor\n"
  puts stderr "\tInstalled under: /usr/local/Cluster-Apps/ceuadmin/fresh/0.1.58"
  puts stderr "\tHomepage: https://sinelaw.github.io/fresh/"
}

module-whatis "The Terminal Text Editor."

conflict fresh
set root /usr/local/Cluster-Apps/ceuadmin/fresh/0.1.58
prepend-path PATH $root/bin
setenv FRESH_HOME $root
setenv FRESH_PLUGINS_DIR $root/plugins
setenv FRESH_THEMES_DIR  $root/themes
setenv FRESH_QUERIES_DIR $root/queries
setenv FRESH_TYPES_DIR   $root/types
setenv FRESH_CONFIG $root/config.example.json
```

It is handy to use `sed 's/0.1.57/0.1.58/' 0.1.57 > 0.1.58`, say.

## Usage notes

There are numerous features, such as opening files from a directory tree (as in ceuadmin/edit), Ctrl-P to bring up the command panel, setting terminal display themes and key binding styles.
