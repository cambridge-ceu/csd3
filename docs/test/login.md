---
sort: 2
---

Possible login nodes on csd3 are: login.hpc, login-cpu.hpc, login-gpu.hpc, login-gfx.hpc, login-e-N.hpc.

To reset Raven password, follow https://password.csx.cam.ac.uk/.

To establish host keys one resort to `ssh-keygen`; the easiest is to accept the default.

The CSD3 hostkeys are described here, https://docs.hpc.cam.ac.uk/hpc/user-guide/hostkeys.html. From 1st February 2020, the following script needs to be run
from a local machine,

```bash
cp ~/.ssh/known_hosts ~/.ssh/known_hosts.`date +%F`
sed -i -e '/128\.232\.224/d' -e '/.*\.hpc\.cam\.ac\.uk/d' ~/.ssh/known_hosts
# to remove the entry, try:
# ssh-keygen -f "/home/$USER/.ssh/known_hosts" -R "login.hpc.cam.ac.uk"
```

Automatic login via ssh/sftp can be enabled with

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

Environmental variables can be set inside `~/.bashrc`. When there is an error `'abrt-cli status' timed out`, one should remove ${HOME}/.cache and relogin/source .bashrc.
