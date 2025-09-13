---
sort: 21
---

# DNAnexus

Web: <https://www.dnanexus.com/> ([documentation](https://documentation.dnanexus.com/), [WebUI](https://platform.dnanexus.com/login)), [YouTube](https://www.youtube.com/@Dnanexus/playlists)

UKBioBank: [landing](https://ukbiobank.dnanexus.com/landing), [partnership](https://www.dnanexus.com/partnerships/ukbiobank)

Organisation: <https://documentation.dnanexus.com/getting-started/key-concepts/organizations> and [Member Guide](https://documentation.dnanexus.com/user/organization-member-guide)

## Platform SDK

This follows <https://documentation.dnanexus.com/downloads>.

📌 **Note**: To facilitate a raining courses by DNAnexus, the resource is made available for CEU users[^csd3] so users can jump to usage.

### Python virual environment

This creates a virtual environment at `py3.7/`,

```bash
module avail python
module load python/3.7
python -m venv ~/rds/software/py3.7
```

This only needs to be done once.

### Package installation

Once the virtual environment is available, we can install the relevant package as follows,

```bash
source ~/rds/software/py3.7/bin/activate
pip install dxpy
eval "$(register-python-argcomplete dx|sed 's/-o default//')"
export PYTHONIOENCODING=UTF-8
pip install --upgrade dxpy
```

### Usage

Some dx commands are shown here,

```bash
# only one option is sufficient
# 1. environment from above
source ~/rds/software/py3.7/bin/activate
# 2. environment from the the CEU training course
source /rds/project/rds-zuZwCZMsS0w/olink_proteomics/scallop/py37/bin/activate

dx help ls
dx login
dx upload -r
dx logout
```

Login can be conveniently done via a token[^token], as from <https://documentation.dnanexus.com/user/login-and-logout>.

Some materials from training at CEU by DNAnexus are also kept here[^DNAnexus].

> It is not unusual to have version compatibility issues, so doing this ahead of time is helpful for you. For issues, please contact Customer Care at [support@dnanexus.com](mailto:support@dnanexus.com) for help with installation.

## Download Agent

See [dx-download-agent](https://github.com/dnanexus/dxda/blob/master/README.md) and [releases](https://github.com/dnanexus/dxda/releases).

```bash
export HPC_WORK=/rds/user/$USER/hpc-work
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
python scripts/create_manifest.py "project-GBvPBV80Q662PGqP4gGKJ15j:/Users/jhz22/" --recursive --output_file "manifest.json.bz2"
bzip2 -d -c manifest.json.bz2
```

where `create_manifest.py` is used to obtain a bz2-compressed JSON manifest file (`manifest.json.bz2`) whereas the last command shows the contents of the file to the terminal, e.g.,

```
{
  "project-GBvPBV80Q662PGqP4gGKJ15j": [
    {
      "folder": "/Users/jhz22",
      "id": "file-GBvg79j0Jyf855Y44v4PvV06",
      "name": "SRR100022_20_1.stats-fastqc.txt",
      "parts": {
        "1": {
          "md5": "2d93f9138611b45aefde5e9d30430d3c",
          "size": 16959
        }
      }
    },
    {
      "folder": "/Users/jhz22",
      "id": "file-GBvg79j0Jyf3f3v24qVQfyk1",
      "name": "SRR100022_20_1.stats-fastqc.html",
      "parts": {
        "1": {
          "md5": "f3cbbbf3c824dcd94952a119e62c2452",
          "size": 661025
        }
      }
    }
  ]
}
```

The file thus obtained is used with a DNAnexus API token[^token] as contained in `~/doc/nexus` here.

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

See <https://github.com/dnanexus/dxCompiler/> for [releases](https://github.com/dnanexus/dxCompiler/releases).

It will compile workflows in WDL, <https://github.com/openwdl/wdl> with example in [https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md](https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md).

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

## jq

It is distributed with `dx-toolkit` above but the latest version is available from

<https://stedolan.github.io/jq/>

jq is a lightweight and flexible command-line JSON processor.

```bash
wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O jq
jq --help
```

It is useful to obtain the shared libraries, help files, etc. from source, <https://github.com/stedolan/jq>.

```bash
module load automake-1.16.1-gcc-5.4.0-uccejfj
module load libtool-2.4.6-gcc-5.4.0-xtclmhg
git submodule update --init # if building from git to get oniguruma
autoreconf -fi              # if building from git
./configure --with-oniguruma=builtin --prefix=/usr/local/Cluster-Apps/ceuadmin/jq/1.6
make -j8
make check
```

## Footnotes

---

It also works with oniguruma 0.6.9.8 in lieu of its counterpart from GitHub.

[^csd3]: **CSD3**

    Location: </rds/project/rds-zuZwCZMsS0w/olink_proteomics/scallop/> (aka /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/)

    For instance one only needs to do these to use `dx` and apps in `dx-toolkit`,

    ```bash
    # dx:
    module load python/3.7
    source /rds/project/rds-zuZwCZMsS0w/olink_proteomics/scallop/py37/bin/activate
    dx help ls
    # dx-toolkit:
    module load gcc/6 texlive python/2.7
    cd /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/dx-toolkit && source environment
    ```

    Access to the [training sessions](https://platform.dnanexus.com/panx/projects/GBkP5QXK4v3jy5Gj4jXpG6y8/data/) is possible through [Richard Houghton](mailto:rh12@sanger.ac.uk).

[^token]: **Token**

    Instead of the `dx login` and `dx logout` pair one can login with a token, i.e.,

    ```bash
    dx login --token $(cat ~/doc/nexus)
    dx select --level VIEW
    ```

    The `--noprojects` option allows for non-interactive login. The `dx select` command allows for specific projects be selected.

[^DNAnexus]: **DNAnexus**

    Billing, <https://documentation.dnanexus.com/admin/billing-and-account-management>, [three tiers](https://www.ukbiobank.ac.uk/enable-your-research/costs)

    Cohort browser, <https://documentation.dnanexus.com/user/cohort-browser>

    Index of dx commands <https://documentation.dnanexus.com/user/helpstrings-of-sdk-command-line-utilities>, particularly its [API Methods](https://documentation.dnanexus.com/developer/api/api-directory) section.

    Introduction to building Apps, <https://documentation.dnanexus.com/developer/apps/intro-to-building-apps>

    [OpenBio](https://github.com/dnanexus/OpenBio) Jupyter notebooks:

    - [UKB research analysis platform notebooks](https://github.com/dnanexus/OpenBio/tree/master/UKB_notebooks)
    - [getting started with dxdata](https://github.com/dnanexus/OpenBio/blob/master/dxdata/getting_started_with_dxdata.ipynb)
    - DxJupyterLab QuickStart, <https://documentation.dnanexus.com/user/jupyter-notebooks/quickstart>
    - LocusZoom, <https://documentation.dnanexus.com/science/scientific-guides/locuszoom-dnanexus-app>

    [Resource centre](https://www.dnanexus.com/resources) (DNAnexus xVantage Care team [support@dnanexus.com](mailto:support@dnanexus.com))

    [DNAnexus community](https://community.dnanexus.com/s/), Webinar on RStudio, [July 14, 2022](https://www.youtube.com/watch?v=iy22sxlj5Ik)

    [DNAnexus Olink proteomics community](https://tinyurl.com/p7zam69r), <https://hubs.ly/Q01Lc0c50>

    - Integrative Analysis of UK Biobank Proteomics Data, April 26, 2023, [vides](https://www.youtube.com/watch?v=btOYvmgwZGA), [slides](https://20779781.fs1.hubspotusercontent-na1.net/hubfs/20779781/UKB%20RAP%20Proteomics%20Showcase%20Webinar%20Slides.pdf)
    - Analyzing the UK Biobank Proteomics Data on the UK Biobank Research Analysis Platform, JUne 1, 2023, [slides](files/UKB RAP Proteomics - June 2023.pdf), [recording](https://www.youtube.com/watch?v=q57oai8gYvk)

    [UKB-RAP](https://github.com/dnanexus/UKB_RAP)
