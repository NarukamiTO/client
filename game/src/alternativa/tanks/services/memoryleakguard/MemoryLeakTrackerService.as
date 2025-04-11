package alternativa.tanks.services.memoryleakguard {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.command.FormattedOutput;
  import flash.utils.Dictionary;

  public class MemoryLeakTrackerService {
    private static const classCounters:Dictionary = new Dictionary();

    private const objects:Dictionary = new Dictionary(true);

    public function MemoryLeakTrackerService(param1:OSGi) {
      super();
      this.registerCommands(param1);
    }

    private function registerCommands(param1:OSGi) : void {
      var local2:CommandService = CommandService(param1.getService(CommandService));
      local2.registerCommand("ml","tr","Traces tracked objects",[],this._trace);
    }

    private function _trace(param1:FormattedOutput) : void {
      var local2:* = undefined;
      for(local2 in this.objects) {
        param1.addText(Object(local2).toString() + " -> " + this.objects[local2]);
      }
    }

    public function track(param1:Object, param2:String) : void {
    }

    public function getObjectsCount() : int {
      var local2:* = undefined;
      var local1:int = 0;
      for(local2 in this.objects) {
        local1++;
      }
      return local1;
    }

    public function traceObjects() : void {
    }

    public function traceStaticstics() : void {
    }
  }
}
