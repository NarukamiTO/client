import dev.assasans.actionscript.ActionScriptExtension
import dev.assasans.actionscript.SwfType

plugins {
  id("dev.assasans.actionscript") version "1.0.6-SNAPSHOT" apply false
  idea
}

tasks.register<Copy>("dist") {
  group = "build"
  description = "Builds the distribution package for the project."

  val projects = mapOf(
    "AlternativaLoader" to "AlternativaLoader@SwfLibrary.swf",
    "entrance" to "entrance@SwfLibrary.swf",
    // "a3d.software" to "a3d.software@SwfLibrary.swf", // Incorrect rendering
    // "a3d.hardware" to "a3d.hardware@SwfLibrary.swf", // Project is not ready
    "game" to "game@SwfLibrary.swf",
  )
  val files = projects.toList().associate { (projectName, fileName) ->
    val project = project(projectName)

    val extension = project.extensions.getByType<ActionScriptExtension>()
    val file = when(extension.swf) {
      SwfType.Swc   -> {
        val compileSwc = project.tasks.named("compileSwc")
        val extractSwc = project.tasks.named("extractSwc")
        dependsOn(compileSwc)
        dependsOn(extractSwc)

        // TODO: Should task outputs be fixed in the plugin?
        compileSwc.get().outputs.files.singleFile.resolve("library.swf")
      }

      SwfType.Entry -> {
        val compileSwf = project.tasks.named("compileSwf")
        dependsOn(compileSwf)

        compileSwf.get().outputs.files.singleFile
      }

      SwfType.None  -> throw IllegalStateException("Project $projectName does not produce an SWF")
    }

    file to fileName
  }

  logger.warn("Files to copy: $files")

  from(files.keys)
  into(rootProject.layout.buildDirectory.dir("libs").get())
  eachFile {
    name = requireNotNull(files[file]) { "File $file is not in the list of files to copy" }
  }
  duplicatesStrategy = DuplicatesStrategy.INCLUDE
}

idea {
  module {
    isDownloadJavadoc = true
    isDownloadSources = true
  }
}
