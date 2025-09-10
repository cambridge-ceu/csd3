---
sort: 44
---

# MitoScape

GitHub: <https://github.com/CHOP-CMEM/MitoScape>

## Preparations

```bash
wget -qO- https://github.com/CHOP-CMEM/MitoScape/archive/refs/tags/v1.0.tar.gz | tar xvfz -
cd MitoScape-1.0/
mv build.sbt build.sbt.save
module load ceuadmin/Scala
cs install --dir ~/bin sbt
module load openjdk/11.0.12_7/gcc/czpuqhmv
```

## assembly

Several changes are necessary:

- [project/plugins.sbt](files/MitoScape-1.0/project/plugins.sbt).
- [project/MergeStrategies.scala](files/MitoScape-1.0/project/MergeStrategies.scala)
- [an updated build.sbt](files/MitoScape-1.0/build.sbt)

Only the first file is generated on the fly below and the other two provided directly for legibility here.

As documented, Scale build tool (sbt) is invoked.

```bash
echo $JAVA_HOME
cat << 'EOF' > project/plugins.sbt
addSbtPlugin("com.typesafe.sbt" % "sbt-native-packager" % "1.8.1")
addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "1.1.0")
EOF
~/bin/sbt assembly
```

It shows that

```
$ ~/bin/sbt assembly
[info] welcome to sbt 1.11.6 (Eclipse Foundation Java 11.0.12)
[info] loading settings for project mitoscape-1-0-build from plugins.sbt...
[info] loading project definition from /home/jhz22/MitoScape-1.0/project
[info] compiling 1 Scala source to /home/jhz22/MitoScape-1.0/project/target/scala-2.12/sbt-1.0/classes ...
[info] loading settings for project mitoscape-1-0 from build.sbt...
[info] set current project to MitoScape (in build file:/home/jhz22/MitoScape-1.0/)
[success] Total time: 223 s (0:03:43.0), completed Sep 10, 2025, 5:00:36 PM
[info] compiling 6 Scala sources to /home/jhz22/MitoScape-1.0/target/scala-2.12/classes ...
[info] Strategy 'discard' was applied to 5 files (Run the task at debug level to see details)
[info] Strategy 'first' was applied to 1134 files (Run the task at debug level to see details)
[success] Total time: 294 s (0:04:54.0), completed Sep 10, 2025, 5:05:29 PM
```

## Additional details

```bash
~/bin/sbt clean compile
~/bin/sbt test:compile
~/bin/sbt package
ls target/scala-2.12/
ls target/scala-2.12/classes/MitoScape/
jar tf target/scala-2.12/mitoscape_2.12-0.1.jar | grep MitoScape
~/bin/sbt run
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
$ jar tf target/scala-2.12/mitoscape_2.12-0.1.jar | grep MitoScape
MitoScape/
MitoScape/BamReader.class
MitoScape/Feature.class
MitoScape/LD$$typecreator4$1.class
MitoScape/LD.class
MitoScape/MDParser.class
MitoScape/MTClassifierModel$$typecreator4$1.class
MitoScape/MTClassifierModel$.class
MitoScape/MTClassifierModel.class
MitoScape/MTClassify$$typecreator4$1.class
MitoScape/MTClassify$.class
MitoScape/MTClassify.class
MitoScape/MTFeature.class
MitoScape/MTReader$$typecreator4$1.class
MitoScape/MTReader.class
MitoScape/NucFeature.class
MitoScape/NucReader.class
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

## References

> Saunders, M. A., T. A. Schwarz, L. E. Colleoni, A. L. Drong, D. D. A. MacArthur, C. E. T. Halldorsson, D. I. Chanda, et al. 2021. *“MitoScape: A Big-Data, Machine-Learning Platform for Obtaining Mitochondrial DNA from Next-Generation Sequencing Data.”* *PLoS Computational Biology* 17 (11): e1009594. [https://doi.org/10.1371/journal.pcbi.1009594](https://doi.org/10.1371/journal.pcbi.1009594).
