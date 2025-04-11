package alternativa.startup {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import flash.display.DisplayObjectContainer;

  public interface IClientConfigurator {
    function start(param1:DisplayObjectContainer, param2:ILauncherParams, param3:ConnectionParameters, param4:Vector.<String>) : void;
  }
}
