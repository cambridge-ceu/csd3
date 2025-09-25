---
sort: 25
---

# Firefox

GitHub: <https://github.com/mozilla-firefox/firefox>

## ceuadmin/firefox

<font color="red"><b>23/9/2025 Update</b></font>

Module **ceuadmin/145.0a1** is available and used as follows,

```bash
module load euadmin/firefox/145.0a1
firefox &
```

<font color="red"><b>7/9/2025 Update</b></font>

Module **ceuadmin/firefox/nightly** (143.0a1) finally starts browsing normally.

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

## ceuadmin/145.0a1

It now requires gcc/10 or above.

### Artifact mode

Web: <https://firefox-source-docs.mozilla.org/contributing/build/artifact_builds.html>

```bash
module load gcc/11.3.0/gcc/4zpip55j
module load ceuadmin/rust
./mach bootstrap
./mach artifact install
./mach clobber
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
```

It is helpful to use `./mach run` for problems before installation with `./mach install`. Finally, `./mach package` generates `obj-x86_64-pc-linux-gnu/dist/firefox-145.0a1.en-US.linux-x86_64.tar.xz`.

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

### Desktop

Option 2 is more involved and file [`mozconfig`](files/mozconfig) and [`build-firefox.sh`](files/build-firefox.sh) are created.

It requires gtk+-3.0 along with xproto, kbproto, renderproto, which are manually set up as follows,

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
PCDIR="~//rds/software/firefox/rpms/usr/share/pkgconfig"
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

which contains a test of bfd, as with necessary files from `dnf`. It is now ready to proceed with

```bash
module load gcc/11.3.0/gcc/4zpip55j
module load ceuadmin/gtk+/3.24.0
module load ceuadmin/rust
export PKG_CONFIG_PATH=~/rds/software/firefox/rpms/usr/share/pkgconfig:/usr/lib64/pkgconfig:$PKG_CONFIG_PATH
./mach configure --prefix=$CEUADMIN/firefox/145.0a1
./mach build
```

Note `/usr/lib64/pkgconfig` contains alsa.pc, which is reported missing nevertheless.

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
