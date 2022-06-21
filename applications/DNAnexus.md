---
sort: 14
---

# DNAnexus

Web: [https://www.dnanexus.com/partnerships/ukbiobank](https://www.dnanexus.com/partnerships/ukbiobank) ([WebUI](https://platform.dnanexus.com/login))

## Platform SDK

This follows documentation at [https://documentation.dnanexus.com/downloads](https://documentation.dnanexus.com/downloads)

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

using the Python virtual environment at `~/COVID-19/py37/bin/activate`, say.

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

## Upload Agent

```bash
wget -qO- https://dnanexus-sdk.s3.amazonaws.com/dnanexus-upload-agent-1.5.33-linux.tar.gz | \
tar xzf -
cd dnanexus-upload-agent-*-linux
ua
```

This requires a DNAnexus API token[^1] to be set up.

## Download Agent

See [dx-download-agent](https://github.com/dnanexus/dxda/blob/master/README.md) and [releases](https://github.com/dnanexus/dxda/releases).

```bash
cd ${HPC_WORK}/bin
wget https://github.com/dnanexus/dxda/releases/download/v0.5.9/dx-download-agent-linux -O dx-download-agent
chmod +x dx-download-agent
dx-download-agent --help
cd -
```

or from source,

```bash
wget https://github.com/dnanexus/dxda/archive/refs/tags/v0.5.9.tar.gz -O - | \
tar xvfz -
cd dxda-*
create_release.sh
```

It gets going with bz2-compressed JSON manifest file with the API token indicated.

```bash
export DX_API_TOKEN=$(cat ~/doc/nexus)
dx-download-agent download <BZ2-compressed JSON manifest file>
```

## dxCompiler

See [https://github.com/dnanexus/dxCompiler/](https://github.com/dnanexus/dxCompiler/) for [releases](https://github.com/dnanexus/dxCompiler/releases).

It will compile workflows in WDL, [https://github.com/openwdl/wdl](https://github.com/openwdl/wdl) with example in [https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md](https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md).

---

[^1]:
    Instead of the `dx login` and `dx logout` pair one can login with a token, try

    > ```bash
    > dx login --token $(cat ~/doc/nexus)
    > dx select --level VIEW`
    > ```
    >
    > The `--noprojects` option allows for non-interactive login. The `dx select` command allows for specific projects be selected. See also [https://documentation.dnanexus.com/user/login-and-logout](https://documentation.dnanexus.com/user/login-and-logout).
