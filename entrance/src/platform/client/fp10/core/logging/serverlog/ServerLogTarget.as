package platform.client.fp10.core.logging.serverlog {
  import alternativa.osgi.service.logging.LogLevel;
  import alternativa.osgi.service.logging.LogTarget;
  import platform.client.fp10.core.network.ICommandSender;
  import platform.client.fp10.core.network.command.control.client.LogCommand;
  import platform.client.fp10.core.service.serverlog.impl.ServerLogPanel;

  public class ServerLogTarget implements LogTarget {
    private static const logLevels:Object = {
      "t":LogLevel.TRACE,
      "d":LogLevel.DEBUG,
      "i":LogLevel.INFO,
      "w":LogLevel.WARNING,
      "e":LogLevel.ERROR
    };

    private var commandSender:ICommandSender;
    private var channelLevels:Object = {};
    private var serverLogPanel:ServerLogPanel;

    public function ServerLogTarget(param1:ICommandSender, param2:String) {
      super();
      this.commandSender = param1;
      this.setup(param2);
    }

    private static function createMessage(param1:String, param2:Array) : String {
      var local3:int = 0;
      if(Boolean(param2)) {
        local3 = 0;
        while(local3 < param2.length) {
          param1 = param1.replace("%" + (local3 + 1),param2[local3]);
          local3++;
        }
      }
      return param1;
    }

    private function setup(param1:String) : void {
      var local3:String = null;
      var local2:Array = param1.split(",");
      for each(local3 in local2) {
        this.setupChannelLevels(local3);
      }
    }

    private function setupChannelLevels(param1:String) : void {
      var local7:String = null;
      var local8:LogLevel = null;
      if(!param1) {
        return;
      }
      var local2:Array = param1.split(":");
      var local3:String = local2[0];
      var local4:String = local2[1];
      if(!local3 || !local4) {
        return;
      }
      var local5:Object = {};
      var local6:Array = local4.split("");
      for each(local7 in local6) {
        local8 = logLevels[local7];
        if(Boolean(local8)) {
          local5[local8] = true;
        }
      }
      this.channelLevels[local3] = local5;
    }

    public function log(param1:Object, param2:LogLevel, param3:String, param4:Array = null) : void {
      var local6:String = null;
      var local5:String = param1.toString();
      if(this.isLogEnabled(local5,param2)) {
        local6 = createMessage(param3,param4);
        this.commandSender.sendCommand(new LogCommand(param2.getValue(),local5,local6));
        if(Boolean(this.serverLogPanel)) {
          this.serverLogPanel.addLogMessage(param2.getName(),local5 + " " + local6);
        }
      }
    }

    private function isLogEnabled(param1:String, param2:LogLevel) : Boolean {
      var local3:Object = this.channelLevels[param1];
      return Boolean(local3) && Boolean(local3[param2]);
    }

    public function setLogPanel(param1:ServerLogPanel) : void {
      this.serverLogPanel = param1;
    }
  }
}
