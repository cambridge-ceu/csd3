---
sort: 44
---

# MitoScape

GitHub: <https://github.com/CHOP-CMEM/MitoScape>

## Installation

```bash
wget -qO- https://github.com/CHOP-CMEM/MitoScape/archive/refs/tags/v1.0.tar.gz | tar xvfz -
cd MitoScape-1.0/
module load ceuadmin/Scala
cs install sbt
module load openjdk/11.0.12_7/gcc/czpuqhmv
echo $JAVA_HOME
cat << 'EOF' > project/plugins.sbt
addSbtPlugin("com.typesafe.sbt" % "sbt-native-packager" % "1.8.1")
addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "1.1.0")
EOF
/home/$USER/.local/share/coursier/bin/sbt clean compile
/home/$USER/.local/share/coursier/bin/sbt test:compile
/home/$USER/.local/share/coursier/bin/sbt package
ls target/scala-2.12/
ls target/scala-2.12/classes/MitoScape/
/home/$USER/.local/share/coursier/bin/sbt run
```

which shows

```
$ ls target/scala-2.12/
classes/  mitoscape_2.12-0.1.jar  mitoscape_2.12-0.1-tests.jar  sync/  test-sync/  update/  zinc/
$ ls target/scala-2.12/classes/MitoScape/
 BamReader.class             MDParser.class                            'MTClassify$$typecreator4$1.class'  'MTReader$$typecreator4$1.class'
 Feature.class              'MTClassifierModel$$typecreator4$1.class'  'MTClassify$.class'                  MTReader.class
'LD$$typecreator4$1.class'  'MTClassifierModel$.class'                  MTClassify.class                    NucFeature.class
 LD.class                    MTClassifierModel.class                    MTFeature.class                     NucReader.class
$ /home/jhz22/.local/share/coursier/bin/sbt run
[info] welcome to sbt 1.11.6 (Eclipse Foundation Java 11.0.12)
[info] loading settings for project mitoscape-1-0-build from plugins.sbt...
[info] loading project definition from /rds/project/rds-4o5vpvAowP0/software/MitoScape-1.0/project
[info] loading settings for project mitoscape-1-0 from build.sbt...
[info] set current project to MitoScape (in build file:/rds/project/rds-4o5vpvAowP0/software/MitoScape-1.0/)
[info] running MitoScape.MTClassify

        Usage: mtclassify
                          --prefix <prefix of bam file>
                          --out <output file>
                          --prob <probability threshold>
                          --threads <number of threads>

```

Here is the citation in **Chicago style (author-date format)** and **Chicago style (notes and bibliography)** for the article you referenced:

## References

> Saunders, M. A., T. A. Schwarz, L. E. Colleoni, A. L. Drong, D. D. A. MacArthur, C. E. T. Halldorsson, D. I. Chanda, et al. 2021. *“MitoScape: A Big-Data, Machine-Learning Platform for Obtaining Mitochondrial DNA from Next-Generation Sequencing Data.”* *PLoS Computational Biology* 17 (11): e1009594. [https://doi.org/10.1371/journal.pcbi.1009594](https://doi.org/10.1371/journal.pcbi.1009594).
