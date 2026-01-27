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

The official syntax for download of the latest release comes with plugins/ but requires higher version of GLIBC; so we turn to an explicit no-plugin download (below).

### 2. Stable release

The GitHub releases provide stable executables with support for plugins,

```bash
export version=0.1.90
wget -qO - https://github.com/sinelaw/fresh/releases/download/v0.1.90/fresh-editor-x86_64-unknown-linux-musl.tar.gz | \
tar xz --strip-components=1
# earlier versions with no plugins
# wget -qO- https://github.com/sinelaw/fresh/releases/download/v${version}/fresh-editor-no-plugins-x86_64-unknown-linux-musl.tar.gz \
# | tar -xz --strip-components=1 -f -
```

In both cases, an apparent permission issue is reported (`module load ceuadmin/fresh;which fresh;` shows that fresh is not found) and fixed with `chmod -R a+r fresh/0.1.42`, so we get around with `--strip-components=1`.

## Compiling from source

This is preferable though slightly more involved.

```bash
export version=0.1.90
wget -qO- https://github.com/sinelaw/fresh/archive/refs/tags/v${version}.tar.gz | \
tar fvxz -
cd fresh-${version}
module load ceuadmin/rust/nightly
export PREFIX=$CEUADMIN/fresh/${version}
mkdir -p "$PREFIX"
cargo build --release
cp target/release/fresh ${PREFIX}
# functional until 0.1.77
# cargo install --path . --root "$PREFIX"
# rsync -av plugins themes queries types config.example.json $PREFIX/
```

## Module file

The following chunk has been used until 0.1.77.

```
setenv FRESH_HOME $root
setenv FRESH_PLUGINS_DIR $root/plugins
setenv FRESH_THEMES_DIR  $root/themes
setenv FRESH_QUERIES_DIR $root/queries
setenv FRESH_TYPES_DIR   $root/types
setenv FRESH_CONFIG $root/config.example.json
```

## Usage notes

There are numerous features, such as mouse cursor to set position, Ctrl-E to open files from a directory tree (as in ceuadmin/edit), Ctrl-P to bring up the command panel, setting terminal display themes and key binding styles.
