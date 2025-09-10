import sbtassembly.{MergeStrategy, PathList}

object MergeStrategies {
  val customMergeStrategy: String => MergeStrategy = {
    case PathList("META-INF", "MANIFEST.MF") => MergeStrategy.discard
    case PathList("META-INF", "INDEX.LIST") => MergeStrategy.discard
    case PathList("META-INF", xs @ _*) if xs.exists(_.toLowerCase.endsWith(".sf")) => MergeStrategy.discard
    case PathList("META-INF", xs @ _*) if xs.exists(_.toLowerCase.endsWith(".dsa")) => MergeStrategy.discard
    case PathList("META-INF", xs @ _*) => MergeStrategy.first
    case PathList("module-info.class") => MergeStrategy.discard
    case PathList("reference.conf") => MergeStrategy.concat
    case PathList("application.conf") => MergeStrategy.concat
    case PathList("log4j.properties") => MergeStrategy.first
    case PathList("com", "sun", xs @ _*) => MergeStrategy.first
    case PathList("javax", "activation", xs @ _*) => MergeStrategy.first
    case PathList("com", "sun", "activation", xs @ _*) => MergeStrategy.first
    case PathList("com", "sun", "istack", xs @ _*) => MergeStrategy.first
    case PathList("com", "sun", "xml", xs @ _*) => MergeStrategy.first
    case PathList("org", "apache", xs @ _*) => MergeStrategy.first
    case _ => MergeStrategy.first
  }
}
