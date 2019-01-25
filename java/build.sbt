name := "convert-pdfocr"

version := "0.0.9"

organization := "com.overviewdocs"

scalaVersion := "2.12.8"

libraryDependencies := Seq("org.overviewproject" %% "pdfocr" % "0.0.11")

scalacOptions += "-deprecation"

assemblyJarName in assembly := s"${name.value}.jar"
