---
sort: 5
---

# aria2

Web: [https://aria2.github.io/](https://aria2.github.io/).

On CSD3, one can use the prerequiste `module load aria2-1.33.1-gcc-5.4.0-r36jubs`.

## Installation

```bash
export HPC_WORK=/rds/user/${USER}/hpc-work
wget -qO- https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0.tar.gz | \
tar xvfz -
cd aria2-1.36.0/
module load gettext-0.19.8.1-gcc-5.4.0-zaldouz
./configure --prefix=${HPC_WORK} --enable-static
make
make install
```

## Examples

```bash
aria2c -h
aria2c -i urls.txt
awk 'NR==10' urls.txt | \
aria2c -i -
```

The commands give usage information, download files in `urls.txt` and the tenth file only, respectively.
