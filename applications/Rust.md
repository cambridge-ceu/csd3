---
sort: 80
---

# Rust

Web: <https://www.rust-lang.org/>

## module

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

## Installation

```bash
export CARGO_HOME=$CEUADMIN/rust/1.74.1/cargo
export RUSTUP_HOME=$CEUADMIN/rust/1.74.1/rustup

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

rustup default stable
```

Note `.profile` and `.bash_profile` contain call to `$CEUADMIN/rust/1.74.1/cargo/env` which is unnecessary.

## Real applications

See [fresh](fresh.md).
