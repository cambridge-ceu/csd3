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
