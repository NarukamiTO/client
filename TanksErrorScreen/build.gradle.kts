import dev.assasans.actionscript.SwfType

plugins {
  id("dev.assasans.actionscript")
}

actionscript {
  source("src")
  config("../config.xml")

  option("-default-size=500,375")

  swc = false
  swf = SwfType.Entry
  swfIncludeAllClasses = true
  mainClass = "projects.tanks.clients.fp10.TanksLauncherErrorScreen.TanksErrorMessage"
}
