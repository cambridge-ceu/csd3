---
sort: 6
---

# Web browsing

Advantages of browsing local files as web pages over plain files include improved file formatting, multimedia integration, interactive
and dynamic navigation. Suppose for instance our directory contains a `README.md` (as in a GitHub repository) which can be converted to
`README.html` via `pandoc`, then we can browse our directory as files + web page with `README.html` (allowing for explicit file
download), or a web page when `index.html` is created as a symbolic link to `README.html` (files are invisible unless explicit links are
given inside).

To proceed, we first start the web service, which is simply done (through the default Python 3.6.8) as follows:

```bash
python3 -m http.server 8080 &
```

assuming port number 8080 is available, e.g. `lsof -i :8080` gives no output.

An almost equally simpler approach is also possible,

```bash
npm install -g http-server
http-server &
```

How to start /usr/bin/firefox is described here, <https://cambridge-ceu.github.io/csd3/applications/firefox.html>.

Several alternatives are described below.

## ceuadmin/firefox/60.5.1esr

A singularity get-around is possible with this,

```bash
module load ceuadmin/firefox/60.5.1esr
firefox &
```

On 7/9/2025, ceuadmin/firefox/nightly (143.0a1) starts browsing normally with MOZ_FORCE_DISABLE_E10S=1.

## Chrome

```bash
module load ceuadmin/chrome
chrome http://localhost:8080 &
```

## Chromium

We are then capable to work with `ceuadmin/chromium`:

```bash
module load ceuadmin/chromium
chrome http://localhost:8080 &
```

using profile at ~/.config/chromium.

It might be helpful to clear browse history when `chrome` is repeatedly used, or to start a new profile, e.g.,

```bash
chrome --user-data-dir=/tmp/jhz22 http://localhost:8080 &
```

## Microsoft Edge

This is also ready to use,

```bash
module load ceuadmin/edge
edge http://localhost:8080 &
```

where the customized `edge` works properly, unlike its aliases `microsoft-edge` and `microsoft-edge-stable`.

Note the profile is ~/.config/microsoft-edge, and the option `--user-data-dir` also applies since it is also based on Chromium.

## Cytoscape

This is an earlier attempt but somewhat clumsy.

```bash
module load ceuadmin/Cytoscape/3.9.1
Cytoscape &
```

using `Tools` --> `Open web page` for `http://127.0.0.1:8080`.

## Default browser(s)

A list of options is as follows,

```bash
xdg-settings --list
xdg-settings --manual
xdg-settings get default-web-browser
xdg-settings check default-web-browser firefox.desktop
xdg-settings set default-web-browser firefox.desktop
xdg-settings set default-web-browser chromium.desktop
xdg-settings set default-web-browser microsoft-edge.desktop
xdg-settings set default-web-browser google-chrome.desktop
```

System-wide and user-specific .desktop files are at `/usr/share/applications` and `~/.local/share/applications/`, respectively.

For Microsoft Edge above, we see `microsoft-edge.desktop`, and an attempt is made as follows,

```bash
export src=/usr/local/Cluster-Apps/ceuadmin/edge/130.0.2849.56-1/usr/share/applications/
export dest=~/.local/share/applications
cp ${src}/microsoft-edge.desktop ${dest}
cd ${dest}
sed -i "s|/usr/bin/microsoft-edge|${src}/microsoft-edge --no-sandbox|" ${dest}/microsoft.desktop
export XDG_CURRENT_DESKTOP=GNOME
xdg-settings set default-web-browser microsoft-edge.desktop
xdg-settings get default-web-browser
```

## Non-CSD3 browser(s)

This approach seems less problematic with `user-data-dir` mentioned above. We can again set up tunneling from CSD3 with

```bash
python3 -m http.server 8000 &
hostname
```

Once succeeded, we establish the connection elsewhere.

```bash
ssh -4 -L 8080:127.0.0.1:8000 -fN jhz22@${hostname}.hpc.cam.ac.uk
```

where hostname from CSD3 and ${hostname} have to be the same. We can then browse `http://127.0.0.1:8080`.

## Firefox (legacy)

The `firefox` browser available at `/usr/bin/firefox` is dysfunctional when started, many temporary files are generated which can be removed with

```bash
# only remove those dated on Dec 3:
ll -rt | grep "Dec  3" | awk '{print "rm -fr "$NF}' | bash
```

A close attempt is with [20.04.def](files/20.04.def) but remains problematic.

```bash
# firefox/136.0 (64-bit) as of 26/3/2025
singularity build 20.04.sif 20.04.def
singularity run --bind $HPC_WORK/work:/mnt/tmp 20.04.sif`
# A showcase of instance
singularity instance start 20.04.sif 20.04
singularity instance list
## quit with 'exit'
singularity shell instance://20.04
## exec take commands such as 'bash', 'ls', 'apt-get'
singularity exec instance://20.04 firefox
singularity instance stop 20.04
```

Alternatively, it can be added to an existing container as follows,

```bash
singularity pull docker://ubuntu:20.04
singularity build --fakeroot --sandbox ubuntu_20.04_sandbox/ ubuntu_20.04.sif
singularity shell --fakeroot --writable ubuntu_20.04_sandbox/
# export LANG=en_US.UTF-8
# export LANGUAGE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
# apt update
# apt install -y firefox
# exit
singularity exec ubuntu_20.04_sandbox/ /usr/bin/firefox
singularity build 20.04.sif ubuntu_20.04_sandbox/
singularity exec 20.04.sif /usr/bin/firefox
```
