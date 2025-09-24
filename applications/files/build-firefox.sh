#!/bin/bash
set -e

export MOZCONFIG=$PWD/mozconfig

export PKG_CONFIG_PATH=/usr/local/Cluster-Apps/ceuadmin/gtk+/3.24.0/lib/pkgconfig:$PKG_CONFIG_PATH
unset PKG_CONFIG_SYSROOT_DIR

export SYSROOT=/home/jhz22/.mozbuild/sysroot-x86_64-linux-gnu
export EXTRA_X11_INCLUDE=$PWD/rpms/usr/include

export CC=/usr/local/software/spack/spack-views/rocky8-icelake-20220710/gcc-11.3.0/gcc-11.3.0/4zpip55j2rww33vhy62jl4eliwynqfru/bin/gcc
export CXX=/usr/local/software/spack/spack-views/rocky8-icelake-20220710/gcc-11.3.0/gcc-11.3.0/4zpip55j2rww33vhy62jl4eliwynqfru/bin/g++
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=$CC

export CFLAGS="--sysroot=$SYSROOT -I$SYSROOT/usr/include -I$EXTRA_X11_INCLUDE -m64"
export CXXFLAGS="$CFLAGS"
export BINDGEN_EXTRA_CLANG_ARGS="--sysroot=$SYSROOT/usr -I/usr/include -I/usr/include/x86_64-linux-gnu -I$EXTRA_X11_INCLUDE"
export LDFLAGS="--sysroot=$SYSROOT -L$SYSROOT/usr/lib64/x86_64-linux-gnu -m64"

# Debug pkg-config visibility of alsa.pc
echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH"
pkg-config --modversion alsa || echo "alsa package not found!"

./mach build
