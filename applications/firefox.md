---
sort: 25
---

# Firefox

Mercurial (hg): <https://hg.mozilla.org/mozilla-unified> ([releases](https://archive.mozilla.org/pub/firefox/releases/))\
GitHub: <https://github.com/mozilla-firefox/firefox>

/usr/bin/firefox (140.3.0esr, Extended Support Release) actually works by setting in .bashrc.

```bash
alias firefox='MOZ_DISABLE_CONTENT_SANDBOX=1 firefox > /dev/null 2>&1'
```

With its handling of sandbox, it looks better to use the nightly builds below.

## ceuadmin/firefox

<font color="red"><b>27/9/2025 Update</b></font>

Module **ceuadmin/143.0.1** is available and used as follows,

```bash
module load euadmin/firefox/143.0.1
firefox &
```

This is analogous to `/usr/bin/firefox` (140.3.0esr) described above yet more recent.

<font color="red"><b>23/9/2025 Update</b></font>

Module **ceuadmin/145.0a1** is available and used as follows,

```bash
module load euadmin/firefox/145.0a1
firefox &
```

This is actually the nightly version.

<font color="red"><b>7/9/2025 Update</b></font>

Module **ceuadmin/firefox/143.0a1** finally starts browsing normally.

It can be started as follows,

```bash
module load euadmin/firefox/143.0a1
firefox &
```

which uses only one CPU and is appropriate on a login node with heavy load (many users and/or processes). One may also check the definition (a way to facilitate) and increase the number to improve the performance.

```bash
alias firefox
# showing `alias firefox='MOZ_FORCE_DISABLE_E10S=1 firefox > /dev/null 2>&1'` 
unalias firefox
# call with three CPUs
MOZ_FORCE_DISABLE_E10S=3 firefox > /dev/null 2>&1 &
```

### ceuadmin/143.0.1

```bash
export version=143.0.1
mkdir -p firefox-$version
wget -qO- "https://archive.mozilla.org/pub/firefox/releases/$version/linux-x86_64/en-GB/firefox-$version.tar.xz" | \
tar -xJ --strip-components=1 -C firefox-$version/
cd firefox-$version/
MOZ_DISABLE_CONTENT_SANDBOX=1 firefox > /dev/null 2>&1 &
```

### ceuadmin/145.0a1

#### Artifact mode

Web: <https://firefox-source-docs.mozilla.org/contributing/build/artifact_builds.html>

```bash
./mach bootstrap
./mach configure --prefix=$CEUADMIN/firefox/145.0a1
./mach build -j5
./mach run --version
./mach install
./mach package
```

Command `./mach bootsrap` shows that

```
Please choose the version of Firefox you want to build (see note above):
  1. Firefox for Desktop Artifact Mode [default]
  2. Firefox for Desktop
  3. GeckoView/Firefox for Android Artifact Mode
  4. GeckoView/Firefox for Android
  5. SpiderMonkey JavaScript engine
Your choice: 1

Would you like to run a few configuration steps to ensure Git is
optimally configured? (Yn): y
Configuring git...
Set git config: "core.untrackedCache = true"
```

and `mozconfig`:

```
ac_add_options --enable-artifact-builds
ac_add_options --disable-tests
```

It is helpful to use `./mach run` for problems before `./mach install`. Finally, `./mach package` generates `obj-x86_64-pc-linux-gnu/dist/firefox-145.0a1.en-US.linux-x86_64.tar.xz`.

Files from `~/.mozbuild/sysroot-x86_64-linux-gnu/usr/lib64/crt*.o` are built and tested as follows,

```bash
dnf download kernel-headers
dnf download glibc
dnf download glibc-common
dnf download --resolve glibc-headers
dnf download glibc-devel
export SYSROOT=~/.mozbuild/sysroot-x86_64-linux-gnu
cd $SYSROOT
for rpm in ~/rds/software/firefox/*x86_64.rpm; do
    rpm2cpio "$rpm" | cpio -idmv -D .
done
for dir in lib lib64 libexec share; do
    ln -s usr/$dir
done
echo 'int main() { return 0; }' > test.c
gcc -o test test.c -fuse-ld=bfd
gcc --sysroot=$SYSROOT -B$SYSROOT -o test test.c -fuse-ld=bfd
```

#### Desktop

Option 2 is more involved. We take advantage of modules such as gcc/12.1.0, clang/19.1.7, etc.

