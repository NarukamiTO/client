package alternativa.osgi.service.command.impl {
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.command.FormattedOutput;

  public class CommandServiceImpl implements CommandService {
    private static const TOKENIZER:RegExp = /(?:[^"\s]+)|(?:"[^"]*")/g;

    private const DEFAULT_SCOPE:String = "cmd";

    public var commands:Vector.<Command> = new Vector.<Command>();

    public function CommandServiceImpl() {
      super();
    }

    public function registerCommand(param1:String, param2:String, param3:String, param4:Array, param5:Function) : void {
      var local6:Command = new Command(param1,param2,param3,param4,param5);
      this.commands.push(local6);
    }

    public function removeCommand(param1:String, param2:String, param3:Array) : void {
      var local5:Command = null;
      var local4:int = 0;
      while(local4 < this.commands.length) {
        local5 = this.commands[local4];
        if(this.isEqualsFullCmd(local5,param1,param2)) {
          if(local5.argsType.toString() == param3.toString()) {
            this.commands.splice(local4,1);
            return;
          }
        }
        local4++;
      }
    }

    public function execute(param1:String, param2:FormattedOutput) : void {
      var local6:String = null;
      var local7:Vector.<String> = null;
      var local3:Vector.<String> = this.parseCommands(param1);
      var local4:FormattedOutputToString = new FormattedOutputToString();
      this.parseAndExecuteCommand(local3[0],[],local4);
      var local5:int = 1;
      while(local5 < local3.length) {
        local6 = local3[local5];
        local7 = local4.content;
        local4 = new FormattedOutputToString();
        this.parseAndExecuteCommand(local6,[local7],local4);
        local5++;
      }
      param2.addLines(local4.content);
    }

    private function parseCommands(param1:String) : Vector.<String> {
      var local7:String = null;
      var local8:String = null;
      var local2:Vector.<String> = new Vector.<String>();
      var local3:Boolean = true;
      var local4:int = 0;
      var local5:int = 0;
      local5 = 0;
      while(local5 < param1.length) {
        local7 = param1.charAt(local5);
        if(local7 == "\"") {
          local3 = !local3;
        }
        if(local7 == "|" && local3) {
          local8 = param1.substr(local4,local5 - local4);
          local2.push(local8);
          local4 = local5 + 1;
        }
        local5++;
      }
      var local6:String = param1.substr(local4,param1.length - local4);
      local2.push(local6);
      return local2;
    }

    private function parseAndExecuteCommand(param1:String, param2:Array, param3:FormattedOutput) : void {
      var local6:String = null;
      var local7:String = null;
      var local10:Command = null;
      var local11:Array = null;
      param1 = param1.replace(/^\s+|\s+$/g,"");
      var local4:Array = param1.match(TOKENIZER);
      if(local4.length == 0) {
        throw new CommandNotFoundError(param1,"");
      }
      var local5:Array = (local4[0] as String).split(".");
      if(local5.length == 1) {
        local6 = "cmd";
        local7 = local5[0];
      } else {
        if(local5.length != 2) {
          throw new InvalidCommandFormatError(param1);
        }
        local6 = local5[0];
        local7 = local5[1];
      }
      local4.shift();
      var local8:int = 0;
      while(local8 < this.commands.length) {
        local10 = this.commands[local8];
        if(this.isEqualsFullCmd(local10,local6,local7)) {
          if(local10.argsType.length === local4.length + param2.length) {
            local11 = this.convert(local10.argsType,local4);
            local11 = local11.concat(param2);
            local10.excute(local11,param3);
            return;
          }
        }
        local8++;
      }
      var local9:String = "";
      local8 = 0;
      while(local8 < this.commands.length) {
        local10 = this.commands[local8];
        if(local10.scope != this.DEFAULT_SCOPE) {
          if(local10.cmd == local7 || local10.scope == local6 || local10.scope == local7) {
            local9 += local10.scope + "." + local10.cmd + " " + local10.help() + "\n";
          }
        }
        local8++;
      }
      throw new CommandNotFoundError(param1,local9);
    }

    private function isEqualsFullCmd(param1:Command, param2:String, param3:String) : Boolean {
      return param1.scope == param2 && param1.cmd == param3;
    }

    private function convert(param1:Array, param2:Array) : Array {
      var argsType:Array = param1;
      var stringParams:Array = param2;
      return stringParams.map(function(param1:*, param2:int, param3:Array):* {
        var local5:* = undefined;
        var local4:* = argsType[param2];
        switch(local4) {
          case String:
            local5 = param1 as String;
            if(local5.charAt(0) == "\"") {
              local5 = local5.substr(1);
            }
            if(local5.charAt(local5.length - 1) == "\"") {
              local5 = local5.substr(0,local5.length - 1);
            }
            return local5;
          case int:
            return int(param1);
          case uint:
            return uint(param1);
          case Number:
            return Number(param1);
          default:
            return;
        }
      });
    }
  }
}
