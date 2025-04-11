package alternativa.launcher {
  import alternativa.startup.ConnectionParameters;

  public interface ServerConfigLoaderListener {
    function onServerConfigLoadingStart() : void;
    function onServerConfigLoadingComplete() : void;
    function onServerConfigLoadingError(param1:String) : void;
    function onServerConfigLoadingProgress(param1:uint, param2:uint) : void;
    function onServerUnavailable() : void;
    function onServerOverloaded() : void;
    function onServerConfigParsed(param1:ConnectionParameters) : void;
    function log(param1:String) : void;
  }
}