```bash
./mach boostrap
export SYSROOT="$HOME/.mozbuild/sysroot-x86_64-linux-gnu"
mkdir -p $SYSROOT/usr/include/glib-2.0
cp -r /usr/include/glib-2.0/* $SYSROOT/usr/include/glib-2.0/
mkdir -p $SYSROOT/usr/lib64/glib-2.0/include
cp -r /usr/lib64/glib-2.0/include/* $SYSROOT/usr/lib64/glib-2.0/include/
module load ceuadmin/gcc/12.1.0
module load ceuadmin/gtk+/3.24.0
module load ceuadmin/rust
module load ceuadmin/clang/19.1.7
export CC=clang
export CXX=clang++
export CFLAGS="-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include $CFLAGS"
export CXXFLAGS="-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include $CXXFLAGS"
export DBUS_CFLAGS="$(pkg-config --cflags dbus-1)"
export CFLAGS="$DBUS_CFLAGS $CFLAGS"
export CXXFLAGS="$DBUS_CFLAGS $CXXFLAGS"
export BINDGEN_EXTRA_CLANG_ARGS="-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include"
./mach clobber
env PKG_CONFIG=~/fakebin/pkg-config ./mach configure --prefix=$CEUADMIN/firefox/145.0a1
./mach build
```

in addition to a `mozconfig` containing,

```
# Parallel build
mk_add_options MOZ_MAKE_FLAGS="-j5"

# Object directory
mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-@CONFIG_GUESS@

# Application
ac_add_options --enable-application=browser

# Optimizations
ac_add_options --enable-optimize
ac_add_options --disable-debug

# Use LLVM linker
ac_add_options --enable-linker=lld
ac_add_options --enable-default-toolkit=cairo-gtk3
```

**EXPERIMENTAL RESULTS**

Detailed configuration can be examined via `./mach configure > configure.log 2>&1`.

The following attempts become unnecessary with ceuadmin/gcc/12.1.0.

It now requires gcc/10 or above, and gtk+-3.0 along with xproto, kbproto, xextproto, renderproto, 

```bash
pkg-config --exists xproto && echo "xproto found" || echo "xproto NOT found"
pkg-config --exists kbproto && echo "kbproto found" || echo "kbproto NOT found"
pkg-config --exists xextproto && echo "xextproto found" || echo "xextproto NOT found"
pkg-config --exists renderproto && echo "renderproto found" || echo "renderproto NOT found"
```

and `~/fakebin/pkg-config` is generated to enforce use alsa.pc from `/usr/lib64/pkgconfig`.

```bash
export PKG_CONFIG_PATH=~/rds/software/firefox/rpms/usr/share/pkgconfig:$PKG_CONFIG_PATH
mkdir -p ~/fakebin
cat <<EOF > ~/fakebin/pkg-config
#!/bin/bash
export PKG_CONFIG_PATH=/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH
exec /usr/bin/pkg-config "$@"
EOF
chmod +x ~/fakebin/pkg-config
export PATH=~/fakebin:$PATH
```

One attempt is additionally used customized `my-clang` and `my-clang++` as follows,

```bash
module load ceuadmin/gtk+/3.24.0

export CC="$HOME/bin/my-clang"
export CXX="$HOME/bin/my-clang++"
export SPACK_VIEWS="/usr/local/software/spack/spack-views"
export GCC_TOOLCHAIN="$SPACK_VIEWS/rocky8-icelake-20220710/gcc-11.3.0/gcc-11.3.0/4zpip55j2rww33vhy62jl4eliwynqfru"
export LIBSTDCPP_INCLUDE="$GCC_TOOLCHAIN/include/c++/11.3.0"
export LIBSTDCPP_TARGET_INCLUDE="$LIBSTDCPP_INCLUDE/x86_64-pc-linux-gnu"
export LIBGCC_LIB64="$GCC_TOOLCHAIN/lib64"
export GTK_CFLAGS=$(pkg-config --cflags gtk+-3.0)
export GLIB_CFLAGS="-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include"
export STDCPP_CFLAGS="-isystem $LIBSTDCPP_INCLUDE -isystem $LIBSTDCPP_TARGET_INCLUDE"
export COMMON_WARNINGS="-Wno-unused-command-line-argument"
export CPPFLAGS="-I/usr/include $GLIB_CFLAGS $GTK_CFLAGS"
export CFLAGS="--gcc-toolchain=$GCC_TOOLCHAIN $STDCPP_CFLAGS $CPPFLAGS $COMMON_WARNINGS"
export CXXFLAGS="$CFLAGS"
export CXXFLAGS="-include cmath $CXXFLAGS"
GTK_LIBS=$(pkg-config --libs gtk+-3.0)
GLIB_LIBS=$(pkg-config --libs glib-2.0)
export LDFLAGS="--gcc-toolchain=$GCC_TOOLCHAIN -L$LIBGCC_LIB64 -L/usr/lib64 $GTK_LIBS $GLIB_LIBS"
export LD_LIBRARY_PATH="$LIBGCC_LIB64:$LD_LIBRARY_PATH"
chmod +x "$CC" "$CXX"
env PKG_CONFIG="$HOME/fakebin/pkg-config" ./mach configure --prefix="$CEUADMIN/firefox/145.0a1"
./mach build -j5
```

