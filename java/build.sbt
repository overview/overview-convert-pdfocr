name := "convert-pdfocr"

version := "0.0.6"

organization := "com.overviewdocs"

scalaVersion := "2.12.6"

libraryDependencies := Seq("org.overviewproject" %% "pdfocr" % "0.0.10")

scalacOptions += "-deprecation"

assemblyJarName in assembly := s"${name.value}.jar"
