package alternativa.tanks.tracker {
  import flash.events.TimerEvent;
  import flash.external.ExternalInterface;
  import flash.utils.Dictionary;
  import flash.utils.Timer;
  import flash.utils.getTimer;

  public class TrackerService implements ITrackerService {
    private static var actions:Dictionary = new Dictionary();

    private var commands:Vector.<TrackerCommand> = new Vector.<TrackerCommand>();
    private var timer:Timer = new Timer(1000);
    private var available:Boolean = false;

    public function TrackerService() {
      super();
      this.available = ExternalInterface.available && ExternalInterface.call("checkGALoaded");
      if(this.available) {
        this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
        this.trackPageView("initTracker");
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
    }

    public function trackEvent(param1:String, param2:String, param3:String) : void {
      var local4:int = 0;
      if(this.available) {
        local4 = getTimer() / 100;
        actions[param2] = local4;
        this.commands.push(new TrackerCommand("GATrackEvent",param1,param2,param3));
        this.timer.start();
      }
    }

    public function trackEventAfter(param1:String, param2:String, param3:String) : void {
      var local4:int = 0;
      if(this.available) {
        local4 = getTimer() / 100;
        if(actions[param3] != null) {
          this.trackEvent(param1,param2 + "<=" + param3,String((local4 - actions[param3]) / 10));
        } else {
          this.trackEvent(param1,param2 + "<=" + param3,"action not logged");
        }
      }
    }

    private function onTimer(param1:TimerEvent) : void {
      var local3:TrackerCommand = null;
      if(this.commands.length > 0) {
        if(this.available) {
          local3 = this.commands.shift();
          if(local3.arguments.length == 1) {
            ExternalInterface.call(local3.command,local3.arguments[0]);
          } else {
            ExternalInterface.call(local3.command,local3.arguments[0],local3.arguments[1],local3.arguments[2]);
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
