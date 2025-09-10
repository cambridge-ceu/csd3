---
sort: 44
---

# MitoScape

GitHub: <https://github.com/CHOP-CMEM/MitoScape>

## GitHub

This follows similar steps as before.

```bash
git clone https://github.com/CHOP-CMEM/MitoScape
cd MitoScape
module load openjdk/11.0.12_7/gcc/czpuqhmv
sbt assembly
```

We have

```
$ sbt assembly
[info] Loading settings for project mitoscape-build from plugins.sbt ...
[info] Loading project definition from /home/jhz22/MitoScape/project
[info] Loading settings for project mitoscape from build.sbt ...
[info] Set current project to MitoScape (in build file:/home/jhz22/MitoScape/)
[info] Updating ...
[info] downloading https://repo1.maven.org/maven2/org/apache/avro/avro-ipc/1.8.2/avro-ipc-1.8.2.jar ...
[info] downloading https://repo1.maven.org/maven2/org/apache/avro/avro/1.8.2/avro-1.8.2.jar ...
[info]  [SUCCESSFUL ] org.apache.avro#avro-ipc;1.8.2!avro-ipc.jar (2404ms)
[info]  [SUCCESSFUL ] org.apache.avro#avro;1.8.2!avro.jar (4094ms)
[info] Done updating.
[warn] There may be incompatibilities among your library dependencies.
[warn] Run 'evicted' to see detailed eviction warnings
[info] Compiling 6 Scala sources to /home/jhz22/MitoScape/target/scala-2.12/classes ...
[info] Non-compiled module 'compiler-bridge_2.12' for Scala 2.12.12. Compiling...
[info]   Compilation completed in 10.985s.
[info] Done compiling.
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by com.google.protobuf.UnsafeUtil (file:/home/jhz22/.sbt/boot/scala-2.12.6/org.scala-sbt/sbt/1.2.3/protobuf-java-3.3.1.jar) to field java.nio.Buffer.address
WARNING: Please consider reporting this to the maintainers of com.google.protobuf.UnsafeUtil
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
[info] Packaging /home/jhz22/MitoScape/target/scala-2.12/mitoscape_2.12-0.1.jar ...
[info] Done packaging.
[info] Strategy 'concat' was applied to 12 files (Run the task at debug level to see details)
[info] Strategy 'deduplicate' was applied to 9 files (Run the task at debug level to see details)
[info] Strategy 'discard' was applied to 377 files (Run the task at debug level to see details)
[info] Strategy 'first' was applied to 201 files (Run the task at debug level to see details)
[info] Strategy 'last' was applied to 3 files (Run the task at debug level to see details)
[info] Strategy 'rename' was applied to 19 files (Run the task at debug level to see details)
[info] Packaging /home/jhz22/MitoScape/target/scala-2.12/MitoScapeClassify.jar ...
[info] Done packaging.
[success] Total time: 347 s, completed Sep 10, 2025, 8:49:18 PM
```

so it largely goes through smoothly.

## 1.0

```bash
wget -qO- https://github.com/CHOP-CMEM/MitoScape/archive/refs/tags/v1.0.tar.gz | tar xvfz -
cd MitoScape-1.0/
mv build.sbt build.sbt.save
module load ceuadmin/Scala
cs install --dir ~/bin sbt
module load openjdk/11.0.12_7/gcc/czpuqhmv
```

### assembly

Several changes are necessary:

- [project/plugins.sbt](files/MitoScape-1.0/project/plugins.sbt).
- [project/MergeStrategies.scala](files/MitoScape-1.0/project/MergeStrategies.scala).
- [an updated build.sbt](files/MitoScape-1.0/build.sbt).

Only the first file is generated on the fly below and the other two provided directly for legibility here.

As documented, Scale build tool (sbt) is invoked.

```bash
echo $JAVA_HOME
cat << 'EOF' > project/plugins.sbt
addSbtPlugin("com.typesafe.sbt" % "sbt-native-packager" % "1.8.1")
addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "1.1.0")
EOF
~/bin/sbt assembly
ll target/scala-2.12/
```

which gives

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
$ ll target/scala-2.12/
total 210128
-rw-rw-r-- 1 jhz22 jhz22 185703796 Sep 10 17:05 MitoScapeClassify.jar
```

### Additional details

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
