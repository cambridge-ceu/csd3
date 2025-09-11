---
sort: 10
---

# mity

GitHub: <http://github.com/KCCG/mity>

## Installation

```bash
singularity pull docker://drmjc/mity
```

shows

```
$ singularity pull docker://drmjc/mity
INFO:    Converting OCI blobs to SIF format
WARNING: 'nodev' mount option set on /rds/user/jhz22, it could be a source of failure during build process
INFO:    Starting build...
INFO:    Fetching OCI image...
11.5MiB / 11.5MiB [======================================================================================================] 100 % 26.0 MiB/s 0s
3.2MiB / 3.2MiB [========================================================================================================] 100 % 26.0 MiB/s 0s
29.9MiB / 29.9MiB [======================================================================================================] 100 % 26.0 MiB/s 0s
1.0MiB / 1.0MiB [========================================================================================================] 100 % 26.0 MiB/s 0s
217.9MiB / 217.9MiB [====================================================================================================] 100 % 26.0 MiB/s 0s
313.7MiB / 313.7MiB [====================================================================================================] 100 % 26.0 MiB/s 0s
4.7MiB / 4.7MiB [========================================================================================================] 100 % 26.0 MiB/s 0s
4.0MiB / 4.0MiB [========================================================================================================] 100 % 26.0 MiB/s 0s
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
[-------------------------------------------------------------------------------------------------------------------------------------] 0 % 0s
[===================================================================================================================================] 100 % 0s
```

## Testing

```bash
singularity run mity_latest.sif -h
```

shows

```
$ singularity run mity_latest.sif -h
usage: mity [-h] {call,normalise,report,merge,runall,version} ...

Mity: a sensitive variant analysis pipeline optimised for WGS data

positional arguments:
  {call,normalise,report,merge,runall,version}
                        mity sub-commands (use with -h for more info)
    call                Call mitochondrial variants
    normalise           Normalise & FILTER mitochondrial variants
    report              Generate mity report
    merge               Merging mity VCF with nuclear VCF
    runall              Run MITY call, normalise and report all in one go.
    version             Display this program's version.

options:
  -h, --help            show this help message and exit

Usage: See the online manual for details: http://github.com/KCCG/mity
Authors: Clare Puttick, Mark Cowley, Trent Zeng, Christian Fares
License: MIT
Version: 2.0.1
```

## ceuadmin/mity/2.0.1

```bash
module load ceuadmin/mity/2.0.1
alias mity
mity -h
```
