---
sort: 16
---

# R/SAIGE 0.36.6 and 0.39.2

Full name: Scalable and Accurate Implementation of GEneralized mixed model (SAIGE)

GitHub page: [https://github.com/weizhouUMICH/SAIGE](https://github.com/weizhouUMICH/SAIGE).

The following is based on source from GitHub (so with the possibility to git pull),

```bash
module load cmake/3.9 gcc/5
module load python/2.7
virtualenv py27
source py27/bin/activate
pip install cget
git clone https://github.com/weizhouUMICH/SAIGE
R CMD INSTALL SAIGE
```

Now we see `.../SAIGE.so: undefined symbol: sgecon_`. One can get away with it by renaming `configure` to `configure.sav` (so avoid repeated downloads) and amend the last `g++ ... -o SAIGE.so` with `-L$HPC_WORK/lib64 -llapack` and then rerun `R CMD INSTALL SAIGE`. After successful installation, we can try `cd SAIGE/extdata; bash cmd.sh`.

One of the third party software is `bgenix` (BE careful with a buggy `cat-bgen`!), whose `wscript` uses Python 2 syntax so it is necessary to stick to python/2.7 explicitly since gcc/5 automatically loads python 3.

```
cd SAIGE
cd thirdParty
cd bgen
./waf configure --prefix=$HPC_WORK
./waf
./waf install
build/test/unit/test_bgen
build/apps/bgenix -g example/example.16bits.bgen -list
cd ../../..
```

See [https://github.com/weizhouUMICH/SAIGE/issues/98](https://github.com/weizhouUMICH/SAIGE/issues/98).

For the latest version 0.39.2 which deals with the chromosome X ploidy, the following steps are necessary

```bash
R -e "devtools::install_github('leeshawn/MetaSKAT')"
R -e "devtools::install_github('leeshawn/SPAtest')"
git clone --depth 1 -b 0.39.2 https://github.com/weizhouUMICH/SAIGE
R CMD INSTALL SAIGE
```

which first installs MetaSKAT 0.80 also at CRAN but SPAtest 3.1.2 instead of 3.0.2 from CRAN.