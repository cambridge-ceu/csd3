---
sort: 46
---

# Rust

## module

```bash
module load ceuadmin/rust
rustc --version
```

which gives `rustc 1.74.1 (a28077b28 2023-12-04)`.

## Installation

```bash
export CARGO_HOME=$CEUADMIN/rust/1.74.1/cargo
export RUSTUP_HOME=$CEUADMIN/rust/1.74.1/rustup

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

rustup default stable
```
