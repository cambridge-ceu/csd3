---
sort: 38
---

# hapstat

Web, <https://dlin.web.unc.edu/software/hapstat>

## Installation

The distribution is 32-bit executable, and to run under our 64-bit system a singularity module has been built.

```bash
wget http://archive.debian.org/debian/pool/main/g/gcc-3.3/libstdc++5_3.3.6-25_i386.deb
ar x libstdc++5_3.3.6-25_i386.deb
tar -xvf data.tar.gz
cp usr/lib/i386-linux-gnu/libstdc++.so.5* ./
singularity build --arch 386 hapstat.sif hapstat.def
singularity exec hapstat.sif hapstat --help
```

according to [hapstat.def](files/hapstat.def) and the last command shows

```
hapstat v3.0 (01 August 2008)

Usage: hapstat data:type spec [-e, --external=data:type]
       [-h, --hardy-weinberg=HW] [-i, --iterations=N]
       [-m, --model=M] [-t, --tolerance=TOL] [-o result]

Mandatory arguments:
    data:type                 study file or directory:study data type
    spec                      variable specification file

Options:
    -e, --external=data:type  external file or directory:external data type
    -h, --hardy-weinberg=HW   Hardy-Weinberg assumption
    -i, --iterations=N        maximum number of iterations
    -m, --model=M             mode of inheritance
    -t, --tolerance=TOL       error tolerance
    -o result                 output file or directory
```

Nevertheless, the .sif thus created has difficulties in taking data and a Bash script [hapstat](files/hapstat) is created.

## Testing

The benchmark is within example/. Here the case-control.dat / spec.dat pair is used.

```bash
module load ceuadmin/hapstat
hapstat case-control.dat:case-control spec.dat
hapstat case-control.dat:case-control spec.dat -o case-control.out
```

with screen output and file case-control.log,

```
[INFO] Running singularity with command:
singularity exec --bind "/usr/local/Cluster-Apps/ceuadmin/hapstat/3.0/example:/data" "/usr/local/Cluster-Apps/ceuadmin/hapstat/3.0/hapstat.sif" /bin/bash <temp_script> "case-control.dat" "case-control" "spec.dat" "case-control" -o case-control.new
[INFO] Container CWD: /tmp/hapstat-work-1756936580-22951
[INFO] Copying files from /data: case-control.dat, spec.dat
[INFO] Running hapstat command inside container:
  hapstat case-control.dat:case-control spec.dat -o case-control.new
<hapstat> case-control.dat: result saved to 'case-control.new'.
[INFO] Running singularity with command:
singularity exec --bind "/usr/local/Cluster-Apps/ceuadmin/hapstat/3.0/example:/data" "/usr/local/Cluster-Apps/ceuadmin/hapstat/3.0/hapstat.sif" /bin/bash <temp_script> "case-control.dat" "case-control" "spec.dat" "case-control" -o case-control.out
[INFO] Container CWD: /tmp/hapstat-work-1756936600-314
[INFO] Copying files from /data: case-control.dat, spec.dat
[INFO] Running hapstat command inside container:
  hapstat case-control.dat:case-control spec.dat -o case-control.out
<hapstat> case-control.dat: result saved to 'case-control.out'.
```
