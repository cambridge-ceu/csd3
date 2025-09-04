---
sort: 72
---

# SNPTEST

Web: [https://www.well.ox.ac.uk/~gav/snptest/](https://www.well.ox.ac.uk/~gav/snptest/)

```bash
cd ${HPC_WORK}
wget -qO- http://www.well.ox.ac.uk/~gav/resources/snptest_v2.5.6_CentOS_Linux7.8-x86_64_dynamic.tgz | \
tar xvfz -
ln -sf ${HPC_WORK}/snptest_v2.5.6_CentOS_Linux7.8.2003-x86_64_dynamic/snptest_v2.5.6 ${HPC_WORK}/bin/snptest_v2.5.6
(
  echo module load gcc/5
  echo "snptest_v2.5.6 $@"
) > ${HPC_WORK}/bin/snptest
```

Note that we have wrap up `snptest_v2.5.6` inside `snptest` since it requires `gcc/5` or above to function properly.
