### System

CSD3 stands for the Cambridge Service for Data Driven Discovery by [Research Computing Services](https://www.csd3.cam.ac.uk/), which provies an excellent [documentation](https://docs.hpc.cam.ac.uk/hpc/) besides [other services](https://www.hpc.cam.ac.uk/).
Here some aspects are highlighted from the perspectives of the [Cardiovascular Epidemiology Unit](https://www.phpc.cam.ac.uk/ceu/) (CEU), where all information about procedures and access requests can be found from **W:\Administration\CSD3 Data Users**.

Basic information is available from a CSD3 console
```bash
# system bit
getconf LONG_BIT
# system information
uname -a
# -s kernel name
# -n node name
# -r kernel release
# -v kernel version
# -p processor
# -o operating system
# Linux Standard Base (lsb) and distribution information
lsb_release -a
# CPU information
lscpu
watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""
```
where breakdown of `uname -a` is also given and for instance `lsb_release -a` gives
```
Distributor ID: Scientific
Description:    Scientific Linux release 7.7 (Nitrogen)
Release:        7.7
Codename:       Nitrogen
```
so the system is Scientific Linux 7 (SL7), see [http://www.scientificlinux.org/](http://www.scientificlinux.org/), also /usr/share/doc/HTML/en-US/index.html,
