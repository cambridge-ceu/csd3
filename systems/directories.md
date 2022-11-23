---
sort: 5
---

# Directories

## Users

This [section](https://docs.hpc.cam.ac.uk/hpc/user-guide/io_management.html#summary-of-available-filesystems) gives a summary of the file system.

Go to **CSD3 portal**: [https://selfservice.uis.cam.ac.uk/account/](https://selfservice.uis.cam.ac.uk/account/) and accept the terms and conditions. An `rds/` directory should then be created with symbolic links as follows,

```
hpc-work -> /rds/user/$USER/hpc-work/
genetics_resources -> /rds/project/jmmh2/rds-jmmh2-genetics_resources/
legacy_projects -> /rds/project/jmmh2/rds-jmmh2-legacy_projects/
pre_qc_data -> /rds/project/jmmh2/rds-jmmh2-pre_qc_data/
projects -> /rds/project/jmmh2/rds-jmmh2-projects/
public_databases -> /rds/project/jmmh2/rds-jmmh2-public_databases/
results -> /rds/project/jmmh2/rds-jmmh2-results
```

Short shorter (without rds-jmmh2- prefix) names as on Cardio can be created equivalently with

```bash
if [ ! -d /home/$USER/rds ]; then mkdir /home/$USER/rds; fi
ln -sf /rds/user/$USER/hpc-work /home/$USER/rds/hpc-work
export rt=/rds/project/jmmh2
for d in $(ls $rt | xargs -l basename | sed 's/rds-jmmh2-//g'); do ln -sf $rt/rds-jmmh2-$d /home/$USER/rds/$d; done
```

Note to list the directories you need postfix them with '/'.

## Data managers

In the case of [Hospital Episode Statistics](https://digital.nhs.uk/data-and-information/data-tools-and-services/data-services/hospital-episode-statistics) (HES) data, add users from [https://selfservice.uis.cam.ac.uk/storage/project/306/](https://selfservice.uis.cam.ac.uk/storage/project/306/).

See also [https://www.golinuxcloud.com/setfacl-getfacl-command-in-linux/](https://www.golinuxcloud.com/setfacl-getfacl-command-in-linux/).
