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
module load rhel7/default-peta4
```

Our module list is now

```
  1) dot                            5) singularity/current            9) intel/impi/2017.4/intel       13) intel/libs/daal/2017.4
  2) slurm                          6) rhel7/global                  10) intel/libs/idb/2017.4         14) intel/bundles/complib/2017.4
  3) turbovnc/2.0.1                 7) intel/compilers/2017.4        11) intel/libs/tbb/2017.4         15) cmake/latest
  4) vgl/2.5.1/64                   8) intel/mkl/2017.4              12) intel/libs/ipp/2017.4         16) rhel7/default-peta4
```

Finally, with icelake we have

```
Currently Loaded Modulefiles:
 1) dot                   4) rhel8/global             7) intel/mkl/2020.2         10) intel/libs/tbb/2020.2   13) intel/bundles/complib/2020.2
 2) rhel8/slurm           5) cuda/11.4                8) intel/impi/2020.2/intel  11) intel/libs/ipp/2020.2   14) rhel8/default-icl
 3) singularity/current   6) intel/compilers/2020.2   9) intel/libs/idb/2020.2    12) intel/libs/daal/2020.2
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

It is useful to note that it is preferable to put an alias

```
alias ssh='ssh -q -X $@'
```

into `${HOME}/.bashrc` in case a remote login is necessary (e.g., faster login to CSD3 or there is poor local network connection).

---

The following information is helpful, [https://www.scm.com/doc/Installation/Remote_GUI.html](https://www.scm.com/doc/Installation/Remote_GUI.html)

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

[^1]: Applications such as R/nloptr package require to be recompiled. In this case, we run `download.packages("nloptr",".")` inside `R` on an Internet-enabled node and compile the package with `R CMD INSTALL nloptr_1.2.2.3.tar.gz`, say.
[^2]: This appears subject to the system setup.