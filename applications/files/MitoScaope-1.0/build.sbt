/*************************************************
 * MitoScape build.sbt
 * Updated for sbt 1.11+ and assembly compatibility
 *************************************************/

name := "MitoScape"
version := "0.1"
scalaVersion := "2.12.12"

// Dependency versions
val sparkVersion = "3.0.0"
val hadoopVersion = "3.2.1"

libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-sql" % sparkVersion excludeAll(
    ExclusionRule(organization = "jakarta.xml.bind"),
    ExclusionRule(organization = "org.glassfish.hk2.external")
  ),
  "org.apache.spark" %% "spark-mllib" % sparkVersion excludeAll(
    ExclusionRule(organization = "jakarta.xml.bind"),
    ExclusionRule(organization = "org.glassfish.hk2.external")
  ),
  "org.bdgenomics.adam" %% "adam-core-spark3" % "0.32.0",
  "org.apache.hadoop" % "hadoop-common" % hadoopVersion excludeAll(
    ExclusionRule(organization = "com.sun.jersey"),
    ExclusionRule(organization = "org.eclipse.jetty")
  )
)

scalacOptions ++= Seq("-feature", "-deprecation", "-unchecked", "-Xlint")

/************* Packaging *************/

enablePlugins(JavaAppPackaging, DockerPlugin)

Compile / packageBin / mainClass := Some("MitoScape.MTClassify")

dockerBaseImage := "openjdk:8-jre-slim"
maintainer := "singhln@chop.edu"
exportJars := true

/************* Assembly **************/

// Required import to bring in MergeStrategies from project/MergeStrategies.scala
import MergeStrategies.customMergeStrategy

assembly / test := {} // Don't run tests during assembly
assembly / assemblyOption := (assembly / assemblyOption).value
  .withIncludeScala(true)
  .withIncludeDependency(true)

assembly / assemblyJarName := "MitoScapeClassify.jar"
assembly / mainClass := Some("MitoScape.MTClassify")
assembly / assemblyMergeStrategy := customMergeStrategy
