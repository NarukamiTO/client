import dev.assasans.actionscript.SwfType

plugins {
  id("dev.assasans.actionscript")
}

actionscript {
  source("src")
  config("../config.xml")

  option("-default-size=256,256")

  swc = true
  swf = SwfType.Entry
  swfIncludeAllClasses = true
  mainClass = "projects.tanks.clients.fp10.StandaloneLoader.StandaloneLoader"
}

// TODO: Implement "run" task, but it requires Adobe AIR
