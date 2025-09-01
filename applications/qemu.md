---
sort: 56
---

# qemu

Web: <https://www.qemu.org/>

## Installation

This is done as follows,

```bash
export prefix=$CEUADMIN/qemu/
export ENV_DIR=$prefix/venv
mkdir build && cd build
module load python/3.8.11/gcc/pqdmnzmw
python -m venv --system-site-packages ${ENV_DIR}
source $prefix/venv/bin/activate
pip install --prefix=${ENV_DIR} sphinx
pip install --prefix=${ENV_DIR} sphinx_rtd_theme==1.1.1
pip install --prefix=${ENV_DIR} ninja
wget -qO- https://download.qemu.org/qemu-9.0.1.tar.xz | \
tar vxJf -
cd qemu-9.0.1
module load ncurses/6.2/gcc/givuz2aq libidn2/2.3.0/gcc/ph36ygoa
module load gettext/0.21/gcc/qnrcglqo
module load ceuadmin/gnutls/3.8.4-icelake ceuadmin/nettle/3.9-icelake ceuadmin/krb5/1.21.2-icelake
export gettext=/usr/local/software/spack/spack-views/rhel8-icelake-20211027_2/gettext-0.21/gcc-11.2.0/qnrcglqov5au2zv56tumhhf4n6mds34n
../configure --prefix=$prefix/9.0.1\
             --target-list=x86_64-softmmu \
             --extra-ldflags="-L4gettext -lintl" \
             --extra-cflags="-I$gettext/include"
make -j4
make install
```

Without the `--taget-list` option all will be built.

## Examples

See <https://github.com/guillem-riera/podman-machine-x86_64>

```bash
export EXTRA_ARGS=${EXTRA_ARGS:-$@}
## Fedora CoreOS image for x86_64 (QEMU)
export PODMAN_X86_64_MACHINE_NAME=${PODMAN_X86_64_MACHINE_NAME:-x86_64}
export PODMAN_X86_64_MACHINE_NAME_EXISTS=$(podman machine list | grep ${PODMAN_X86_64_MACHINE_NAME} | wc -l | tr -d '[:space:]')
export PODMAN_QEMU_IMAGE="fedora-coreos-39.20231101.3.0-qemu.x86_64.qcow2.xz"
export DOWNLOAD_DIR=${DOWNLOAD_DIR:-.}
if [ ${PODMAN_X86_64_MACHINE_NAME_EXISTS} -lt 1 ]; then
    curl -C- -O "https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/39.20231101.3.0/x86_64/${PODMAN_QEMU_IMAGE}"
    podman machine init --image ${DOWNLOAD_DIR}/${PODMAN_QEMU_IMAGE} ${PODMAN_X86_64_MACHINE_NAME} ${EXTRA_ARGS}
else
    echo "[Info] Machine ${PODMAN_X86_64_MACHINE_NAME} already exists. If you want to recreate it, run 'podman machine rm ${PODMAN_X86_64_MACHINE_NAME}'"
fi
podman machine list
lsmod
## TCG (Tiny Code Generator)
xz -d ${PODMAN_QEMU_IMAGE}
qemu-system-x86_64 -m 2048 -cpu qemu64 -smp 2 -drive file=fedora-coreos-39.20231101.3.0-qemu.x86_64.qcow2,format=qcow2 -accel tcg
## Change machine settings
### Get the machine config file name
machineConfigFile="$(podman machine inspect ${PODMAN_X86_64_MACHINE_NAME} | jq -r '.[].ConfigPath.Path')"
### https://docs.openstack.org/image-guide/obtain-images.html
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
qemu-system-x86_64 -m 2048 -cpu qemu64 -smp 2 -drive file=noble-server-cloudimg-amd64.img,format=qcow2 -accel tcg
### No GUI
qemu-system-x86_64 -m 2048 -cpu qemu64 -smp 2 -drive file=fedora-coreos-39.20231101.3.0-qemu.x86_64.qcow2,format=qcow2,cache=writeback -nographic
```

where `format=raw` appears considerably faster but can make the image less flexible (e.g., no snapshots).
