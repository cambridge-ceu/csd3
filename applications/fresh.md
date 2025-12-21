---
sort: 26
---

# fresh

Web: <https://sinelaw.github.io/fresh/>

## Precompiled

### 1. Latest release

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

### 2. No plugins

The GitHub releases provide stable executables with no support for plugins,

```bash
wget -qO- https://github.com/sinelaw/fresh/releases/download/v0.1.44/fresh-editor-no-plugins-x86_64-unknown-linux-musl.tar.gz \
| tar -xz --strip-components=1 -f -
```

## Compiling from source

This is preferable though slightly more involved.

```bash
wget -qO- https://github.com/sinelaw/fresh/archive/refs/tags/v0.1.55.tar.gz | \
tar fvxz -
cd fresh-0.1.55
module load ceuadmin/rust/nightly
export PREFIX=$CEUADMIN/fresh/0.1.55r
mkdir -p "$PREFIX"
cargo install --path . --root "$PREFIX"
rsync -av plugins themes queries types config.example.json $PREFIX/
```

where several folders are copied.

## Usage notes

There are numerous features, such as opening files from a directory tree (as in ceuadmin/edit), Ctrl-P to bring up the command panel, setting terminal display themes and key binding styles.
