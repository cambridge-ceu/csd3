---
sort: 95
---

# Zed

Web, <https://zed.dev/>\
GitHub, <https://github.com/zed-industries/zed>

## 1.27.0

The module is called as follows,

```bash
module load ceuadmin/zed/1.27.0
which zed
zed --version
ldd "$CEUADMIN/zed/1.27.0/libexec/zed-editor" | grep 'not found'
```

### app

```bash
#!/bin/bash
set -euo pipefail

module purge
module load ceuadmin/clang/22.1.8
module load ceuadmin/rust/nightly

V=1.27.0
GCC12=/usr/local/Cluster-Apps/ceuadmin/gcc/12.5.0
LLVM=/usr/local/Cluster-Apps/ceuadmin/clang/22.1.8
LOCAL_LIB="$HOME/hpc-work/lib"

export CC="$LLVM/bin/clang"
export CXX="$LLVM/bin/clang++"
export LLD="$LLVM/bin/ld.lld"

# GCC 12.5 C++ headers and runtime, with Clang as compiler
export CXXFLAGS="--gcc-toolchain=$GCC12"
export LD_LIBRARY_PATH="$GCC12/lib64:$LLVM/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

# XKB linker-name workaround
XKB_LIB=/usr/lib64/libxkbcommon-x11.so.0
if [[ ! -e "$XKB_LIB" ]]; then
    echo "ERROR: Missing $XKB_LIB" >&2
    exit 1
fi

mkdir -p "$LOCAL_LIB"
ln -sfn "$XKB_LIB" "$LOCAL_LIB/libxkbcommon-x11.so"

export LIBRARY_PATH="$LOCAL_LIB:$GCC12/lib64${LIBRARY_PATH:+:$LIBRARY_PATH}"
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUSTFLAGS="-C link-arg=-L$GCC12/lib64"
export REMOTE_SERVER_TARGET=x86_64-unknown-linux-gnu
rustup target add "$REMOTE_SERVER_TARGET"

# Verify GCC C++ runtime
ldd "$GCC12/lib64/libstdc++.so.6"

# Source checkout
cd ~/rds/software
if [[ ! -d "zed-$V/.git" ]]; then
    git clone --depth 1 --branch "v$V" \
        https://github.com/zed-industries/zed.git "zed-$V"
fi

cd "zed-$V"

# Compatibility adjustment for the Rust source
sed -i 's/subpath\.is_empty()/subpath.as_os_str().is_empty()/' \
    crates/agent/src/tools/terminal_tool.rs

# Build and package
script/bundle-linux --skip-sentry

# Install
DEST="$CEUADMIN/zed/$V"
mkdir -p "$DEST"/{bin,lib,libexec}
mkdir -p "$DEST/share/icons/hicolor/"{512,1024}x1024/apps
mkdir -p "$DEST/share/applications"

# Copy required shared libraries
ldd target/x86_64-unknown-linux-gnu/release/zed |
    awk '/=> \// {print $3} /^\// {print $1}' |
    grep -Ev '/(libc\.so|libgcc_s\.so|libm\.so|libpthread\.so|libdl\.so|libasound\.so|libglib-2\.0\.so|libgobject-2\.0\.so|libgio-2\.0\.so|libgmodule-2\.0\.so|libpcre\.so|libpcre2-8\.so|libmount\.so|libblkid\.so|libselinux\.so|libffi\.so|libresolv\.so|libz\.so|ld-linux[^/]*\.so)' |
    while read -r lib; do
        cp -L "$lib" "$DEST/lib/"
    done

# Use the GCC 12.5 C++ runtime
cp -L "$GCC12/lib64/libstdc++.so.6" "$DEST/lib/"

# Install executables
cp target/x86_64-unknown-linux-gnu/release/zed \
   "$DEST/libexec/zed-editor"
cp target/x86_64-unknown-linux-gnu/release/cli \
   "$DEST/bin/zed"

# Strip installed copies only
llvm-objcopy --strip-unneeded "$DEST/libexec/zed-editor"
llvm-objcopy --strip-debug --discard-all "$DEST/bin/zed"

# Icons
cp crates/zed/resources/app-icon.png \
   "$DEST/share/icons/hicolor/512x512/apps/zed.png"
cp crates/zed/resources/app-icon@2x.png \
   "$DEST/share/icons/hicolor/1024x1024/apps/zed.png"

# Desktop entry
export DO_STARTUP_NOTIFY=true
export APP_CLI=zed
export APP_ICON=zed
export APP_ARGS='%U'
export APP_NAME=Zed

envsubst < crates/zed/resources/zed.desktop.in \
    > "$DEST/share/applications/dev.zed.Zed.desktop"
chmod +x "$DEST/share/applications/dev.zed.Zed.desktop"

# Licences
cp assets/licenses.md "$DEST/licenses.md"

# Verify
ldd "$DEST/libexec/zed-editor"
ldd "$DEST/bin/zed"
"$DEST/bin/zed" --version
``` 

