---
sort: 19
---

# docker

(to be amended)

The module `docker/24.0.5` enables information such as command options to be available.

```bash
export folder=$CEUADMIN/docker/24.0.5
mkdir -p ${folder}
cd ${folder}
curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-24.0.5.tgz -o docker.tgz
tar xzvf docker.tgz --strip 1
export PATH=${folder}:$PATH
export DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock
# a normal run:
dockerd --experimental --rootless
systemctl --user enable docker
systemctl --user start docker
docker run hello-world
wget https://github.com/docker/compose/releases/download/v2.36.0/docker-compose-linux-x86_64 -O docker-compose
chmod +x docker-compose
```

A user-based set up of the rootless mode is necessary,

```bash
export mydocker=$CEUADMIN/docker/24.0.5
curl -fsSL https://raw.githubusercontent.com/docker/docker/master/contrib/dockerd-rootless-setuptool.sh \
     -o $mydocker/dockerd-rootless-setuptool.sh
chmod +x $mydocker/dockerd-rootless-setuptool.sh
curl -fsSL https://raw.githubusercontent.com/docker/docker/master/contrib/dockerd-rootless.sh \
     -o $mydocker/24.0.5/dockerd-rootless.sh
chmod +x $mydocker/dockerd-rootless.sh
wget -qO- https://github.com/rootless-containers/rootlesskit/releases/download/v2.1.0/rootlesskit-x86_64.tar.gz | \
tar xvfz -
echo "$USER:100000:65536" > ~/.subuid
echo "$USER:100000:65536" > ~/.subgid
export DOCKER_ROOTLESS_SUBUID=$(cat ~/.subuid)
export DOCKER_ROOTLESS_SUBGID=$(cat ~/.subgid)
${mydocker}/dockerd-rootless-setuptool.sh install
```

The process is modified slightly for the module. The use of ~/.subuid and ~/.subgid gets around the error messages,

```
########## BEGIN ##########
sudo sh -eux <<EOF
# Add subuid entry for jhz22
echo "jhz22:100000:65536" >> /etc/subuid
# Add subgid entry for jhz22
echo "jhz22:100000:65536" >> /etc/subgid
EOF
########## END ##########
```

One can check user and group id's with

```bash
id -u
id -g
```

e.g., `chmod 644 ~/.subuid ~/.subgid`.

In turned out considerably easier to get different distributions from <https://download.docker.com/linux/static/stable/x86_64/>.

