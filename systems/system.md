---
sort: 1
---

# System

The [Research Computing Services](https://www.csd3.cam.ac.uk/) provies an excellent [documentation](https://docs.hpc.cam.ac.uk/hpc/) besides [other services](https://www.hpc.cam.ac.uk/).
Here some aspects are highlighted from the perspectives of the [Cardiovascular Epidemiology Unit](https://www.phpc.cam.ac.uk/ceu/) (CEU), where all information about procedures and access requests can be found from **W:\Administration\CSD3 Data Users\Information for Users**.

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

On icelake, we have from `lsb_release -a`

```
LSB Version:	:core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
Distributor ID:	Rocky
Description:	Rocky Linux release 8.5 (Green Obsidian)
Release:	8.5
Codename:	GreenObsidian
```

For additional information regarding Scientific Linux and CentOS, see [https://en.wikipedia.org/wiki/Scientific_Linux](https://en.wikipedia.org/wiki/Scientific_Linux).
