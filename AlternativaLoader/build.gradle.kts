import dev.assasans.actionscript.SwfType

plugins {
  id("dev.assasans.actionscript") version "1.0.3-SNAPSHOT"
  idea
}

actionscript {
  source("src")
  config("../config.xml")

  option("-default-size=1024,768")

  swc = true
  swf = SwfType.Entry
  swfIncludeAllClasses = true
  mainClass = "projects.tanks.clients.fp10.TanksLauncher.TanksLauncher"
}

dependencies {
  implementation(rootProject.files("libs/framework.swc"))
  implementation(rootProject.files("libs/textLayout.swc"))
}

tasks.register<Exec>("run") {
  val runner = project.property("run.binary")
  val entry = project.layout.buildDirectory.file("libs/executable.swf").get().asFile.absolutePath
  val params = mapOf(
    "config" to "127.0.0.1:8081/config.xml",
    "resources" to "127.0.0.1:8082",
    "balancer" to "http://127.0.0.1:8081/s/status.js",
    "prefix" to "main.c",
    "locale" to "ru",
    "lang" to "ru",
  )

  logger.info("Runner: $runner")
  logger.info("Entry point: $entry")
  logger.info("Params: $params")

  val query = params.map { (key, value) -> "$key=$value" }.joinToString("&")
  commandLine(runner, "file://$entry?$query")
}

idea {
  module {
    isDownloadJavadoc = true
    isDownloadSources = true
  }
}
