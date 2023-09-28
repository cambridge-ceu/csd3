---
sort: 49
---

# sra-tools

Web: <https://github.com/ncbi/sra-tools>

## ncbi-vdb

The installation is preceeded with `module load gcc/6 flex-2.6.4-gcc-5.4.0-2u2fgon`. Although `configure` is provided, `cmake` is used instead.

```bash
cmake -DCMAKE_PREFIX_PATH=$CEUADMIN/ncbi-vdb/3.0.8 -DCMAKE_INSTALL_PREFIX=$CEUADMIN/ncbi-vdb/3.0.8 ..
```

## sra-tools

First, create a symbolic link for `ncbi-vdb/3.0.8` in the parent directory.

```bash
cmake -DVDB_LIBDIR=$CEUADMIN/ncbi-vdb/3.0.8/lib64 -DCMAKE_INSTALL_PREFIX=$CEUADMIN/sra-tools/3.0.8 ..
```

Drop `constexpr` as in `constexpr size_type max_size() const { return SIZE_MAX; }` in line 161 of the following header file:

`/usr/local/Cluster-Apps/ceuadmin/sra-tools/3.0.8/tools/external/driver-tool/util.hpp`.

## modules

This is available from `module load ceuadmin/sra-tools`