such that `my-clang` is defined as

```bash
#!/bin/bash
GCC_PATH=/usr/local/software/spack/spack-views/rocky8-icelake-20220710/gcc-11.3.0/gcc-11.3.0/4zpip55j2rww33vhy62jl4eliwynqfru

if [[ "$@" == *"--target=wasm32-wasi"* ]]; then
    exec /home/jhz22/.mozbuild/clang/bin/clang "$@"
else
    exec /home/jhz22/.mozbuild/clang/bin/clang --gcc-toolchain="$GCC_PATH" -L"$GCC_PATH/lib64" "$@"
fi
```

and `my-clang++` as

```bash
#!/bin/bash
GCC_PATH=/usr/local/software/spack/spack-views/rocky8-icelake-20220710/gcc-11.3.0/gcc-11.3.0/4zpip55j2rww33vhy62jl4eliwynqfru

# Check if compiling for WASM
if [[ "$@" == *"--target=wasm32-wasi"* ]]; then
    # Just call clang++ without linux-specific flags
    exec /home/jhz22/.mozbuild/clang/bin/clang++ "$@"
else
    # Native build: add gcc toolchain and lib paths
    exec /home/jhz22/.mozbuild/clang/bin/clang++ --gcc-toolchain="$GCC_PATH" -L"$GCC_PATH/lib64" "$@"
fi
```

respectively.

A hybrid of gcc/11 and clang (for newer libstdc++) is used via mozconfig above and [mozbuild.sh](files/mozbuild.sh) but appears that higher version of gcc is preferable.

```bash
./mach bootstrap
source mozbuild.sh | tee mozbuild.log
```

NOTES proto, etc. is similarly set up as follows,

```bash
# https://download.rockylinux.org/pub/rocky/8/AppStream/x86_64/os/Packages/
# https://download.rockylinux.org/pub/rocky/8/PowerTools/x86_64/os/Packages/
# https://download.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/
mkdir -p ~/rpms && cd ~/rpms
wget https://download.rockylinux.org/pub/rocky/8/AppStream/x86_64/os/Packages/x/xorg-x11-proto-devel-2020.1-3.el8.noarch.rpm
wget https://download.rockylinux.org/pub/rocky/8/PowerTools/x86_64/os/Packages/x/xorg-x11-xtrans-devel-1.4.0-4.el8.noarch.rpm
wget https://download.rockylinux.org/pub/rocky/8/PowerTools/x86_64/os/Packages/x/xcb-proto-1.13-4.el8.noarch.rpm
rpm2cpio *.rpm | cpio -idmv -D .
# fixing .pc + also ln -s usr/include, etc. from rpms
PCDIR="~/rds/software/firefox/rpms/usr/share/pkgconfig"
NEW_PREFIX="~/rds/software/firefox/rpms/usr"
for pcfile in "$PCDIR"/*.pc; do
  echo "Fixing $pcfile ..."
  # Backup original just in case
  cp "$pcfile" "$pcfile.bak"

  # Replace prefix and includedir lines
  sed -i "s|^prefix=/usr$|prefix=$NEW_PREFIX|g" "$pcfile"
  sed -i "s|^exec_prefix=/usr$|exec_prefix=\${prefix}|g" "$pcfile"
  sed -i "s|^includedir=/usr/include$|includedir=\${prefix}/include|g" "$pcfile"
done
echo "All .pc files fixed."
make
cd /tmp
cat <<EOF > test.c
#include <X11/Xproto.h>
int main() { return 0; }
EOF
gcc test.c -I~/rds/software/firefox/rpms/usr/include
```

which contains a test of bfd, as with necessary files from `dnf`.

### mozilla-firefox

As of 13/5/2025, firefox is moved from gecko-dev (see below) to <https://github.com/mozilla-firefox/firefox>.
It also provides a `GNUmakefile`, which is simpler than the one described earlier, for immediate use but it remains necessary to prevent
it from occupying all CPUs by adding flag `j5` as in `mozconfig` earlier.

