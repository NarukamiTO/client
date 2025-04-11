package alternativa.osgi.service.console {
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.logging.LogLevel;
  import alternativa.osgi.service.logging.LogTarget;

  public class ConsoleLogTarget implements LogTarget {
    private static const ANY_CHANNEL:* = "ANY_CHANNEL";
    private static const ANY_LOGLEVEL:LogLevel = null;

    private const EMPTY_VECTOR:Vector.<LogEntry> = new Vector.<LogEntry>(0);
    private const channels:Object = {};

    private var logEntrySequence:int;
    private var commandService:CommandService;
    private var bufferSize:int;
    private var connectedChannel:Object = {};
    private var connectToAllChannel:Boolean;
    private var console:IConsole;

    public function ConsoleLogTarget(param1:CommandService, param2:IConsole, param3:ILauncherParams) {
      super();
      this.console = param2;
      this.commandService = param1;
      this.bufferSize = int(param3.getParameter("log_channel_buffer_size","1000"));
      this.setupAutoConnectedChannel(param3);
      param1.registerCommand("log","channels","Список каналов",[],this.cmdChannelsList);
      param1.registerCommand("log","channel","Показать сообщения из канала",[String],this.cmdShowChannel);
      param1.registerCommand("log","connect","Показывать новые сообщения из канала",[String],this.cmdConnectChannel);
      param1.registerCommand("log","disconnect","Показывать новые сообщения из канала",[String],this.cmdDisconnectChannel);
      param1.registerCommand("log","trace","Посмотреть trace сообщения",[],this.cmdShow(LogLevel.TRACE));
      param1.registerCommand("log","info","Посмотреть info сообщения",[],this.cmdShow(LogLevel.INFO));
      param1.registerCommand("log","warning","Посмотреть warning сообщения",[],this.cmdShow(LogLevel.WARNING));
      param1.registerCommand("log","debug","Посмотреть debug сообщения",[],this.cmdShow(LogLevel.DEBUG));
      param1.registerCommand("log","error","Посмотреть error сообщения",[],this.cmdShow(LogLevel.ERROR));
    }

    public function log(param1:Object, param2:LogLevel, param3:String, param4:Array = null) : void {
      var local5:LogEntry = new LogEntry(this.logEntrySequence++,param1,param2,param3,param4);
      var local6:Vector.<LogEntry> = this.getOrCreateBufferForChannel(param1);
      local6.push(local5);
      if(Boolean(this.connectedChannel[param1]) || this.connectToAllChannel) {
        this.print(this.console,local5);
      }
      if(local6.length > this.bufferSize) {
        local6.splice(1,100);
      }
    }

    private function setupAutoConnectedChannel(param1:ILauncherParams) : void {
      var local3:String = null;
      var local2:String = param1.getParameter("showlog");
      if(Boolean(local2)) {
        if(local2 == "*") {
          this.connectToAllChannel = true;
        } else {
          for each(local3 in local2.split(",")) {
            this.connectedChannel[local3] = true;
          }
        }
      }
    }

    private function cmdDisconnectChannel(param1:FormattedOutput, param2:String) : void {
      delete this.connectedChannel[param2];
    }

    private function cmdConnectChannel(param1:FormattedOutput, param2:String) : void {
      this.connectedChannel[param2] = param2;
    }

    private function cmdShow(param1:LogLevel) : Function {
      var logLevel:LogLevel = param1;
      return function(param1:FormattedOutput):void {
        var local3:* = undefined;
        var local2:* = getLogEntriesForLevel(logLevel);
        for each(local3 in local2) {
          print(param1,local3);
        }
      };
    }

    private function getLogEntriesForLevel(param1:LogLevel) : Vector.<LogEntry> {
      var channelName:String = null;
      var channelEntries:Vector.<LogEntry> = null;
      var logEntry:LogEntry = null;
      var logLevel:LogLevel = param1;
      var result:Vector.<LogEntry> = new Vector.<LogEntry>();
      for(channelName in this.channels) {
        channelEntries = this.channels[channelName];
        for each(logEntry in channelEntries) {
          if(logEntry.level == logLevel) {
            result.push(logEntry);
          }
        }
      }
      result.sort(function(param1:LogEntry, param2:LogEntry):Number {
        return param1.ordinal - param2.ordinal;
      });
      return result;
    }

    private function cmdShowChannel(param1:FormattedOutput, param2:String) : void {
      var local5:LogEntry = null;
      var local3:Vector.<LogEntry> = this.getBufferForChannel(param2);
      var local4:int = 0;
      while(local4 < local3.length) {
        local5 = local3[local4];
        if(this.filtered(local5,param2,ANY_LOGLEVEL)) {
          this.print(param1,local5);
        }
        local4++;
      }
    }

    private function cmdChannelsList(param1:FormattedOutput) : void {
      var local2:String = null;
      for(local2 in this.channels) {
        param1.addText(local2);
      }
    }

    private function filtered(param1:LogEntry, param2:*, param3:LogLevel) : Boolean {
      if(param1.level != param3 && param3 != ANY_LOGLEVEL) {
        return false;
      }
      if(param1.object != param2 && param2 != ANY_CHANNEL) {
        return false;
      }
      return true;
    }

    private function insertVars(param1:String, param2:Array) : String {
      var local3:int = 0;
      if(param2 != null) {
        local3 = 0;
        while(local3 < param2.length) {
          param1 = param1.replace("%" + (local3 + 1),param2[local3]);
          local3++;
        }
      }
      return param1;
    }

    private function print(param1:FormattedOutput, param2:LogEntry) : void {
      param1.addText(param2.level.getName() + " [" + param2.object + "] " + this.insertVars(param2.message,param2.params));
    }

    private function getOrCreateBufferForChannel(param1:Object) : Vector.<LogEntry> {
      var local2:Vector.<LogEntry> = this.getBufferForChannel(param1);
      if(local2 == this.EMPTY_VECTOR) {
        local2 = new Vector.<LogEntry>();
        this.channels[param1] = local2;
      }
      return local2;
    }

    private function getBufferForChannel(param1:Object) : Vector.<LogEntry> {
      return Boolean(this.channels[param1]) ? this.channels[param1] : this.EMPTY_VECTOR;
    }
  }
}
