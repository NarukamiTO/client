import dev.assasans.actionscript.SwfType

plugins {
  id("dev.assasans.actionscript")
}

actionscript {
  source("src")
  config("../config.xml")

  swc = true
  swf = SwfType.Swc
}

dependencies {
  compileOnly(project(":AlternativaLoader"))

  implementation(rootProject.files("libs/as3crypto.swc"))
}
