name := "convert-pdfocr"

version := "0.0.5"

organization := "com.overviewdocs"

scalaVersion := "2.12.5"

libraryDependencies := Seq("org.overviewproject" %% "pdfocr" % "0.0.9")

scalacOptions += "-deprecation"

assemblyJarName in assembly := s"${name.value}.jar"
