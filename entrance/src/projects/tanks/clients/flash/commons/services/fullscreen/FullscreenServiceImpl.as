package projects.tanks.clients.flash.commons.services.fullscreen {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import flash.display.StageDisplayState;
  import flash.external.ExternalInterface;
  import flash.system.Capabilities;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;

  public class FullscreenServiceImpl implements FullscreenService {
    private static const STANDALONE:String = "StandAlone";
    private static const DESKTOP:String = "Desktop";

    private static const BROWSER_BLACK_LIST:Array = [{
      "browser":"Chrome",
      "os":"Windows"
    },{
      "browser":"Chrome",
      "os":"Mac"
    },{
      "browser":"Safari",
      "os":"Windows"
    },{
      "browser":"Safari",
      "os":"Mac"
    },{
      "browser":"Yandex",
      "os":"Windows"
    },{
      "browser":"Yandex",
      "os":"Mac"
    }];

    private var _display:IDisplay;
    private var launcherParams:ILauncherParams;
    private var mouseLockEnabled:Boolean;
    private var standalone:Boolean;

    public function FullscreenServiceImpl(param1:IDisplay, param2:ILauncherParams) {
      super();
      this._display = param1;
      this.launcherParams = param2;
      this.standalone = Capabilities.playerType == STANDALONE || Capabilities.playerType == DESKTOP;
      this.mouseLockEnabled = this.checkIfMouseLockEnabled();
    }

    public function switchFullscreen() : void {
      if(this._display.stage.displayState == StageDisplayState.NORMAL) {
        this.activate();
      } else {
        this.deactivate();
      }
    }

    private function activate() : void {
      if(this.isAvailable()) {
        this._display.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
      }
    }

    private function deactivate() : void {
      this._display.stage.displayState = StageDisplayState.NORMAL;
    }

    public function isAvailable() : Boolean {
      if(this.launcherParams.getParameter(StageDisplayState.FULL_SCREEN_INTERACTIVE,"true") != "true") {
        return false;
      }
      var local1:Array = this.getFlashVersion();
      return int(local1[0]) == 11 && int(local1[1]) >= 3 || int(local1[0]) > 11;
    }

    public function isFullScreenNow() : Boolean {
      return this._display.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE || this._display.stage.displayState == StageDisplayState.FULL_SCREEN;
    }

    public function isMouseLockEnabled() : Boolean {
      return this.mouseLockEnabled;
    }

    private function checkIfMouseLockEnabled() : Boolean {
      var local4:Object = null;
      if(this.standalone) {
        return true;
      }
      var local1:String = this.getBrowserName();
      var local2:String = Capabilities.os;
      var local3:int = 0;
      while(local3 < BROWSER_BLACK_LIST.length) {
        local4 = BROWSER_BLACK_LIST[local3];
        if(local1.indexOf(local4.browser) > -1 && local2.indexOf(local4.os) > -1) {
          return false;
        }
        local3++;
      }
      return true;
    }

    private function getBrowserName() : String {
      var userAgent:String = null;
      var browser:String = null;
      try {
        userAgent = ExternalInterface.call("window.navigator.userAgent.toString");
        browser = "[Unknown Browser]";
        if(userAgent.indexOf("Safari") != -1) {
          browser = "Safari";
        }
        if(userAgent.indexOf("Firefox") != -1) {
          browser = "Firefox";
        }
        if(userAgent.indexOf("Chrome") != -1) {
          browser = "Chrome";
        }
        if(userAgent.indexOf("MSIE") != -1) {
          browser = "IE";
        }
        if(userAgent.indexOf("Opera") != -1) {
          browser = "Opera";
        }
        if(userAgent.indexOf("YaBrowser") != -1) {
          browser = "Yandex";
        }
      }
      catch(e:Error) {
        return "[No ExternalInterface]";
      }
      return browser;
    }

    private function getFlashVersion() : Array {
      return Capabilities.version.substr(Capabilities.version.indexOf(" ") + 1).split(",");
    }
  }
}
