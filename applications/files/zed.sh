#!/usr/bin/env bash
set -euo pipefail

V=1.27.0
SRC="$HOME/rds/software/zed-$V"
PREFIX="$CEUADMIN/zed/$V"
GCCROOT="$CEUADMIN/gcc/12.5.0"
GCCLIB="$GCCROOT/lib64"
LLVM=/usr/local/Cluster-Apps/ceuadmin/clang/22.1.8
LOCAL_LIB="$HOME/hpc-work/lib"

module load ceuadmin/clang/22.1.8
module load ceuadmin/gcc/12.5.0
module load ceuadmin/rust
export CC="$(command -v clang)"
export CXX="$(command -v clang++)"
export LLD="$LLVM/bin/ld.lld"

# Use GCC 12.5 headers and C++ runtime with Clang.
export CXXFLAGS="${CXXFLAGS:+$CXXFLAGS }--gcc-toolchain=$GCCROOT -stdlib=libstdc++"
# Native library search paths.
export LIBRARY_PATH="$GCCLIB:$LOCAL_LIB${LIBRARY_PATH:+:$LIBRARY_PATH}"
export LD_LIBRARY_PATH="$GCCLIB:$LOCAL_LIB${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
# Ensure Rust's final linker can find GCC 12.5 libstdc++.
if [[ ! -d "$SRC/.git" ]]; then
    git clone --depth 1 --branch "v$V" \
        https://github.com/zed-industries/zed.git "$SRC"
fi
cd "$SRC"
# Ensure Rust's final linker can find GCC 12.5 libstdc++.
python3 - "$GCCLIB" <<'PY'
from pathlib import Path
import re
import sys

p = Path(".cargo/config.toml")
if not p.is_file():
    raise SystemExit(f"ERROR: Missing {p}")
s = p.read_text()
lib = sys.argv[1]

section = f'''[target.x86_64-unknown-linux-gnu]
rustflags = [
    "-C", "symbol-mangling-version=v0",
    "--cfg", "tokio_unstable",
    "-L", "native={lib}",
    "-C", "link-arg=-Wl,-rpath,{lib}",
]
'''

pattern = r"(?ms)^\[target\.x86_64-unknown-linux-gnu\]\s*\n.*?(?=^\[|\Z)"
s = re.sub(pattern, "", s).rstrip()
p.write_text(s + "\n\n" + section)
PY

unset RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
cargo metadata --no-deps --format-version 1 >/dev/null
export REMOTE_SERVER_TARGET=x86_64-unknown-linux-gnu
rustup target add "$REMOTE_SERVER_TARGET"
echo "Checking Clang GCC toolchain selection..."
"$CXX" --gcc-toolchain="$GCCROOT" -stdlib=libstdc++ \
    -std=c++20 -v -E -x c++ /dev/null 2>&1 |
    grep -E 'Selected GCC|include/c\+\+' || true
echo "Checking GCC 12.5 C++ runtime..."
"$CXX" --gcc-toolchain="$GCCROOT" -stdlib=libstdc++ \
    -L"$GCCLIB" -Wl,-t \
    -x c++ - -o /tmp/test-clang <<'EOF'
#include <iostream>
int main() {
    std::cout << "Clang + GCC 12 libstdc++ OK\n";
}
EOF
ldd /tmp/test-clang | grep -E 'stdc\+\+|gcc_s'
XKB_LIB=/usr/lib64/libxkbcommon-x11.so.0
if [[ ! -e "$XKB_LIB" ]]; then
    echo "ERROR: Missing $XKB_LIB" >&2
    exit 1
fi
mkdir -p "$LOCAL_LIB"
ln -sfn "$XKB_LIB" "$LOCAL_LIB/libxkbcommon-x11.so"
PATCH_FILE=crates/agent/src/tools/terminal_tool.rs
if grep -qF 'subpath.is_empty()' "$PATCH_FILE"; then
    sed -i 's/subpath\.is_empty()/subpath.as_os_str().is_empty()/' \
        "$PATCH_FILE"
elif ! grep -qF 'subpath.as_os_str().is_empty()' "$PATCH_FILE"; then
    echo "ERROR: Expected source expression not found in $PATCH_FILE" >&2
    exit 1
fi
echo "Building Zed $V ..."
script/install-linux
