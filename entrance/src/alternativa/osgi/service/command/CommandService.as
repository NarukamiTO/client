package alternativa.osgi.service.command {
  public interface CommandService {
    function registerCommand(param1:String, param2:String, param3:String, param4:Array, param5:Function) : void;
    function removeCommand(param1:String, param2:String, param3:Array) : void;
    function execute(param1:String, param2:FormattedOutput) : void;
  }
}
