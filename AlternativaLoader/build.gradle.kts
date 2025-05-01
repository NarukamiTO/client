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

val configureWhitelist = tasks.register("configureFlashPlayerWhitelist") {
  val os = System.getProperty("os.name").lowercase()
  val path = when {
    os.startsWith("linux") -> System.getProperty("user.home") + "/.macromedia/Flash_Player/#Security/FlashPlayerTrust/"
    os.startsWith("win")   -> System.getProperty("user.home") + "\\AppData\\Roaming\\Macromedia\\Flash Player\\#Security\\FlashPlayerTrust\\"
    os.startsWith("mac")   -> System.getProperty("user.home") + "/Library/Preferences/Macromedia/Flash Player/#Security/FlashPlayerTrust/"
    else                   -> {
      logger.warn("Unknown OS: ${System.getProperty("os.name")}. Flash Player whitelist may not be configured correctly.")
      return@register
    }
  }

  val entry = project.layout.buildDirectory.file("libs/executable.swf").get()
  val file = file("$path/narukami.cfg")
  file.parentFile.mkdirs()
  file.writeText("file://${entry.asFile.parentFile.absolutePath}\n")
  logger.info("Flash Player whitelist configured: $file")
}

tasks.register<Exec>("run") {
  dependsOn(configureWhitelist)

  val runner = rootProject.file(requireNotNull(rootProject.property("run.binary")) {
    "Runner binary not specified. Please set the 'run.binary' property."
  })
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
