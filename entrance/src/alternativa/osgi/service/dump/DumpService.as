package alternativa.osgi.service.dump {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.console.IConsole;
  import flash.utils.Dictionary;

  public class DumpService implements IDumpService {
    public function DumpService(param1:OSGi) {
      super();
    }

    public function registerDumper(param1:IDumper) : void {
    }

    public function unregisterDumper(param1:String) : void {
    }

    public function dump(param1:String, param2:Array) : String {
      return "unsupported";
    }

    public function get dumpersByName() : Dictionary {
      return new Dictionary();
    }

    public function get dumpersList() : Vector.<IDumper> {
      return new Vector.<IDumper>();
    }

    private function getDumperList() : String {
      return "";
    }

    private function hadleConsoleCommand(param1:IConsole, param2:Array) : void {
    }
  }
}
