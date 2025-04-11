package alternativa.osgi.service.logging {
  public interface Logger {
    function trace(param1:String, param2:Array = null) : void;
    function debug(param1:String, param2:Array = null) : void;
    function info(param1:String, param2:Array = null) : void;
    function warning(param1:String, param2:Array = null) : void;
    function error(param1:String, param2:Array = null) : void;
  }
}
