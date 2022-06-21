---
sort: 14
---

# DNAnexus

Web: [https://www.dnanexus.com/partnerships/ukbiobank](https://www.dnanexus.com/partnerships/ukbiobank) ([WebUI](https://platform.dnanexus.com/login))

## Platform SDK

This follows [https://documentation.dnanexus.com/downloads](https://documentation.dnanexus.com/downloads),

```bash
module avail python
module load python/3.7
source ~/COVID-19/py37/bin/activate
pip install dxpy
eval "$(register-python-argcomplete dx|sed 's/-o default//')"
export PYTHONIOENCODING=UTF-8
pip install --upgrade dxpy
dx help ls
```

using the Python virtual environment at `~/COVID-19/py37/`, say.

## Download Agent

See [dx-download-agent](https://github.com/dnanexus/dxda/blob/master/README.md) and [releases](https://github.com/dnanexus/dxda/releases).

```bash
cd ${HPC_WORK}/bin
wget https://github.com/dnanexus/dxda/releases/download/v0.5.9/dx-download-agent-linux -O dx-download-agent
chmod +x dx-download-agent
dx-download-agent --help
cd -
```

A number of utilities are available from the source,

```bash
wget https://github.com/dnanexus/dxda/archive/refs/tags/v0.5.9.tar.gz -O - | \
tar xvfz -
cd dxda-*
python scripts/create_manifest.py "project-G8pGb82KjVGq8bZ053jkKqQ5:/Users/Jing Hua" --recursive --output_file "manifest.json.bz2"
bzip2 -d -c manifest.json.bz2
```

where `create_manifest.py` is used to obtain a bz2-compressed JSON manifest (`manifest.json.bz2`) file whereas the last command shows the contents of the file to the terminal.

The file thus obtained is used with a DNAnexus API token[^1].

```bash
export DX_API_TOKEN=$(cat ~/doc/nexus)
dx-download-agent download manifest.json.bz2
```

## Upload Agent

```bash
wget -qO- https://dnanexus-sdk.s3.amazonaws.com/dnanexus-upload-agent-1.5.33-linux.tar.gz | \
tar xzf -
cd dnanexus-upload-agent-*-linux
ua
```

## dxCompiler

See [https://github.com/dnanexus/dxCompiler/](https://github.com/dnanexus/dxCompiler/) for [releases](https://github.com/dnanexus/dxCompiler/releases).

It will compile workflows in WDL, [https://github.com/openwdl/wdl](https://github.com/openwdl/wdl) with example in [https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md](https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md).

## dx-toolkit

GitHub: [https://github.com/dnanexus/dx-toolkit](https://github.com/dnanexus/dx-toolkit)

This installs R, C++ and Python 2.7.

```bash
wget -qO- https://dnanexus-sdk.s3.amazonaws.com/dx-toolkit-v0.320.0-centos-amd64.tar.gz | \
tar xvfz -
cd dx-toolkit && source environment
dx upgrade
```

and `dx upgrade v0.225.0` returns to the previous version.

---

[^1]:
    Instead of the `dx login` and `dx logout` pair one can login with a token, try

    > ```bash
    > dx login --token $(cat ~/doc/nexus)
    > dx select --level VIEW`
    > ```
    >
    > The `--noprojects` option allows for non-interactive login. The `dx select` command allows for specific projects be selected. See also [https://documentation.dnanexus.com/user/login-and-logout](https://documentation.dnanexus.com/user/login-and-logout).
