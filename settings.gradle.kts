rootProject.name = "narukami-client"

pluginManagement {
  repositories {
    gradlePluginPortal()
    mavenLocal()
    maven("https://central.sonatype.com/repository/maven-snapshots/") {
      name = "Central Portal Snapshots"
      content {
        includeModule("dev.assasans.actionscript", "dev.assasans.actionscript.gradle.plugin")
        includeModule("dev.assasans.actionscript", "gradle-actionscript-plugin")
      }
    }
  }
}

include(":AlternativaLoader")
include(":entrance")
