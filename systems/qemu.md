---
sort: 13
---

# QEMU (*experimental*)

 QCOW2 is a storage format for virtual disks. QCOW stands for QEMU copy-on-write.

## Ubuntu

Web: <https://cloud-images.ubuntu.com/noble/current/>

```bash
mv -i noble-server-cloudimg-amd64.img ubuntu-24-server.qcow2
qemu-img convert -f qcow2 -O qcow2 ubuntu-24-server.qcow2 root-disk.qcow2
qemu-img resize root-disk.qcow2 +10G
```

## CentOS

Web: <https://cloud.centos.org/centos/8/x86_64/images/>

The following is based on <https://access.redhat.com/solutions/641193>.

> For use in a KVM/QEMU hypervisor on a Red Hat Enterprise Linux machine, one must set a root password and disable the cloud-init service.
> One then may import the QCOW2 image using the `virt-manager` graphical user interface or the `virt-install` text command.

```bash
export src=/rds/project/rds-4o5vpvAowP0/software
export qcow2=CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2
export qcow2_passwd=$(cat ${HOME}/doc/qcow2_passwd)

module load ceuadmin/qemu
virt-manager --version
qemu-img info ${src}/${qcow2}
virt-filesystems -a ${src}/${qcow2} --all --long -h
virt-customize -a ${src}/${qcow2} --root-password password:${qcow2_passwd} --uninstall cloud-init
qemu-system-x86_64 -machine hpet=off -m 3G -drive file=${src}/${qcow2},format=qcow2
virt-install \
  --name fedora-39 \
  --memory 2048 \
  --vcpus 2 \
  --disk path=${src}/${qcow2},format=qcow2 \
  --import \
  --os-variant fedora-unknown
# debugging:
# virt-customize -v -x -a ${src}/${qcow2} --root-password password:${qcow2_passwd} --uninstall cloud-init
```

where `hped=off` disables High Precision Event Timer (HPET) from qemu 7.0 and later. Now we try

```
qemu-system-x86_64 \
  -m 2048 \
  -cpu qemu64 \
  -smp 2 \
  -drive file=${src}/${qcow2},format=qcow2 \
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
        "name": "core",
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

## libvirt

Web: <https://libvirt.org/> (<https://download.libvirt.org/>)

The `virt-manager` in libvirt 3.2.0 above still uses -no-hpet option which is no longer valid, so an update is sought.

```bash
wget -qO- https://download.libvirt.org/libvirt-4.6.0.tar.xz | tar xJf -
cd libvrit-4.6.0
configure --prefix=$CEUADMIN/libvirt/4.6.0 --with-storage-drivers=<path>
```