package alternativa.osgi.service.logging {
  public interface LogTarget {
    function log(param1:Object, param2:LogLevel, param3:String, param4:Array = null) : void;
  }
}