### zed execitable

The following script largely works with minor changes.

```bash
V=1.27.0
SRC="$HOME/rds/software/zed-$V"
CEUADMIN=/usr/local/Cluster-Apps/ceuadmin
PREFIX="$CEUADMIN/zed/$V"
GCCROOT="$CEUADMIN/gcc/12.5.0"
GCCLIB="$GCCROOT/lib64"
LOCAL_LIB="$HOME/.local/lib"

module load ceuadmin/clang/22.1.8
module load ceuadmin/gcc/12.5.0
module load ceuadmin/rust

export CC="$(command -v clang)"
export CXX="$(command -v clang++)"
export CXXFLAGS="${CXXFLAGS:+$CXXFLAGS }--gcc-toolchain=$GCCROOT -stdlib=libstdc++"
export LIBRARY_PATH="$GCCLIB:$LOCAL_LIB${LIBRARY_PATH:+:$LIBRARY_PATH}"
export LD_LIBRARY_PATH="$GCCLIB:$LOCAL_LIB${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

mkdir -p "$HOME/rds/software"
if [[ ! -d "$SRC/.git" ]]; then
    git clone --depth 1 --branch "v$V" \
        https://github.com/zed-industries/zed.git "$SRC"
fi
cd "$SRC"
git describe --tags
git rev-parse --short HEAD

export REMOTE_SERVER_TARGET=x86_64-unknown-linux-gnu
rustup target add "$REMOTE_SERVER_TARGET"
"$CXX" --gcc-toolchain="$GCCROOT" -stdlib=libstdc++ \
    -std=c++20 -v -E -x c++ /dev/null 2>&1 |
    grep -E 'Selected GCC|include/c\+\+' || true
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
BINARY=target/release/zed

if [[ ! -f "$BINARY" ]]; then
    echo "ERROR: Zed executable not found: $BINARY" >&2
    exit 1
fi
strip --strip-debug "$BINARY"
echo "Final executable:"
ls -lh "$BINARY"
echo "Maximum GLIBC requirement:"
readelf --version-info "$BINARY" |
    grep -o 'GLIBC_[0-9.]*' |
    sort -Vu |
    tail -1
mkdir -p "$PREFIX/bin"
install -m 755 "$BINARY" "$PREFIX/bin/zed"
echo "Zed $V installed:"
ls -lh "$PREFIX/bin/zed"
```

## flatpak:

```bash
#!/bin/bash
# Custom Flatpak Zed installer for CentOS 8 / RHEL 8 without root

# 1️⃣ Set custom install directory
export FLATPAK_USER_DIR="$CEUADMIN/zed/0.215.3"
export FLATPAK_USER_DIR="/rds/project/rds-4o5vpvAowP0/software/zed/0.215.3"
mkdir -p "$FLATPAK_USER_DIR"
export XDG_DATA_HOME="$FLATPAK_USER_DIR"

# 2️⃣ Add Flathub remote if missing
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# 3️⃣ Install Zed
flatpak install --user -y flathub dev.zed.Zed

# 4️⃣ Run Zed to verify
flatpak run --user dev.zed.Zed

# 5️⃣ Optional: create a desktop launcher
mkdir -p "$HOME/.local/share/applications"
cat > "$HOME/.local/share/applications/zed.desktop" <<EOL
[Desktop Entry]
Name=Zed Editor
Exec=flatpak run --user dev.zed.Zed
Terminal=false
Type=Application
Icon=zed
Categories=Development;IDE;
EOL

echo "✅ Zed installed in $FLATPAK_USER_DIR and desktop launcher created."
```
