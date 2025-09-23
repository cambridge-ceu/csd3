---
sort: 25
---

# firefox

## ceuadmin/145.0a1

<font color="red"><b>23/9/2025 Update</b></font>
It now requires gcc/10 or above.

### Artifact mode

Web: <https://firefox-source-docs.mozilla.org/contributing/build/artifact_builds.html>

(successful but not quite working)

```bash
module load gcc/11.3.0/gcc/4zpip55j
module load ceuadmin/rust
./mach bootstrap
ls ~/.mozbuild/sysroot-x86_64-linux-gnu/usr/lib/x86_64-linux-gnu/crt*.o
./mach artifact install
./mach clobber
./mach configure --prefix=$CEUADMIN/firefox/145.0a1
./mach build -j5
./mach install
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

can be furnished with mozconfig:

```
# Use artifact build mode to download prebuilt Firefox binaries
# ac_add_options --enable-artifact-builds
```

### Desktop

Option 2 is more involved and file `mozconfig` is modified

```
# Set custom GCC and G++ paths
export CC=/usr/local/software/spack/spack-views/rocky8-icelake-20220710/gcc-11.3.0/gcc-11.3.0/4zpip55j2rww33vhy62jl4eliwynqfru/bin/gcc
export CXX=/usr/local/software/spack/spack-views/rocky8-icelake-20220710/gcc-11.3.0/gcc-11.3.0/4zpip55j2rww33vhy62jl4eliwynqfru/bin/g++

# Use BFD linker explicitly
ac_add_options --enable-linker=bfd

# Use sysroot
export SYSROOT=/home/jhz22/.mozbuild/sysroot-x86_64-linux-gnu
export BINDGEN_EXTRA_CLANG_ARGS="--sysroot=$SYSROOT -I/usr/include -I/usr/include/x86_64-linux-gnu"
export CFLAGS="--sysroot=$SYSROOT -I$SYSROOT/usr/include -m64"
export CXXFLAGS="--sysroot=$SYSROOT -I$SYSROOT/usr/include -m64"
export LDFLAGS="--sysroot=$SYSROOT -L$SYSROOT/usr/lib/x86_64-linux-gnu -m64"

# Set Rust linker to avoid mismatched architectures
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=$CC

# Specify target platform explicitly (important!)
ac_add_options --target=x86_64-unknown-linux-gnu

# Set the object directory
mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-source

# Optional: use up to 5 cores for parallel build
mk_add_options MOZ_MAKE_FLAGS="-j5"

# Disable debug symbols and enable optimizations for faster build
ac_add_options --disable-debug
ac_add_options --enable-optimize
```

A test of bfd, as with necessary files from `dnf`:

```bash
export PKG_CONFIG_PATH=/usr/lib64/pkgconfig:$PKG_CONFIG_PATH
export SYSROOT=~/.mozbuild/sysroot-x86_64-linux-gnu
echo 'int main() { return 0; }' > test.c
gcc -o test test.c -fuse-ld=bfd
gcc --sysroot=/home/jhz22/.mozbuild/sysroot-x86_64-linux-gnu \
    -B$SYSROOT -o test test.c -fuse-ld=bfd
dnf download kernel-headers
dnf download glibc
dnf download glibc-common
dnf download --resolve glibc-headers
dnf download glibc-devel
cd $SYSROOT
for rpm in ~/rds/software/firefox/*x86_64.rpm; do
    rpm2cpio "$rpm" | cpio -idmv -D .
done
for dir in lib lib64 libexec share; do
    ln -s usr/$dir
done
module load ceuadmin/pkg-config
./mach build
```

## ceuadmin/firefox/nightly

<font color="red"><b>7/9/2025 Update</b></font>

Module ceuadmin/firefox/nightly (143.0a1) finally starts browsing normally.

It can be started as follows,

```bash
module load euadmin/firefox/nightly
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

## mozilla-firefox

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

## gecko-dev

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
