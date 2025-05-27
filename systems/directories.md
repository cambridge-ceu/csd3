---
sort: 4
---

# Directories

## Users

This [section](https://docs.hpc.cam.ac.uk/hpc/user-guide/io_management.html#summary-of-available-filesystems) gives a summary of the file system.

Go to **CSD3 portal**: <https://selfservice.uis.cam.ac.uk/account/> and accept the terms and conditions. An `rds/` directory should then be created with symbolic links as follows,

```
hpc-work -> /rds/user/$USER/hpc-work/
genetics_resources -> /rds/project/jmmh2/rds-jmmh2-genetics_resources/
legacy_projects -> /rds/project/jmmh2/rds-jmmh2-legacy_projects/
post_qc_data -> /rds/project/jmmh2/rds-jmmh2-post_qc_data/
pre_qc_data -> /rds/project/jmmh2/rds-jmmh2-pre_qc_data/
projects -> /rds/project/jmmh2/rds-jmmh2-projects/
public_databases -> /rds/project/jmmh2/rds-jmmh2-public_databases/
results -> /rds/project/jmmh2/rds-jmmh2-results
software -> /rds/project/jmmh2/rds-jmmh2-public_databases/software/
```

Short shorter (without rds-jmmh2- prefix) names as on Cardio can be created equivalently with

```bash
if [ ! -d /home/$USER/rds ]; then mkdir /home/$USER/rds; fi
ln -sf /rds/user/$USER/hpc-work /home/$USER/rds/hpc-work
export rt=/rds/project/jmmh2
for d in $(ls $rt | xargs -l basename | sed 's/rds-jmmh2-//g'); do ln -sf $rt/rds-jmmh2-$d /home/$USER/rds/$d; done
```

Note to list the directories you need postfix them with '/'.

On 7/5/2024, the symbolic links to the new location of data storage are as follows,

```
rds-jmmh2-genetics_resources -> /rds/project/rds-5WRcpwFaaWc/
rds-jmmh2-hes_data -> /rds/project/rds-fsbcZmj92Ko/
rds-jmmh2-legacy_projects -> /rds/project/rds-iH9xqwiahLo/
rds-jmmh2-post_qc_data -> /rds/project/rds-pNR2rM6BWWA/
rds-jmmh2-pre_qc_data -> /rds/project/rds-MkfvQMuSUxk/
rds-jmmh2-projects -> /rds/project/rds-zuZwCZMsS0w/
rds-jmmh2-public_databases -> /rds/project/rds-4o5vpvAowP0/
rds-jmmh2-results -> /rds/project/rds-C1Ph08tkaOA/
```

See "W:\Administration\CSD3 Data Users\Information for Users".

## Data managers

Self-service storage, <https://selfservice.uis.cam.ac.uk/storage/project/303/>.

In the case of [Hospital Episode Statistics](https://digital.nhs.uk/data-and-information/data-tools-and-services/data-services/hospital-episode-statistics) (HES) data, add users from [https://selfservice.uis.cam.ac.uk/storage/project/306/](https://selfservice.uis.cam.ac.uk/storage/project/306/).

See also

- CEU, "W:\Administration\CSD3 Data Users\CSD3Datamanagement_only"
  - SOPs, SOPs
    - Guide to CSD3 data management.docx
    - Guide to CSD3.docx
  - audit, Access Audits\Programmes\CSD3 audit usergroup mappings\audit.R"
- External links
  - <https://www.golinuxcloud.com/setfacl-getfacl-command-in-linux/>.
  - <https://www.baeldung.com/linux/public-key-known_hosts>.

## Cluster monitoring

See "V:\Operations\GENERAL_CEU\CSD3\monitoring CSD3 usage".

### Access

- sftp, [sftp [crsid]@data-vhpc.srcp.hpc.cam.ac.uk](sftp [crsid]@data-vhpc.srcp.hpc.cam.ac.uk)
- vHPC, <https://vhpc.srcp.hpc.cam.ac.uk> (Raven login followed by OTP/2FA)
