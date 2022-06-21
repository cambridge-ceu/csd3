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

This requires a token to be set up.

## Download Agent

See [dx-download-agent](https://github.com/dnanexus/dxda/blob/master/README.md) and [releases](https://github.com/dnanexus/dxda/releases).

## dxCompiler

See [https://github.com/dnanexus/dxCompiler/](https://github.com/dnanexus/dxCompiler/) for [releases](https://github.com/dnanexus/dxCompiler/releases).

It will compile workflows in WDL, [https://github.com/openwdl/wdl](https://github.com/openwdl/wdl) with example in [https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md](https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md).
