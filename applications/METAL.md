---
sort: 25
---

# METAL

GitHub: [https://github.com/statgen/METAL](https://github.com/statgen/METAL)

## Installed modules

```bash
module avail metal
module load metal/2011-03-25
```

then `which metal` will point to `/usr/local/Cluster-Apps/metal/2011-03-25/generic-metal/executables/metal`.

It is clear that this is an older version.

## Installing from source

We resort to an up-to-date version here -- a notable feature is that the effect/standard error fields allow for more significant digits,

```bash
cd /rds/user/$USER/hpc-work
wget -qO- https://github.com/statgen/METAL/archive/2020-05-05.tar.gz | \
tar xvfz -
cd METAL-2020-05-05
mkdir build && cd build
cmake ..
make
make test
make install
ln -sf /rds/user/$USER/hpc-work/METAL-2020-05-05/build/bin/metal /rds/user/$USER/hpc-work/bin/metal
```

where the last command generates a symbolic link to the executable, so that metal is in the search path and can be called anywhere.

## Adaptation

We have modified source code to encapsulate information on variant significant statistics such that the +/- signs in the direction field of METAL output becomes p/n when they also have p-value <= 0.05. This faciliates selection of variants using criteria such as flagging variants to be significant at least at the 0.05 level.

A version is available here, [https://github.com/cambridge-ceu/METAL](https://github.com/cambridge-ceu/METAL); see the release notes there for the changes made.

## Examples

The `tests/` directory contains 10 variations and can be run from the `build/` directory as follows,

```bash
make test
```

which gives,

```
make test
Running tests...
Test project /home/jhz22/hpc-work/METAL-2020-05-05/build
      Start  1: NORMP
 1/12 Test  #1: NORMP ...................................   Passed    0.10 sec
      Start  2: BINORMP
 2/12 Test  #2: BINORMP .................................   Passed    0.05 sec
      Start  3: BINORMQ
 3/12 Test  #3: BINORMQ .................................   Passed    0.01 sec
      Start  4: SAMPLESIZE_NOGC
 4/12 Test  #4: SAMPLESIZE_NOGC .........................   Passed    0.70 sec
      Start  5: SAMPLESIZE_GC
 5/12 Test  #5: SAMPLESIZE_GC ...........................   Passed    0.24 sec
      Start  6: STDERR_NOGC
 6/12 Test  #6: STDERR_NOGC .............................   Passed    0.26 sec
      Start  7: STDERR_GC
 7/12 Test  #7: STDERR_GC ...............................   Passed    0.23 sec
      Start  8: SAMPLESIZE_NOGC_HETEROGENEITY
 8/12 Test  #8: SAMPLESIZE_NOGC_HETEROGENEITY ...........   Passed    0.41 sec
      Start  9: STDERR_NOGC_HETEROGENEITY
 9/12 Test  #9: STDERR_NOGC_HETEROGENEITY ...............   Passed    0.29 sec
      Start 10: SAMPLESIZE_NOGC_OVERLAP_HETEROGENEITY
10/12 Test #10: SAMPLESIZE_NOGC_OVERLAP_HETEROGENEITY ...   Passed    0.38 sec
      Start 11: TRACK_POSITIONS
11/12 Test #11: TRACK_POSITIONS .........................   Passed    0.26 sec
      Start 12: PRINT_PRECISION
12/12 Test #12: PRINT_PRECISION .........................   Passed    0.25 sec

100% tests passed, 0 tests failed out of 12

Total Test time (real) =   3.53 sec
```
