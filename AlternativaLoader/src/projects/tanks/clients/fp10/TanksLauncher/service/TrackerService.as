package projects.tanks.clients.fp10.TanksLauncher.service {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.logging.LogService;
  import flash.events.TimerEvent;
  import flash.external.ExternalInterface;
  import flash.utils.Dictionary;
  import flash.utils.Timer;
  import flash.utils.getTimer;
  import projects.tanks.clients.fp10.TanksLauncher.TanksLauncher;

  public class TrackerService {
    private static var actions:Dictionary;

    private var commands:Vector.<TrackerCommand>;
    private var timer:Timer;
    private var available:Boolean = false;

    public function TrackerService() {
      super();
      this.available = ExternalInterface.available && ExternalInterface.call("checkGALoaded");
      if(this.available) {
        this.commands = new Vector.<TrackerCommand>();
        this.timer = new Timer(100);
        this.timer.addEventListener(TimerEvent.TIMER,this.timer_timerHandler);
        actions = new Dictionary();
      }
    }

    public function trackPageView(param1:String) : void {
      var local2:int = 0;
      if(this.available) {
        local2 = getTimer() / 100;
        actions[param1] = local2;
        this.commands.push(new TrackerCommand("GATrackPageView","/" + param1));
        this.timer.start();
      }
      LogService(OSGi.getInstance().getService(LogService)).getLogger(TanksLauncher.LOG_CHANNEL).debug("trackPageView=",[param1]);
    }

    public function trackEvent(param1:String, param2:String, param3:String) : void {
      var local5:int = 0;
      if(this.available) {
        local5 = getTimer() / 100;
        actions[param2] = local5;
        this.commands.push(new TrackerCommand("GATrackEvent",param1,param2,param3));
        this.timer.start();
      }
      var local4:* = "trackEvent(" + param1 + ", " + param2 + ", " + param3 + ")";
      LogService(OSGi.getInstance().getService(LogService)).getLogger(TanksLauncher.LOG_CHANNEL).debug(local4);
    }

    public function trackEventValue(param1:String, param2:String, param3:String, param4:Number) : void {
      var local5:int = 0;
      if(this.available) {
        local5 = getTimer() / 100;
        actions[param2] = local5;
        this.commands.push(new TrackerCommand("GATrackEvent",param1,param2,param4.toFixed(2)));
        this.timer.start();
      }
    }

    public function trackEventAfter(param1:String, param2:String, param3:String) : void {
      var local4:int = 0;
      if(this.available) {
        local4 = getTimer() / 100;
        if(actions[param3] != null) {
          this.trackEventValue(param1,param2,null,int((local4 - actions[param3]) / 10));
        } else {
          this.trackEvent(param1,param2,param3 + " action not logged");
        }
      }
    }

    private function timer_timerHandler(param1:TimerEvent) : void {
      var local3:TrackerCommand = null;
      var local4:Boolean = false;
      if(this.commands.length > 0) {
        if(this.available) {
          local3 = this.commands.shift();
          switch(local3.arguments.length) {
            case 4:
              local4 = ExternalInterface.call(local3.command,local3.arguments[0],local3.arguments[1],local3.arguments[2],local3.arguments[3]);
              break;
            case 3:
              local4 = ExternalInterface.call(local3.command,local3.arguments[0],local3.arguments[1],local3.arguments[2]);
              break;
            default:
              local4 = ExternalInterface.call(local3.command,local3.arguments[0]);
          }
        }
      } else {
        this.timer.stop();
      }
    }
  }
}

class TrackerCommand {
  private var _command:String;
  private var _arguments:Array;

  public function TrackerCommand(param1:String, ... rest) {
    super();
    this._command = param1;
    this._arguments = rest;
  }

  public function get command() : String {
    return this._command;
  }

  public function set command(param1:String) : void {
    this._command = param1;
  }

  public function get arguments() : Array {
    return this._arguments;
  }

  public function set arguments(param1:Array) : void {
    this._arguments = param1;
  }
}
