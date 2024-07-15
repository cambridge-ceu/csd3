---
sort: 13
---

# QEMU

Web: <https://access.redhat.com/solutions/641193>

> QCOW2 is a storage format for virtual disks. QCOW stands for QEMU copy-on-write.
> For use in a KVM/QEMU hypervisor on a Red Hat Enterprise Linux machine, one must set a root password and disable the cloud-init service.
> One then may import the QCOW2 image using the `virt-manager` graphical user interface or the `virt-install` text command.

```bash
export src=/rds/project/rds-4o5vpvAowP0/software
export qcow2=fedora-coreos-39.20231101.3.0-qemu.x86_64.qcow2
export qcow2_passwd=$(cat ${HOME}/doc/qcow2_passwd)

qemu-img info ${src}/${qcow2}
virt-filesystems -a ${src}/${qcow2} --all --long -h
virt-customize -a ${src}/${qcow2} --root-password password:${qcow2_passwd} --uninstall cloud-init
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

```
module load ceuadmin/qemu
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
