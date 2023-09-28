---
sort: 18
---

# GATK

Web: <https://gatk.broadinstitute.org/hc/en-us>


## Installation

The latest is 4.4.0.0,

```bash
wget https://github.com/broadinstitute/gatk/releases/download/4.4.0.0/gatk-4.4.0.0.zip
unzip gatk-4.4.0.0.zip
gatk --help
```

An attempt has been made for a module `module load ceuadmin/gatk`.

The Python dependencies are set up as follows,

```bash
module load anaconda/3.2019-10
conda env create -p /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10 -f gatkcondaenv.yml
conda activate /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10
```

The workflow description language (WDL) support is via cromwell, <https://cromwell.readthedocs.io/en/stable/>.

## hello world

The WDL script `hello-world.wdl` is as follows,

```wdl
workflow HelloWorld {

        call WriteGreeting
}

task WriteGreeting {

        command {
                echo "Hello World"
        }
        output {
                File outfile = stdout()
        }
}
```

The call is as follows,

```bash
#!/usr/bin/bash

export GATK=$CEUADMIN/gatk
export v=4.4.0.0

java -jar ${GATK}/cromwell/cromwell-50.jar run ${GATK}/${v}/tests/hello-world.wdl
```

## GATK workflows

Web: <https://github.com/gatk-workflows/>
