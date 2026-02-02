---
sort: 58
---

# podman

(to be amended)

## 1. podman executable

```bash
wget -qO- https://github.com/containers/podman/releases/download/v5.1.1/podman-remote-static-linux_amd64.tar.gz | tar xvfz -
cd bin
ln -s podman-remote-static-linux_amd64 podman
echo "$USER:100000:65536" > $HOME/.subuid
echo "$USER:100000:65536" > $HOME/.subgid
cd ..
```

## 2. podman-helpers/ and containers/

```bash
# podman-helpers
mkdir podman-helpers && cd podman-helpers
wget https://github.com/containers/gvisor-tap-vsock/releases/download/v0.7.3/gvproxy-linux-amd64 -O gvproxy
chmod +x gvproxy
wget https://github.com/containers/fuse-overlayfs/releases/download/v1.14/fuse-overlayfs-x86_64
chmod +x fuse-overlayfs-x86_64
curl -o slirp4netns --fail -L https://github.com/rootless-containers/slirp4netns/releases/download/v1.3.1/slirp4netns-$(uname -m)
chmod +x slirp4netns
cd ..
# containers
mkdir containers
echo '[containers]' > containers/containers.conf
echo '[engine]' >> containers/containers.conf
echo 'helper_binaries_dir = "/home/jhz22/podman-helpers"' >> containers/containers.conf
echo 'events_logger = "file"' >> containers/containers.conf
ln -sf ${PWD}/containers $HOME/.config/containers
# podman
module load ceuadmin/qemu
pkill podman
podman system connection list
podman machine init
podman machine start
podman run quay.io/podman/hello
podman pull docker.io/library/hello-world
podman run --rm docker.io/library/hello-world
# additional notes
podman machine rm podman-machine-default
podman system connection add --default podman-machine-default ssh://core@127.0.0.1:39137/run/user/10024/podman/podman.sock
```
