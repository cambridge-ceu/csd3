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

Two scripts are available to generate `target/release/zed-linux-x86_64.tar.gz` as an archive of zed.app/.

### script/bundle-linux

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

Three changes are necessary to `script/bundle-linux`.

```bash
# change: find_libs():
find_libs() {
    ldd "${target_dir}/${target_triple}/release/zed" |
        awk '
            $2 == "=>" && $3 ~ /^\// {print $3}
            $1 ~ /^\// {print $1}
        ' |
        grep -v '\<\(libc.so\|libgcc_s.so\|libm.so\|libpthread.so\|libdl.so\|libasound.so\)' |
        grep -v '\<\(libglib-2.0.so\|libgobject-2.0.so\|libgio-2.0.so\|libgmodule-2.0.so\|libpcre.so\|libpcre2-8.so\|libmount.so\|libblkid.so\|libselinux.so\|libffi.so\|libresolv.so\|libz.so\)'
}
# change: cp $(find_libs) "${zed_dir}/lib"
mapfile -t libs < <(find_libs)
if ((${#libs[@]})); then
    cp -L -- "${libs[@]}" "${zed_dir}/lib/"
fi
# change: envsubst
/usr/bin/envsubst
```

### script/install-linux

The script is [zed.sh](files/zed.sh)

{% highlight bash %}
{% include_relative files/zed.sh %}
{% endhighlight %}

It includes the following patch to .cargo/config.toml (as shown in [config.toml](files/config.toml)),

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
