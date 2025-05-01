plugins {
  id("dev.assasans.actionscript") version "1.0.6-SNAPSHOT" apply false
  idea
}

idea {
  module {
    isDownloadJavadoc = true
    isDownloadSources = true
  }
}
