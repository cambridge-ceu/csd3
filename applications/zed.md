---
sort: 95
---

Web, <https://zed.dev/>\
GitHub, <https://github.com/zed-industries/zed>

# Zed

## 1.27.0

The module is called as follows,

```bash
module load ceuadmin/zed/1.27.0
which zed
zed --version
ldd "$CEUADMIN/zed/1.27.0/libexec/zed-editor" | grep 'not found'
```

The following script builds the app.

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
```

The installation script below is manual simply to avoid modification of `script/bundle-linux`.

```bash
DEST="$CEUADMIN/zed/$V"
mkdir -p "$DEST"/{bin,lib,libexec}
mkdir -p "$DEST/share/icons/hicolor/"{512,1024}x1024/apps
mkdir -p "$DEST/share/applications"
ldd target/x86_64-unknown-linux-gnu/release/zed |
    awk '/=> \// {print $3} /^\// {print $1}' |
    grep -Ev '/(libc\.so|libgcc_s\.so|libm\.so|libpthread\.so|libdl\.so|libasound\.so|libglib-2\.0\.so|libgobject-2\.0\.so|libgio-2\.0\.so|libgmodule-2\.0\.so|libpcre\.so|libpcre2-8\.so|libmount\.so|libblkid\.so|libselinux\.so|libffi\.so|libresolv\.so|libz\.so|ld-linux[^/]*\.so)' |
    while read -r lib; do
        cp -L "$lib" "$DEST/lib/"
    done
cp -L "$GCC12/lib64/libstdc++.so.6" "$DEST/lib/"
cp target/x86_64-unknown-linux-gnu/release/zed \
   "$DEST/libexec/zed-editor"
cp target/x86_64-unknown-linux-gnu/release/cli \
   "$DEST/bin/zed"
llvm-objcopy --strip-unneeded "$DEST/libexec/zed-editor"
llvm-objcopy --strip-debug --discard-all "$DEST/bin/zed"
cp crates/zed/resources/app-icon.png \
   "$DEST/share/icons/hicolor/512x512/apps/zed.png"
cp crates/zed/resources/app-icon@2x.png \
   "$DEST/share/icons/hicolor/1024x1024/apps/zed.png"
export DO_STARTUP_NOTIFY=true
export APP_CLI=zed
export APP_ICON=zed
export APP_ARGS='%U'
export APP_NAME=Zed
envsubst < crates/zed/resources/zed.desktop.in \
    > "$DEST/share/applications/dev.zed.Zed.desktop"
chmod +x "$DEST/share/applications/dev.zed.Zed.desktop"
cp assets/licenses.md "$DEST/licenses.md"
ldd "$DEST/libexec/zed-editor"
ldd "$DEST/bin/zed"
"$DEST/bin/zed" --version
``` 

### Installation scripts and configuration

One can also use `script/install-linux`, as is [zed.sh](files/zed.sh) which generates `target/release/zed-linux-x86_64.tar.gz`.

```toml
[target.'cfg(all())']
# v0 mangling scheme provides more detailed backtraces around closures
rustflags = [
    "-C", "symbol-mangling-version=v0",
    "--cfg", "tokio_unstable",

    # HPC: GCC 12.5 C++ runtime
    "-L", "native=/usr/local/Cluster-Apps/ceuadmin/gcc/12.5.0/lib64",
    "-C", "link-arg=-Wl,-rpath,/usr/local/Cluster-Apps/ceuadmin/gcc/12.5.0/lib64",
]
```

{% highlight bash %}
{% include_relative files/zed.sh %}
{% endhighlight %}

It includes the following patch to .cargo/config.toml (as shown in [config.toml](files/config.toml)),

{% highlight toml %}
{% include_relative files/config.toml %}
{% endhighlight %}

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
