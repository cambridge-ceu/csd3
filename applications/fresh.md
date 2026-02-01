---
sort: 26
---

# fresh

Web: <https://sinelaw.github.io/fresh/> ([release](https://github.com/sinelaw/fresh/releases))

## Pre-built binaries

The official syntax for download of the latest `fresh-editor` release is associated with `x86_64-unknown-linux-gnu.tar.xz`,

```bash
wget -qO- "$(
  curl -s https://api.github.com/repos/sinelaw/fresh/releases/latest \
  | grep '"browser_download_url"' \
  | grep 'x86_64-unknown-linux-gnu.tar.xz"' \
  | head -n1 \
  | cut -d '"' -f 4
)" | tar xJ --strip-components=1 -C . -f -
```

which requires higher version of GLIBC, so it is necesssary to get the static release

```bash
export version=0.1.98
wget -qO - https://github.com/sinelaw/fresh/releases/download/v${version}/fresh-editor-x86_64-unknown-linux-musl.tar.gz | \
tar xz --strip-components=1
```

Some earlier versions has `fresh-editor-no-plugins` prefix. In both cases, an apparent permission issue is reported (`module load 
ceuadmin/fresh;which fresh;` shows that fresh is not found) and fixed with `chmod -R a+r fresh/0.1.42`, so we get around with 
`--strip-components=1`.

## Compiling from source

This is preferable though slightly more involved.

```bash
export version=0.1.98
wget -qO- https://github.com/sinelaw/fresh/archive/refs/tags/v${version}.tar.gz | \
tar fvxz -
cd fresh-${version}
module load ceuadmin/rust/nightly
export PREFIX=$CEUADMIN/fresh/${version}
mkdir -p "$PREFIX"
cargo build --release
cp target/release/fresh ${PREFIX}
```

## Environmental variables

Until 0.1.77, the following chunks have been used.

```bash
# build from source
cargo install --path . --root "$PREFIX"
rsync -av plugins themes queries types config.example.json $PREFIX/
```

Module definitions are

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
