---
sort: 82
---

# Rust

Web: <https://www.rust-lang.org/>

## 1.98.1

```bash
#!/usr/bin/env bash
#
# Set up ceuadmin/rust/1.98.1
#
set -euo pipefail

VERSION=1.98.1
ROOT="${CEUADMIN:-/usr/local/Cluster-Apps/ceuadmin}/rust/${VERSION}"
HOST=x86_64-unknown-linux-gnu
TMPDIR_RUST=$(mktemp -d)
trap 'rm -rf "$TMPDIR_RUST"' EXIT
echo "Installing Rust ${VERSION}"
echo "Installation: ${ROOT}"
mkdir -p "$ROOT"
cd "$TMPDIR_RUST"
curl -fL https://static.rust-lang.org/rustup/dist/${HOST}/rustup-init -o rustup-init
chmod +x rustup-init
export RUSTUP_HOME="$ROOT/rustup"
export CARGO_HOME="$ROOT"
./rustup-init \
  -y \
  --no-modify-path \
  --profile minimal \
  --default-host "$HOST" \
  --default-toolchain "$VERSION"
export PATH="$ROOT/bin:$PATH"
echo
echo "=== Rust installation ==="
rustc --version
cargo --version
rustup show
echo
echo "=== Runtime dependencies ==="
ldd "$ROOT/bin/rustc" | grep 'not found' && exit 1 || true
ldd "$ROOT/bin/cargo" | grep 'not found' && exit 1 || true
echo
echo "Rust ${VERSION} installed successfully under ${ROOT}"
```

## 1.95.0

```bash
module load ceuadmin/rust
rustc --version
cargo --version
```
giving,
```
rustc 1.95.0 (59807616e 2026-04-14)
cargo 1.95.0 (f2d3ce0bd 2026-03-21)
```

This is upgraded from 1.74.1 with `rustup default stable` at suggestion of gmake when compiling firefox/nightly.
To avoid duplication, a symbolic link is generated on `/usr/local/Cluster-Apps/ceuadmin/rust/1.74.1/cargo` as `${HOME}/.cargo`.
Naturally, both cargo and rustc use the directory above.

The following steps are sketched for `ceuadmin/nightly`,

```bash
export CARGO_HOME="$CEUADMIN/rust/nightly/cargo"
export RUSTUP_HOME="$CEUADMIN/rust/nightly/rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
export PATH="$CARGO_HOME/bin:$PATH"
rustup toolchain install nightly
rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu
rustup default nightly
rustc --version
```

As noted in [rust.md](files/rust.md) on 22/5/2025, we have `rustc 1.89.0-nightly (bf64d66bd 2025-05-21)`.

To compile Firefox/nightly (145.0a1), cbindgen is required which can be installed with `cargo install cbindgen --root $CEUADMIN/rust/nightly/cargo`.

## 1.74.1

```bash
export CARGO_HOME=$CEUADMIN/rust/1.74.1/cargo
export RUSTUP_HOME=$CEUADMIN/rust/1.74.1/rustup

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

rustup default stable
```

Note `.profile` and `.bash_profile` contain call to `$CEUADMIN/rust/1.74.1/cargo/env` which is unnecessary.

## Real applications

See [fresh](fresh.md).
