---
sort: 14
---

# QEMU

Web: <https://www.qemu.org/>

QCOW2 is a storage format for virtual disks. QCOW stands for QEMU copy-on-write.

## Ubuntu

Web: <https://cloud-images.ubuntu.com/noble/current/>

```bash
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
module load ceuadmin/qemu
qemu-img convert -f qcow2 -O qcow2 noble-server-cloudimg-amd64.img ubuntu-24.04.qcow2
qemu-img resize ubuntu-24.04.qcow2 +10G
export LIBGUESTFS_BACKEND=direct
virt-customize -a ubuntu-24.04.qcow2 \
  --mkdir /home/jhz22 \
  --mkdir /root \
  --chmod 0700:/root \
  --run-command 'useradd -m -G sudo -s /bin/bash jhz22' \
  --run-command "echo 'jhz22:passwd' | chpasswd" \
  --run-command 'apt-get update && apt-get install -y e2fsprogs grub-pc'
# virt-rescue -a ubuntu-24.04.qcow2
# fsck /dev/sda1
virt-customize -a ubuntu-24.04.qcow2 --run-command 'grub-install /dev/sda'
virt-customize -a ubuntu-24.04.qcow2 --run-command 'update-grub'
qemu-system-x86_64 \
  -m 2048 \
  -cpu qemu64 \
  -smp 2 \
  -drive file=ubuntu-24.04.qcow2,format=qcow2,cache=writeback \
  -nographic \
  -serial mon:stdio \
  -d guest_errors \
  -no-fd-bootchk

# VDI
qemu-img convert -O vdi ubuntu-24.04-minimal-cloudimg-amd64.img disk.vdi
```

## CentOS

Web: <https://cloud.centos.org/centos/8/x86_64/images/>

As noted at <https://access.redhat.com/solutions/641193>.

> For use in a KVM/QEMU hypervisor on a Red Hat Enterprise Linux machine, one must set a root password and disable the cloud-init service.
> One then may import the QCOW2 image using the `virt-manager` graphical user interface or the `virt-install` text command.

```bash
module load ceuadmin/qemu
wget https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2
cp -p CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2 CentOS-8.qcow2
virt-customize -a CentOS-8.qcow2 -root-password password:passwd --uninstall cloud-init
export LIBGUESTFS_DEBUG=1 LIBGUESTFS_TRACE=1
qemu-system-x86_64 -m 2048 -cpu qemu64 -smp 2 -drive file=CentOS-8.qcow2,format=qcow2,cache=writeback -nographic
# login as root
# userdel -r jhz22
# useradd -m -s /bin/bash jhz22
# echo 'se22_0jy' | passwd jhz22 --stdin
# hostname
# ssh jhz22@`hostname`
```

Ignition is a provisioning utility primarily used in CoreOS and similar operating systems for setting up system configurations
during the boot process. An example is as follows,

```
export src=/rds/project/rds-4o5vpvAowP0/software
export fedora=fedora-coreos-39.20231101.3.0-qemu.x86_64.qcow2
export qcow2_passwd=$(cat ${HOME}/doc/fedora_passwd)

wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/39.20231101.3.0/x86_64/$fedora.xz
xz -d fedora-coreos-39.20231101.3.0-qemu.x86_64.qcow2.xz

virt-manager --version
qemu-img info ${src}/${fedora}
virt-filesystems -a ${src}/${fedora} --all --long -h
virt-customize -a ${src}/${fedora} --root-password password:${qcow2_passwd} --uninstall cloud-init
qemu-system-x86_64 \
  -m 2048 \
  -cpu qemu64 \
  -smp 2 \
  -drive file=${src}/${fedora},format=qcow2 \
  -fw_cfg name=opt/com.coreos/config,file=ignition.json
```

with `ignition.json` being

```json
{
  "ignition": {
    "version": "3.1.0"
  },
  "passwd": {
    "users": [
      {
        "name": "root",
        "passwordHash": "$6$rounds=4096$...$..."
      }
    ]
  },
  "systemd": {
    "units": [
      {
        "name": "cloud-init.service",
        "mask": true
      }
    ]
  }
}
```

## Linux kernel

The Linux Kernel Archives, <https://www.kernel.org/> ([4.x](https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/))

The latest as of 17/7/2024 is 6.1. On icelake, `uname -r` shows `4.18.0-477.51.1.el8_8.x86_64`.

```bash
wget -qO- https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/linux-4.18.tar.gz | tar xvfz -
cd linux-4.18
make menuconfig
make oldconfig  # Or make defconfig if you're starting fresh
make modules
make CFLAGS="-g" modules # debugging
make modules_install
sudo modprobe dm-mod
```

## libvirt (*incomplete*)

Web: <https://libvirt.org/> (<https://download.libvirt.org/>)

The `virt-manager` in libvirt 3.2.0 above still uses -no-hpet option which is no longer valid, so an update is sought.

```bash
wget -qO- https://download.libvirt.org/libvirt-4.6.0.tar.xz | tar xJf -
cd libvrit-4.6.0
configure --prefix=$CEUADMIN/libvirt/4.6.0 --with-storage-drivers=<path>
```

Additional work is necessary.

## Miscellaneous notes

This paragraph is concerned about encrypted and plain passwords,

```
# encrypted version, used as chpasswd -e or ignition
openssl passwd -6 -salt jhz22 $(cat ~/doc/qcow2_passwd) > /home/jhz22/doc/ubuntu_passwd
ubuntu_passwd=$(cat /home/jhz22/doc/ubuntu_passwd)
# plain version
export centos_passwd=~/doc/CentOS-8_passwd
chmod 600 ${centos_passwd}  # Secure the file
# virt-customize -a <VM> -c "useradd -m -s /bin/bash jhz22" \
#                -c "passwd jhz22 < ${centos_passwd}"
``

This following relates to DNS resolution where the Google public nameservers are used,

```
ping google.com
sudo nano /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
sudo nano /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu focal main restricted
deb http://archive.ubuntu.com/ubuntu focal-updates main restricted
deb http://archive.ubuntu.com/ubuntu focal universe
deb http://archive.ubuntu.com/ubuntu focal-updates universe
deb http://archive.ubuntu.com/ubuntu focal multiverse
deb http://archive.ubuntu.com/ubuntu focal-updates multiverse
deb http://archive.ubuntu.com/ubuntu focal-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu focal-security main restricted
deb http://security.ubuntu.com/ubuntu focal-security universe
deb http://security.ubuntu.com/ubuntu focal-security multiverse
sudo systemctl restart systemd-networkd
sudo nano /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    ens3:
      dhcp4: true
sudo netplan apply
ip addr show ens3
ping google.com
sudo apt update
sudo apt upgrade
```
