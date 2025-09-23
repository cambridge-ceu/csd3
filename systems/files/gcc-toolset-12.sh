#!/usr/bin/env bash
set -eo pipefail

# Destination directory
DEST_DIR="gcc-toolset-12"

# List of RPM packages
PACKAGES=(
  "gcc-toolset-12-12.0-5.el8.x86_64.rpm"
  "gcc-toolset-12-annobin-annocheck-10.76-5.el8.x86_64.rpm"
  "gcc-toolset-12-annobin-docs-10.76-5.el8.noarch.rpm"
  "gcc-toolset-12-annobin-plugin-gcc-10.76-5.el8.x86_64.rpm"
  "gcc-toolset-12-binutils-2.38-16.el8.x86_64.rpm"
  "gcc-toolset-12-binutils-gold-2.38-16.el8.x86_64.rpm"
  "gcc-toolset-12-dwz-0.14-2.el8.x86_64.rpm"
  "gcc-toolset-12-gcc-12.1.1-3.2.el8.x86_64.rpm"
  "gcc-toolset-12-gcc-c++-12.1.1-3.2.el8.x86_64.rpm"
  "gcc-toolset-12-gcc-gfortran-12.1.1-3.2.el8.x86_64.rpm"
  "gcc-toolset-12-gcc-plugin-annobin-12.2.1-7.6.el8.x86_64.rpm"
  "gcc-toolset-12-gdb-11.2-3.el8.x86_64.rpm"
  "gcc-toolset-12-libquadmath-devel-12.1.1-3.2.el8.x86_64.rpm"
  "gcc-toolset-12-libstdc++-devel-12.1.1-3.2.el8.x86_64.rpm"
  "gcc-toolset-12-runtime-12.0-5.el8.x86_64.rpm"
)

mkdir -p "$DEST_DIR"
mkdir -p "$DEST_DIR/opt/rh/$DEST_DIR/root/var"

# Make sure you have full write permissions in DEST_DIR and contents
chmod -R u+w "$DEST_DIR"
chown -R "$(whoami)" "$DEST_DIR"

cd "$DEST_DIR" || exit 1

for pkg in "${PACKAGES[@]}"; do
  echo "Extracting: $pkg"
  rpm2cpio "../$pkg" | cpio --no-absolute-filenames -idmuv
done

echo "✅ Extraction complete! Files are now under: $DEST_DIR"
