---
sort: 2
---

# Login

The CSD3 login address is `login.hpc.cam.ac.uk` with a mapping table

| Collective name             | Node name      | Comments    |
| --------------------------- | -------------- | ----------- |
| login-gpu.hpc.cam.ac.uk     | login-e-[1-8]  | GPU         |
| login-cpu.hpc.cam.ac.uk     | login-e-[9-16] | CPU         |
| login-icelake.hpc.cam.ac.uk | login-q-[1-4]  | CentOS8[^1] |

With `module list` we have

```bash
Currently Loaded Modulefiles:
  1) dot                                5) singularity/current                9) openmpi-1.10.7-gcc-5.4.0-jdc7f4f
  2) slurm                              6) rhel7/global                      10) cmake/latest
  3) turbovnc/2.0.1                     7) cuda/8.0                          11) rhel7/default-gpu
  4) vgl/2.5.1/64                       8) gcc-5.4.0-gcc-4.8.5-fis24gg
```

and switch to the login-cpu environment with

```bash
module purge
module load rhel7/default-peta4
```

Our module list is now

```
  1) dot                            5) singularity/current            9) intel/impi/2017.4/intel       13) intel/libs/daal/2017.4
  2) slurm                          6) rhel7/global                  10) intel/libs/idb/2017.4         14) intel/bundles/complib/2017.4
  3) turbovnc/2.0.1                 7) intel/compilers/2017.4        11) intel/libs/tbb/2017.4         15) cmake/latest
  4) vgl/2.5.1/64                   8) intel/mkl/2017.4              12) intel/libs/ipp/2017.4         16) rhel7/default-peta4
```

To reset Raven password, follow [https://password.csx.cam.ac.uk/](https://password.csx.cam.ac.uk/).

To establish host keys one resorts to `ssh-keygen`; the easiest is to accept the default.

The CSD3 hostkeys are described here, [https://docs.hpc.cam.ac.uk/hpc/user-guide/hostkeys.html](https://docs.hpc.cam.ac.uk/hpc/user-guide/hostkeys.html). From 1st February 2020, the following script needs to be run
from a local machine,

```bash
cp ~/.ssh/known_hosts ~/.ssh/known_hosts.`date +%F`
sed -i -e '/128\.232\.224/d' -e '/.*\.hpc\.cam\.ac\.uk/d' ~/.ssh/known_hosts
# to remove the entry, try:
# ssh-keygen -f "/home/$USER/.ssh/known_hosts" -R "login.hpc.cam.ac.uk"
```

Automatic login[^2] via ssh/sftp can be enabled with

```bash
ssh-copy-id login.hpc.cam.ac.uk
```

from a Bash console after one login. If this is not set up, follow these steps,

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

[^1]: Applications may need to be recompiled.
[^2]: This appears subject to the system setup.
