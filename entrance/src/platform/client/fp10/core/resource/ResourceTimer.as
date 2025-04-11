package platform.client.fp10.core.resource {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.console.IConsole;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import flash.utils.getTimer;
  import platform.client.fp10.core.service.IResourceTimer;

  public class ResourceTimer implements IResourceTimer {
    private static const DEFAULT_TIMEOUT:int = 30000;
    private static const DEFAULT_RELOAD_ATTEMTS:int = 3;
    private static const MIN_TIMEOUT:int = 5000;

    private var timer:Timer;
    private var resources:Vector.<Resource>;
    private var numResources:int;
    private var timeout:int;
    private var maxReloadAttemts:int;

    public function ResourceTimer(param1:OSGi) {
      super();
      var local2:ILauncherParams = ILauncherParams(param1.getService(ILauncherParams));
      this.timeout = int(local2.getParameter("resource_timeout") || DEFAULT_TIMEOUT);
      if(this.timeout < MIN_TIMEOUT) {
        this.timeout = MIN_TIMEOUT;
      }
      this.maxReloadAttemts = int(local2.getParameter("resource_reload") || DEFAULT_RELOAD_ATTEMTS);
      if(this.maxReloadAttemts < 0) {
        this.maxReloadAttemts = 0;
      }
      this.resources = new Vector.<Resource>();
      this.timer = new Timer(1000);
      var local3:IConsole = IConsole(param1.getService(IConsole));
      local3.setCommandHandler("res_timer",this.onConsoleCommand);
    }

    public function getMaxReloadAttemts() : int {
      return this.maxReloadAttemts;
    }

    public function addResource(param1:Resource) : void {
      if(this.resources.indexOf(param1) < 0) {
        var local2:* = this.numResources++;
        this.resources[local2] = param1;
        if(this.numResources == 1) {
          this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
          this.timer.start();
        }
      }
    }

    public function removeResource(param1:Resource) : void {
      var local2:int = int(this.resources.indexOf(param1));
      if(local2 >= 0) {
        this.resources[local2] = this.resources[--this.numResources];
        this.resources[this.numResources] = null;
        if(this.numResources == 0) {
          this.timer.stop();
          this.timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
        }
      }
    }

    private function onTimer(param1:TimerEvent) : void {
      var local4:Resource = null;
      var local2:int = getTimer();
      var local3:int = 0;
      while(local3 < this.numResources) {
        local4 = this.resources[local3];
        if(local2 - local4.lastActivityTime > this.timeout) {
          this.removeResource(local4);
          local3--;
          local4.reload();
        }
        local3++;
      }
    }

    private function onConsoleCommand(param1:IConsole, param2:Array) : void {
      if(param2.length == 0) {
        param1.addText("Available parameters:");
        param1.addText("ls -- list currently tracked resources");
        return;
      }
      switch(param2[0]) {
        case "ls":
          this.listResources(param1);
      }
    }

    private function listResources(param1:IConsole) : void {
      var local4:Resource = null;
      var local5:int = 0;
      var local2:int = getTimer();
      var local3:int = 0;
      while(local3 < this.numResources) {
        local4 = this.resources[local3];
        local5 = (local2 - local4.lastActivityTime) / 1000;
        param1.addText(local3 + 1 + ". " + local4 + ", time: " + local5 + " second(s)");
        local3++;
      }
    }
  }
}
