---
sort: 3
---

# Login

:warning: MultiFactor Authentication (MFA) is mandatory on CSD3 and RCS Storage Services from 1st November 2022, [https://docs.hpc.cam.ac.uk/hpc/user-guide/mfa.html](https://docs.hpc.cam.ac.uk/hpc/user-guide/mfa.html).

A common form of MFA, two-factor authentication (2FA), is through Time-based One-Time Passwords (TOTP), [https://www.twilio.com/docs/glossary/totp](https://www.twilio.com/docs/glossary/totp).

<font color="red"><b>19/6/2024 Update</b></font>`login.hpc.cam.ac.uk` is now default to icelake ahead of the 30-6-2024 deadline.

## Login nodes

The CSD3 login address is `login.hpc.cam.ac.uk` with a mapping table[^cpu]

| Collective name                 | Node name     | Comments            |
| ------------------------------- | ------------- | ------------------- |
| login-cascadelake.hpc.cam.ac.uk | login-p-[1-4] | CentOS7[^cclake]    |
| login-cpu.hpc.cam.ac.uk         | login-p-[1-4] | CPU                 |
| login-gpu.hpc.cam.ac.uk         | login-e-[1-4] | GPU[^gpu]           |
| &nbsp;                          | gpu-r-[1-10]  | Visualisation Nodes |
| login-icelake.hpc.cam.ac.uk     | login-q-[1-4] | CentOS8[^icelake]   |

Additional information is available with `sinfo`, `scontrol show node` in the case of SLURM.

On a GPU, we have from `module list`

```bash
Currently Loaded Modulefiles:
  1) dot                                5) singularity/current                9) openmpi-1.10.7-gcc-5.4.0-jdc7f4f
  2) slurm                              6) rhel7/global                      10) cmake/latest
  3) turbovnc/2.0.1                     7) cuda/8.0                          11) rhel7/default-gpu
  4) vgl/2.5.1/64                       8) gcc-5.4.0-gcc-4.8.5-fis24gg
```

and can switch to a CPU environment with

```bash
module purge
module load rhel7/default-ccl
```

Our module list is now

```
urrently Loaded Modulefiles:
  1) dot                            5) singularity/current            9) intel/impi/2020.2/intel       13) intel/libs/daal/2020.2
  2) slurm                          6) rhel7/global                  10) intel/libs/idb/2020.2         14) intel/bundles/complib/2020.2
  3) turbovnc/2.0.1                 7) intel/compilers/2020.2        11) intel/libs/tbb/2020.2         15) cmake/latest
  4) vgl/2.5.1/64                   8) intel/mkl/2020.2              12) intel/libs/ipp/2020.2         16) rhel7/default-ccl
```

Finally, with icelake we have

```
Currently Loaded Modulefiles:
 1) dot           3) singularity/current   5) cuda/11.4      7) intel-oneapi-compilers/2022.1.0/gcc/b6zld2mz   9) rhel8/default-icl
 2) rhel8/slurm   4) rhel8/global          6) vgl/2.5.1/64   8) intel-oneapi-mpi/2021.6.0/intel/guxuvcpm
```

and can be checked with

```
module purge
module load rhel8/default-icl
```

The quota is more readily seen as well,

```bash
quota
```

which for instance returns,

```
Filesystem/Project    GB        quota     limit   grace    files    quota    limit   grace User/Grp/Proj
/home                 39.5       42.9      42.9       -    ----- No ZFS File Quotas  ----- U:jhz22
/rds-d2             4479.7        0.0       0.0       -   140409        0        0       - gid
/rds-d4              705.2     1099.5    1209.5       -   955270  1048576  1048576       - G:jhz22
/rds-d2                0.0        0.0       0.0       -        1        0        0       - gid
/rds-d2                0.0        0.0       0.0       -        3        0        0       - gid
/rds-d2                0.0    54975.6   54975.6       -       39 26214400 26214400       - G:rds-jmmh2-legacy_projects
/rds-d2                0.2    60000.0   60000.0       -      275 30720000 30720000       - G:rds-jmmh2-pre_qc_data
/rds-d2             1388.3   109951.2  109951.2       -     5559 52428800 52428800       - G:rds-jmmh2-hes_data
/rds-d2           161532.6   164926.7  164926.7       - 43733950 78643200 78643200       - G:rds-jmmh2-projects
/rds-d2            17636.9   109951.2  109951.2       -  1237895 52428800 52428800       - G:rds-jmmh2-results
/rds-d2            22135.5   109951.2  109951.2       -   681325 52428800 52428800       - G:rds-jmmh2-post_qc_data
/rds-d2                2.7   109951.2  109951.2       -      238 52428800 52428800       - G:rds-jmmh2-genetics_resources
/rds-d2            38909.4   109951.2  109951.2       -   673476 52428800 52428800       - G:rds-jmmh2-public_databases
/rds-d4                0.0        0.0       0.0       -        5        0        0       - gid
/rds-d4                0.2        0.0       0.0       -        5        0        0       - gid
/rds-d4                1.3        0.0       0.0       -       74        0        0       - gid
/rds-d5                0.0        0.0       0.0       -        1        0        0       - gid
rds-MkfvQMuSUxk    63558.5   100000.0  100000.0       -  1373767 51200000 51200000       - P:90608
```

To reset Raven password, follow [https://password.csx.cam.ac.uk/](https://password.csx.cam.ac.uk/).

## Host keys

To establish host keys one resorts to `ssh-keygen`; the easiest is to accept the default.

The CSD3 hostkeys are described here, [https://docs.hpc.cam.ac.uk/hpc/user-guide/hostkeys.html](https://docs.hpc.cam.ac.uk/hpc/user-guide/hostkeys.html). From 1st February 2020, the following script needs to be run
from a local machine,

```bash
cp ~/.ssh/known_hosts ~/.ssh/known_hosts.`date +%F`
sed -i -e '/128\.232\.224/d' -e '/.*\.hpc\.cam\.ac\.uk/d' ~/.ssh/known_hosts
# to remove the entry, try:
# ssh-keygen -f "/home/$USER/.ssh/known_hosts" -R "login.hpc.cam.ac.uk"
```

Automatic login[^autologin] via ssh/sftp can be enabled with

```bash
ssh-copy-id login.hpc.cam.ac.uk
```

from a Bash console after one login.

If this is not set up, e.g., with error message `/usr/bin/ssh-copy-id: ERROR: No identities found`, follow these steps,

```bash
ssh-keygen
# Enter file in which to save the key (/home/$USER/.ssh/id_rsa): mykey
# Enter passphrase (empty for no passphrase):
# Enter same passphrase again:
# Your identification has been saved in mykey.
# Your public key has been saved in mykey.pub.
The key fingerprint is:
ssh-copy-id -i ~/.ssh/mykey.pub login.hpc.cam.ac.uk
```

as in [https://www.ssh.com/ssh/copy-id](https://www.ssh.com/ssh/copy-id). At a specific host, try

```bash
mkdir .ssh
chmod 700 .ssh
ssh-keygen
cd .ssh
chmod 700 mykey*
touch authorized_keys
chmod 700 authorized_keys
ssh-copy-id -i mykey.pub user@remoteserver
```

Environmental variables can be set inside `~/.bashrc`. In particular when some changes have been made, one can enable them with

```bash
source ~/.bashrc
```

where the `~` sign is equivalent to ${HOME}.

When there is an error `'abrt-cli status' timed out`, one should remove ${HOME}/.cache and relogin/source .bashrc.

It is useful to note that it is preferable to put an alias

```
alias ssh='ssh -q -X $@'
```

into `${HOME}/.bashrc` in case a remote login is necessary (e.g., faster login to CSD3 or there is poor local network connection).

---

The following information is helpful, [https://www.scm.com/doc/Installation/Remote_GUI.html](https://www.scm.com/doc/Installation/Remote_GUI.html)

## Login-Web Interface

Address: <https://login-web.hpc.cam.ac.uk/> ([User Guide](https://docs.hpc.cam.ac.uk/hpc/user-guide/login-web.html))

## sftp

The two ethernet SFTP gateways are rds.hpc.cam.ac.uk and rcs.hpc.cam.ac.uk.

## Using the GUI on a remote machine

### X11 over SSH

```bash
ssh -X -Y CRSid@login.hpc.cam.ac.uk
xclock
```

### X11 with OpenGL over SSH (3D graphics)

```bash
glxgears
glxinfo | grep -E "version|string|rendering|display"
ldd `which glxinfo`
ls -l /usr/lib64/libGL.so.1
find /usr -iname "*libGL.so*" -exec ls -l {} \;
find /usr -iname "*libGLX*.so*" -exec ls -l {} \;
```

[^cpu]: **cpu**

    login-skylake.hpc.cam.ac.uk, namely login-e-[9-16], is removed on 25-26/7/2023 and is replaced with `login-cascadelake`.

[^cclake]: **cclake**

    see footnote[^cpu] above and some capacity is due to retire after 30 June 2024.

[^gpu]: **gpu**

    Currently, it is login-e-[1-4] (login.hpc), login-e-1 is also the license server. The so-called 3D viz/startgfx nodes are login-gpu-e-[1-7].

    They will be retired, and `login-gpu.hpc.cam.ac.uk`  will be redistributed to login-q nodes.

[^icelake]: **icelake**

    Applications such as R/nloptr package require to be recompiled. In this case, we run `download.packages("nloptr",".")` inside `R` on an Internet-enabled node and compile the package with `R CMD INSTALL nloptr_1.2.2.3.tar.gz`, say.

    On icelake, we could emulate lynx-style web browser with syntax such as `xfce4-terminal -x /usr/bin/links https://www.bbc.co.uk &`.

[^autologin]: **autologin**

    This appears subject to the system setup.
