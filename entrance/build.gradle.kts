import dev.assasans.actionscript.SwfType

plugins {
  id("dev.assasans.actionscript")
}

actionscript {
  source("src")
  source("build/generated/source/buildconfig")
  config("../config.xml")

  swc = true
  swf = SwfType.Swc
}

dependencies {
  compileOnly(project(":AlternativaLoader"))

  implementation(rootProject.files("libs/as3crypto.swc"))
  implementation(rootProject.files("libs/as3-signals.swc"))
  implementation(rootProject.files("libs/fl_package.swc"))
  implementation(rootProject.files("libs/robotlegs-framework-v1.5.2.swc"))
}

val generateBuildConfig = tasks.register("generateBuildConfig") {
  description = "Generates BuildConfig.as"
  group = "actionscript"

  val identityDir = rootProject.layout.projectDirectory.dir("identity").asFile
  val outputFile = layout.buildDirectory.file("generated/source/buildconfig/BuildConfig.as").get().asFile

  inputs.dir(identityDir)
  outputs.file(outputFile)

  doLast {
    // Ensure output directory exists
    outputFile.parentFile.mkdirs()

    // Get all files and directories in the identity folder
    val identityFiles = if(identityDir.exists() && identityDir.isDirectory) {
      identityDir.listFiles()
        ?.filter { it.isFile || it.isDirectory }
        ?.map { it.name }
        ?.sorted()
      ?: emptyList()
    } else {
      emptyList()
    }

    val content = buildString {
      appendLine("package {")
      appendLine("  public class BuildConfig {")
      appendLine("    public static const IDENTITY:Array = [")

      identityFiles.forEach { fileName ->
        appendLine("      \"$fileName\",")
      }

      appendLine("    ];")
      appendLine("  }")
      appendLine("}")
    }

    // Write the content to the file
    outputFile.writeText(content)

    println("Generated BuildConfig.as with identity:")
    identityFiles.forEach { println("  - $it") }
  }
}

tasks.named("prepareSources") {
  dependsOn(generateBuildConfig)
}
