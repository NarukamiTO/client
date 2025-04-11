package alternativa {
  import alternativa.osgi.service.launcherparams.ILauncherParams;

  public interface ILauncherListener {
    function onConfigLoadingStart() : void;
    function onConfigLoadingComplete() : void;
    function onConfigLoadingError(param1:String) : void;
    function onConfigLoadingProgress(param1:uint, param2:uint) : void;
    function onLibrariesLoadingStart() : void;
    function onLibrariesLoadingComplete(param1:ILauncherParams, param2:Function) : void;
    function onLibrariesInitialized() : void;
    function onLibraryLoadingError(param1:String) : void;
    function onServerUnavailable() : void;
    function onServerOverloaded() : void;
  }
}
