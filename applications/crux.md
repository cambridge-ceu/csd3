---
sort: 17
---

# crux

Web: <https://crux.ms/> (<https://github.com/crux-toolkit>)

The binary provided requires GLIBC_2.29 which is not avaiable yet problematic with ceuadmin/glibc/2.29-icelake.

We get around with issue through singularity (apptainer version 1.3.6-1.el8),

```bash
singularity build crux.sif crux.def
singularity run crux.sif
```

where [`crux.def`](files/crux.def) is rather simple.

---

Under CentOS 7, it cannot access `https://noble.gs.washington.edu/crux-downloads/pwiz-src-3_0_24044_fd6604f.tar.bz2`.
Under CentOS 8 we proceed with

```bash
git clone https://github.com/crux-toolkit && cd crux-toolkit
export PERL5LIB=
module load ceuadmin/openssh/9.7p1-icelake \
            ceuadmin/openssl/3.2.1-icelake \
            ceuadmin/libssh/0.10.6-icelake \
            ceuadmin/boost/1.76.0 \
            ceuadmin/krb5/1.21.2-icelake ceuadmin/p7zip-zstd/17.05
cmake .
make
```

but fail due to the same reason since ld -lrt requires librt which is part of GLIBC_2.29. Nevertheless under ext/,
comment the last line of `build_pwiz.cmake` will enable the whole process with the following errors on pwiz

```
/usr/bin/ld: cannot find -lpwiz_data_msdata
/usr/bin/ld: cannot find -lpwiz_data_msdata_mz5
/usr/bin/ld: cannot find -lpwiz_data_msdata_mzmlb
/usr/bin/ld: cannot find -lpwiz_data_msdata_core
/usr/bin/ld: cannot find -lpwiz_data_identdata
/usr/bin/ld: cannot find -lhdf5pp
collect2: error: ld returned 1 exit status
```

related to ProteoWizard, <https://github.com/ProteoWizard/pwiz/>, i.e.,

```
...failed updating 10 targets...
...skipped 376 targets...
...updated 836 targets...
At least one pwiz target failed to build.
```

See `build/src/ProteoWizard/libraries`.

There is a FAQ section from PrteoWizard (<https://raw.githubusercontent.com/ProteoWizard/pwiz/981c7c70bfed46a145931dbea4da9e2edde72cf5/scripts/autotools/FAQ>),

Standalone pwiz is available from <https://proteowizard.sourceforge.io/download.html> or <https://github.com/ProteoWizard/pwiz> and from pwiz-skyline docker: <https://hub.docker.com/r/chambm/pwiz-skyline-i-agree-to-the-vendor-licenses>

```bash
docker pull chambm/pwiz-skyline-i-agree-to-the-vendor-licenses
docker run -it --rm chambm/pwiz-skyline-i-agree-to-the-vendor-licenses wine msconvert --help
docker run -it --rm chambm/pwiz-skyline-i-agree-to-the-vendor-licenses wine SkylineCmd --help
docker run -it --rm -e WINEDEBUG=-all -v /your/data:/data chambm/pwiz-skyline-i-agree-to-the-vendor-licenses \
       wine msconvert /data/file.raw
```

Syntax for the last docker command using a virtual Linux machine (not CSD3!) with file named `/home/$USER/D/Downloads/szwk901104i19801xms1.raw`:

```bash
docker run -it --rm -e WINEDEBUG=-all -v /home/jhz22/D/Downloads:/data chambm/pwiz-skyline-i-agree-to-the-vendor-licenses \
       wine msconvert /data/szwk901104i19801xms1.raw --filter "peakPicking true 1-"
```

The screen output is as follows,

```
format: mzML
    m/z: Compression-Zlib, 64-bit
    intensity: Compression-Zlib, 32-bit
    rt: Compression-Zlib, 64-bit
ByteOrder_LittleEndian
 indexed="true"
outputPath: .
extension: .mzML
contactFilename:
runIndexSet:

spectrum list filters:
  peakPicking true 1-

chromatogram list filters:

filenames:
  /data\szwk901104i19801xms1.raw

processing file: /data\szwk901104i19801xms1.raw
calculating source file checksums

writing output file: .\szwk901104i19801xms1.mzML
```
