#!/bin/bash

module load gcc/11.3.0/gcc/4zpip55j
module load ceuadmin/gtk+/3.24.0
module load ceuadmin/rust
module load ceuadmin/clang/19.1.7

export GCC_PATH=/usr/local/software/spack/spack-views/rocky8-icelake-20220710/gcc-11.3.0/gcc-11.3.0/4zpip55j2rww33vhy62jl4eliwynqfru
if [ -d "$GCC_PATH/lib64" ]; then
  export GCC_LIB_PATH="$GCC_PATH/lib64"
else
  export GCC_LIB_PATH="$GCC_PATH/lib"
fi
export GCC_X86_64=$GCC_PATH/lib/gcc/x86_64-pc-linux-gnu/11.3.0
export PKG_CONFIG_PATH="/usr/lib64/pkgconfig:$PKG_CONFIG_PATH"
export CLANG_PATH=/usr/local/Cluster-Apps/ceuadmin/clang/19.1.7
export CLANG="$CLANG_PATH/bin/clang"

export CC="$CLANG --gcc-toolchain=$GCC_PATH -B$GCC_X86_64 -B$GCC_LIB_PATH"
export CXX="$CLANG_PATH/bin/clang++ --gcc-toolchain=$GCC_PATH -B$GCC_X86_64 -B$GCC_LIB_PATH"

export SYSROOT="$HOME/.mozbuild/sysroot-x86_64-linux-gnu"
export CFLAGS="--gcc-toolchain=$GCC_PATH --sysroot=$SYSROOT -I$GCC_PATH/lib/gcc/x86_64-pc-linux-gnu/11.3.0/include"
export CXXFLAGS="--gcc-toolchain=$GCC_PATH --sysroot=$SYSROOT -I$GCC_PATH/include/c++/11.3.0 -I$GCC_PATH/include/c++/11.3.0/x86_64-pc-linux-gnu"
export GLIB_INCLUDE="/usr/include/glib-2.0"
export GLIB_CONFIG_INCLUDE="/usr/lib64/glib-2.0/include"
export CFLAGS="$CFLAGS -I$GLIB_INCLUDE -I$GLIB_CONFIG_INCLUDE"
export CXXFLAGS="$CXXFLAGS -I$GLIB_INCLUDE -I$GLIB_CONFIG_INCLUDE"
export LDFLAGS="--sysroot=$SYSROOT -fuse-ld=lld -B$GCC_X86_64 -L$GCC_LIB_PATH -L$GCC_PATH/lib -L$GCC_X86_64 -L$SYSROOT/lib64"

export LIBRARY_PATH="$GCC_X86_64:$GCC_LIB_PATH:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$GCC_PATH/lib64:$GCC_PATH/lib:$LD_LIBRARY_PATH"

export RUSTFLAGS="-C linker=$CLANG -C link-arg=--sysroot=$SYSROOT -C link-arg=-fuse-ld=lld"
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=$CLANG
export MOZCONFIG=$HOME/rds/software/firefox/mozconfig

# Test compile
echo 'int main() { return 0; }' > test.c
$CLANG --gcc-toolchain=$GCC_PATH -B$GCC_X86_64 -B$GCC_LIB_PATH -fuse-ld=lld test.c -o test
./test && echo "✅ Link test passed"

echo '#include <algorithm>' > test.cpp
$CXX -v -c test.cpp

# Fix crt objects for sysroot (if needed)
mkdir -p "$SYSROOT"
ln -sf $GCC_X86_64/crtbeginS.o "$SYSROOT/crtbeginS.o"
ln -sf $GCC_X86_64/crtendS.o "$SYSROOT/crtendS.o"

# Confirm crt objects are visible
ls -1 $GCC_X86_64 | grep crt

# Clean & build
./mach clobber
env PKG_CONFIG=~/fakebin/pkg-config ./mach configure --prefix=$CEUADMIN/firefox/145.0a1
./mach build
