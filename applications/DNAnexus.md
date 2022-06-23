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
source py37/bin/activate
pip install dxpy
eval "$(register-python-argcomplete dx|sed 's/-o default//')"
export PYTHONIOENCODING=UTF-8
pip install --upgrade dxpy
dx help ls
```

using the Python virtual environment at `py37/`, say[^1]. Once this is done, subsequent calls are simplified as

```bash
module load python/3.7
source py37/bin/activate
dx help ls
```

> It is not unusual to have version compatibility issues, so doing this ahead of time is helpful for you. For issues, please contact Customer Care at support@dnanexus.com for help with installation.

## Download Agent

See [dx-download-agent](https://github.com/dnanexus/dxda/blob/master/README.md) and [releases](https://github.com/dnanexus/dxda/releases).

```bash
export HPC_WORK=rds/user/$USER/hpc-work
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

where `create_manifest.py` is used to obtain a bz2-compressed JSON manifest file (`manifest.json.bz2`) whereas the last command shows the contents of the file to the terminal.

The file thus obtained is used with a DNAnexus API token[^2] as contained in `~/doc/nexus` here.

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
# This will make it visible from ${HPC_WORK}/bin
ln -sf ${PWD}/ua ${HPC_WORK}/bin/ua
```

## dxCompiler

See [https://github.com/dnanexus/dxCompiler/](https://github.com/dnanexus/dxCompiler/) for [releases](https://github.com/dnanexus/dxCompiler/releases).

It will compile workflows in WDL, [https://github.com/openwdl/wdl](https://github.com/openwdl/wdl) with example in [https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md](https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md).

We can get it as follows,

```bash
wget https://github.com/dnanexus/dxCompiler/releases/download/2.10.2/dxCompiler-2.10.2.jar
java -jar dxCompiler-2.10.2.jar
```

## dx-toolkit

GitHub: [https://github.com/dnanexus/dx-toolkit](https://github.com/dnanexus/dx-toolkit)

This installs API language bindings for R, C++ and Python 2.7.

```bash
module load gcc/6 texlive python/2.7
wget -qO- https://dnanexus-sdk.s3.amazonaws.com/dx-toolkit-v0.320.0-centos-amd64.tar.gz | \
tar xvfz -
cd dx-toolkit && source environment
dx upgrade
```

and `dx upgrade v0.225.0` returns to the previous version. A separate repository is available for JavaScript, [https://github.com/dnanexus/dx-javascript-toolkit](https://github.com/dnanexus/dx-javascript-toolkit).

As before, once this is done subsequent preparation for various apps in the toolkit is simplified as

```bash
module load gcc/6 texlive python/2.7
cd dx-toolkit && source environment
```

---

[^1]: A summary of all commands is available from [https://documentation.dnanexus.com/user/helpstrings-of-sdk-command-line-utilities](https://documentation.dnanexus.com/user/helpstrings-of-sdk-command-line-utilities).
[^2]:
    Instead of the `dx login` and `dx logout` pair one can login with a token, i.e.,

    > ```bash
    > dx login --token $(cat ~/doc/nexus)
    > dx select --level VIEW`
    > ```
    >
    > The `--noprojects` option allows for non-interactive login. The `dx select` command allows for specific projects be selected. See also [https://documentation.dnanexus.com/user/login-and-logout](https://documentation.dnanexus.com/user/login-and-logout).
