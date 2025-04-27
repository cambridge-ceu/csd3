---
sort: 19
---

# GATK

Web: <https://gatk.broadinstitute.org/hc/en-us>

## Installation

### OpenJDK

Web: <https://www.openlogic.com/openjdk-downloads>

| Version | module    | cromwell        | Class file version |
| ------- | --------- | --------------- | ------------------ |
| 8       | 8u382-b05 | cromwell-50.jar | 52                 |
| 11      | 11.0.20+8 | cromwell-85.jar | 55                 |
| 17      | 17.0.8+7  | cromwell-85.jar | 61                 |

e.g., `module load ceuadmin/openjdk/17.0.8+7` for Java 17.

### GATK

The latest is 4.4.0.0,

```bash
wget https://github.com/broadinstitute/gatk/releases/download/4.4.0.0/gatk-4.4.0.0.zip
unzip gatk-4.4.0.0.zip
gatk --list
gatk HaplotypeCaller --help
```

We proceed to set up a module, to be loaded with `module load ceuadmin/gatk/4.4.0.0`.

At the time of writing (28/9/2023), `gatk --list` only works with Java 17.

### Python

The dependencies are set up as follows,

```bash
module load anaconda/3.2019-10
conda env create -p /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10 -f gatkcondaenv.yml
conda activate /usr/local/Cluster-Apps/ceuadmin/gatk/4.4.0.0/anaconda-3.2019-10
```

### cromwell

Web: <https://cromwell.readthedocs.io/en/stable/>

It provides support for workflow description language (WDL).

```bash
cd $CEUADMIN/gatk/cromwell
wget https://github.com/broadinstitute/cromwell/releases/download/85/cromwell-85.jar
wget https://github.com/broadinstitute/cromwell/releases/download/85/womtool-85.jar
wget https://github.com/broadinstitute/cromwell/releases/download/50/cromwell-50.jar
wget https://github.com/broadinstitute/cromwell/releases/download/50/womtool-50.jar
```

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

module load ceuadmin/gatk/4.4.0.0
java -jar ${GATK}/cromwell/cromwell-85.jar run ${GATK}/${v}/tests/hello-world.wdl
```

## GATK workflows

Web: <https://github.com/gatk-workflows/>
