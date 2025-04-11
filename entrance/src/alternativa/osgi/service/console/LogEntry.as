package alternativa.osgi.service.console {
  import alternativa.osgi.service.logging.LogLevel;

  public class LogEntry {
    public var level:LogLevel;
    public var message:String;
    public var params:Array;
    public var object:Object;
    public var ordinal:int;

    public function LogEntry(param1:int, param2:Object, param3:LogLevel, param4:String, param5:Array) {
      super();
      this.ordinal = param1;
      this.object = param2;
      this.params = param5;
      this.message = param4;
      this.level = param3;
    }
  }
}
