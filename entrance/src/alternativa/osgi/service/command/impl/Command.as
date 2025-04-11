package alternativa.osgi.service.command.impl {
  import alternativa.osgi.service.command.FormattedOutput;

  public class Command {
    public var cmd:String;
    public var handler:Function;
    public var argsType:Array;
    public var scope:String;

    private var _help:String;

    public function Command(param1:String, param2:String, param3:String, param4:Array, param5:Function) {
      super();
      this._help = param3;
      this.scope = param1;
      this.argsType = param4;
      this.handler = param5;
      this.cmd = param2;
    }

    public function excute(param1:Array, param2:FormattedOutput) : void {
      var local3:Array = new Array();
      local3[0] = param2;
      var local4:int = 0;
      while(local4 < param1.length) {
        local3[local4 + 1] = param1[local4];
        local4++;
      }
      this.handler.apply(null,local3);
    }

    public function help() : String {
      return this.argsType + " " + this._help;
    }
  }
}
