logLevel := Level.Warn

resolvers += Resolver.bintrayIvyRepo("jw3", "sbt-plugin-releases")
addSbtPlugin("com.github.jw3" % "sbt-openshift" % "0.1")

addSbtPlugin("com.typesafe.sbt" %% "sbt-native-packager" % "1.2.0")
addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-RC11")
addSbtPlugin("com.typesafe.sbt" % "sbt-git" % "0.8.5")
