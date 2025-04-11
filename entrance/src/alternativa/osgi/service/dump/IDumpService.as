package alternativa.osgi.service.dump {
  import flash.utils.Dictionary;

  public interface IDumpService {
    function registerDumper(param1:IDumper) : void;
    function unregisterDumper(param1:String) : void;
    function dump(param1:String, param2:Array) : String;
    function get dumpersByName() : Dictionary;
    function get dumpersList() : Vector.<IDumper>;
  }
}
