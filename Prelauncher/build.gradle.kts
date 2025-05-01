import dev.assasans.actionscript.SwfType

plugins {
  id("dev.assasans.actionscript")
}

actionscript {
  source("src")
  config("../config.xml")

  option("-default-size=1000,600")

  swc = false
  swf = SwfType.Entry
  swfIncludeAllClasses = true
  mainClass = "projects.tanks.clients.fp10.Prelauncher.Prelauncher"
}

tasks.register<Exec>("run") {
  // TODO: Requires Adobe AIR, won't work in Standalone Flash Player
  logger.error("Run task is not implemented. It requires Adobe AIR and won't work in Standalone Flash Player. Use AlternativaLoader instead.")

  val runner = rootProject.file(requireNotNull(rootProject.property("run.binary")) {
    "Runner binary not specified. Please set the 'run.binary' property."
  })
  val entry = project.layout.buildDirectory.file("libs/executable.swf").get().asFile.absolutePath
  val params = mapOf(
    "swf" to "http://127.0.0.1:8082/libs/AlternativaLoader.swf",
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
