---
sort: 8
---

# Green Algorithms

Web: [https://www.green-algorithms.org/](https://www.green-algorithms.org/) (GitHub, [https://github.com/GreenAlgorithms/green-algorithms-tool](https://github.com/GreenAlgorithms/green-algorithms-tool))

Source at GitHub: [https://github.com/Llannelongue/GreenAlgorithms4HPC](https://github.com/Llannelongue/GreenAlgorithms4HPC))

## CSD3 location

<font color="red"><b>26/11/2022 Update</b>: </font><font color="blue"><b> it is available as a module.</b></font>

```bash
module load ceuadmin/GreenAlgorithms4HPC/0.2.2-beta
```

For CEU users, the location of the script is as follows,

> /rds/project/jmmh2/rds-jmmh2-projects/inouye_lab_other/share_space/GreenAlgorithms4HPC/myCarbonFootprint.sh

It is possible to use this directly,

```bash
/rds/project/jmmh2/rds-jmmh2-projects/inouye_lab_other/share_space/GreenAlgorithms4HPC/myCarbonFootprint.sh --help
```

which gives the following output,

```
Python versions: OK
Virtualenv: OK
usage: GreenAlgorithms_global.py [-h] [-S STARTDAY] [-E ENDDAY] [--filterCWD]
                                 [--filterJobIDs FILTERJOBIDS] [--reportBug]
                                 [--reportBugHere]

Calculate your carbon footprint on My cluster.

optional arguments:
  -h, --help            show this help message and exit
  -S STARTDAY, --startDay STARTDAY
                        The first day to take into account, as YYYY-MM-DD
                        (default: 2022-01-01)
  -E ENDDAY, --endDay ENDDAY
                        The last day to take into account, as YYYY-MM-DD
                        (default: today)
  --filterCWD           Only report on jobs launched from the current
                        location.
  --filterJobIDs FILTERJOBIDS
                        Comma seperated list of Job IDs you want to filter on.
  --reportBug           In case of a bug, this flag logs jobs informations so
                        that we can fix it. Note that this will write out some
                        basic information about your jobs, such as runtime,
                        number of cores and memory usage.
  --reportBugHere       Similar to --reportBug, but exports the output to your
                        home folder
```

## GitHub

We can also install a specific copy,

```bash
git clone https://github.com/Llannelongue/GreenAlgorithms4HPC
cd GreenAlgorithms4HPC
chmod +x myCarbonFootprint.sh
```

and then call as follows,

```bash
myCarbonFootprint.sh --help
myCarbonFootprint.sh --startDay 2022-01-01 --endDay 2022-05-31
```

## Reference

Lannelongue L, Grealey J, Inouye M. Green Algorithms: Quantifying the Carbon Footprint of Computation. _Advance Science_ 8(12), 2021,
[https://doi.org/10.1002/advs.202100707](https://doi.org/10.1002/advs.202100707)
