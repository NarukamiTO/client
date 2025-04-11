package alternativa.osgi.service.console.variables {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.console.IConsole;

  public class ConsoleVar {
    protected var varName:String;
    protected var inputListener:Function;

    public function ConsoleVar(param1:String, param2:Function = null) {
      super();
      this.varName = param1;
      this.inputListener = param2;
      var local3:IConsole = IConsole(OSGi.getInstance().getService(IConsole));
      if(local3 != null) {
        local3.addVariable(this);
      }
    }

    public function getName() : String {
      return this.varName;
    }

    public function destroy() : void {
      var local1:IConsole = IConsole(OSGi.getInstance().getService(IConsole));
      if(local1 != null) {
        local1.removeVariable(this.varName);
      }
      this.inputListener = null;
    }

    public function acceptInput(param1:String) : String {
      return "Not implemented";
    }

    public function toString() : String {
      return "Not implemented";
    }
  }
}
