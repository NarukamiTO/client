package alternativa.osgi.service.clientlog {
  public interface IClientLog extends IClientLogBase {
    function logError(param1:String, param2:String, ... rest) : void;
    function getChannelStrings(param1:String) : Vector.<String>;
    function addLogListener(param1:IClientLogChannelListener) : void;
    function removeLogListener(param1:IClientLogChannelListener) : void;
    function addLogChannelListener(param1:String, param2:IClientLogChannelListener) : void;
    function removeLogChannelListener(param1:String, param2:IClientLogChannelListener) : void;
    function getChannelNames() : Vector.<String>;
  }
}