The usual `git clone https://github.com/mozilla-firefox/firefox` gives error message:

> fatal: fetch-pack: invalid index-pack output

and we use SSH instead.

```bash
# SSH
git clone git@github.com:mozilla/firefox.git
# the latest commits
git clone --depth 1 git@github.com:mozilla/firefox.git
cd firefox
export MOZCONFIG=/rds/project/rds-4o5vpvAowP0/software/firefox/mozconfig
./mach configure --prefix=$CEUADMIN/firefox/nightly
make
MOZ_FORCE_DISABLE_E10S=1 ./mach run
./mach package
./mach install
```

We have

```
$ git clone git@github.com:mozilla/firefox.git
Cloning into 'firefox'...
X11 forwarding request failed on channel 0
remote: Enumerating objects: 11863463, done.
remote: Counting objects: 100% (21/21), done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 11863463 (delta 15), reused 13 (delta 13), pack-reused 11863442 (from 2)
Receiving objects: 100% (11863463/11863463), 3.64 GiB | 22.37 MiB/s, done.
Resolving deltas: 100% (9503284/9503284), done.
Updating files: 100% (385169/385169), done.
...
Adding configure options from /rds/project/rds-4o5vpvAowP0/software/firefox/mozconfig
Created package: /rds/project/rds-4o5vpvAowP0/software/firefox/obj-x86_64-pc-linux-gnu/dist/firefox-143.0a1.en-US.linux-x86_64.tar.xz
```

### gecko-dev

(Experimental)

This is the nightly version, in an attempt to explore why the release to CentOS 8 crashes.

```bash
git clone https://github.com/mozilla/gecko-dev.git
cd gecko-dev
module load python/3.8.11/gcc/pqdmnzmw
./mach bootstrap
for f in $(ls ~/.local/bin); do ln -sf ~/.local/bin/$f ~/bin/$f; done
export TMPDIR=$HPC_WORK/work
export MOZ_DISABLE_GPU=1
./mach help
./mach configure --prefix=$CEUADMIN/firefox/nightly
./mach build -j4
./mach install
./mach run --setpref="layers.acceleration.disabled=true"
./mach run --disable-e10s
ulimit -a
./mach clean
```

There is also `GNUmakefile` (extended version as in [here](files/GNUmakefile) listed below) which can be used by `gmake`.

```
# This Makefile is a shim for users with muscle memory for the "make" command.
# It's not intended for production usage or anything important.

# Default target to pull, clean, configure, build, and install
all: pull configure build install

# Module loading function (macro)
define load_modules
  if command -v module > /dev/null 2>&1; then \
    . /etc/profile.d/modules.sh; \
    module purge; \
    module load rhel8/default-icl; \
    module load python/3.8.11/gcc/pqdmnzmw; \
  else \
    echo "Module system not available. Skipping module commands."; \
  fi
endef

# Pull the latest changes from the repository (without module loading)
pull:
	@echo "Pulling latest code..."
	git pull

# Configure the build environment
configure:
	@echo "Running configuration with prefix: $(CEUADMIN)/firefox/nightly"
	@# Ensure CEUADMIN is set or use a default value
	$(if $(CEUADMIN),,$(error "CEUADMIN environment variable not set"))
	$(call load_modules)
	./mach configure --prefix=$(CEUADMIN)/firefox/nightly

# Build the project
build:
	@echo "Building the project..."
	$(call load_modules)
	./mach build

# Install the project
install:
	@echo "Installing the project..."
	$(call load_modules)
	./mach install

# Clean the build
clean:
	@echo "Cleaning the build..."
	./mach clobber

# Mark targets that don't represent files
.PHONY: all pull configure build install clean
```

By default, the compile takes all the resources so it is a good idea to make it manageable.

```bash
ulimit -v 15728640 # Set virtual memory limit to 15 GB
export MOZCONFIG=/rds/project/rds-4o5vpvAowP0/software/gecko-dev/mozconfig
```

with `mzconfig` containing these lines

```mozconfig
# Set the number of parallel jobs
mk_add_options MOZ_MAKE_FLAGS="-j5"
# Set the object directory
mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-@CONFIG_GUESS@
# Enable application (Firefox)
ac_add_options --enable-application=browser
# Enable optimization and disable debugging
ac_add_options --enable-optimize
ac_add_options --disable-debug
```

for instance, we see it translates to ` /usr/bin/gmake -C . -j5 -s -w install` near the end.
