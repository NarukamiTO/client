package swfaddress {
  import alternativa.startup.StartupSettings;
  import flash.errors.IllegalOperationError;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.TimerEvent;
  import flash.external.ExternalInterface;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.system.Capabilities;
  import flash.utils.Timer;

  [Event(name="change",type="swfaddress.SWFAddressEvent")]
  [Event(name="init",type="swfaddress.SWFAddressEvent")]
  public class SWFAddress {
    public static var onInit:Function;
    public static var onChange:Function;

    private static var _init:Boolean = false;
    private static var _initChange:Boolean = false;
    private static var _strict:Boolean = true;
    private static var _value:String = "";
    private static var _timer:Timer = null;
    private static var _availability:Boolean = ExternalInterface.available;
    private static var _dispatcher:EventDispatcher = new EventDispatcher();
    private static var URLhistory:Array = new Array();
    private static var _initializer:Boolean = _initialize();

    public function SWFAddress() {
      super();
      throw new IllegalOperationError("SWFAddress cannot be instantiated.");
    }

    private static function _initialize() : Boolean {
      if(_availability) {
        ExternalInterface.addCallback("getSWFAddressValue",function():String {
          return _value;
        });
        ExternalInterface.addCallback("setSWFAddressValue",_setValue);
      }
      if(_timer == null) {
        _timer = new Timer(75);
        _timer.addEventListener(TimerEvent.TIMER,_check);
      }
      _timer.start();
      return true;
    }

    private static function _check(param1:TimerEvent) : void {
      if((typeof SWFAddress["onInit"] == "function" || _dispatcher.hasEventListener("init")) && !_init) {
        SWFAddress._setValueInit(_getValue());
        SWFAddress._init = true;
      }
      if(typeof SWFAddress["onChange"] == "function" || _dispatcher.hasEventListener("change")) {
        SWFAddress._init = true;
        SWFAddress._setValueInit(_getValue());
      }
    }

    private static function _getValue() : String {
      var local1:String = null;
      var local3:Array = null;
      var local2:String = null;
      if(_availability) {
        local1 = ExternalInterface.call("SWFAddress.getValue") as String;
        local3 = ExternalInterface.call("SWFAddress.getIds") as Array;
        if(local3 != null) {
          local2 = local3.toString();
        }
      }
      if(local2 == null || !_availability) {
        local1 = SWFAddress._value;
      } else if(local1 == "undefined" || local1 == null) {
        local1 = "";
      }
      return local1 || "";
    }

    private static function _setValueInit(param1:String) : void {
      var local2:Boolean = param1 != SWFAddress._value;
      SWFAddress._value = param1;
      if(!_init) {
        _dispatchEvent(SWFAddressEvent.INIT);
      } else if(local2) {
        _dispatchEvent(SWFAddressEvent.CHANGE);
      }
      _initChange = true;
    }

    private static function _setValue(param1:String) : void {
      if(param1 == "undefined" || param1 == null) {
        param1 = "";
      }
      if(SWFAddress._value == param1 && SWFAddress._init) {
        return;
      }
      if(!SWFAddress._initChange) {
        return;
      }
      SWFAddress._value = param1;
      if(!_init) {
        SWFAddress._init = true;
        if(typeof SWFAddress["onInit"] == "function" || _dispatcher.hasEventListener("init")) {
          _dispatchEvent(SWFAddressEvent.INIT);
        }
      }
      _dispatchEvent(SWFAddressEvent.CHANGE);
    }

    private static function _dispatchEvent(param1:String) : void {
      if(_dispatcher.hasEventListener(param1)) {
        _dispatcher.dispatchEvent(new SWFAddressEvent(param1));
      }
      param1 = param1.substr(0,1).toUpperCase() + param1.substring(1);
      if(typeof SWFAddress["on" + param1] == "function") {
        SWFAddress["on" + param1]();
      }
    }

    public static function back() : void {
      if(_availability && SWFAddress._init) {
        ExternalInterface.call("SWFAddress.back");
      } else {
        _value = URLhistory.pop();
        _dispatchEvent(SWFAddressEvent.CHANGE);
      }
    }

    public static function forward() : void {
      if(_availability && SWFAddress._init) {
        ExternalInterface.call("SWFAddress.forward");
      }
    }

    public static function up() : void {
      var local1:String = SWFAddress.getPath();
      SWFAddress.setValue(local1.substr(0,local1.lastIndexOf("/",local1.length - 2) + (local1.substr(local1.length - 1) == "/" ? 1 : 0)));
    }

    public static function go(param1:int) : void {
      if(_availability) {
        ExternalInterface.call("SWFAddress.go",param1);
      }
    }

    public static function href(param1:String, param2:String = "_self") : void {
      if(_availability && Capabilities.playerType == "ActiveX") {
        ExternalInterface.call("SWFAddress.href",param1,param2);
        return;
      }
      navigateToURL(new URLRequest(param1),param2);
    }

    public static function popup(param1:String, param2:String = "popup", param3:String = "\"\"", param4:String = "") : void {
      if(_availability && (Capabilities.playerType == "ActiveX" || ExternalInterface.call("asual.util.Browser.isSafari"))) {
        ExternalInterface.call("SWFAddress.popup",param1,param2,param3,param4);
        return;
      }
      navigateToURL(new URLRequest("javascript:popup=window.open(\"" + param1 + "\",\"" + param2 + "\"," + param3 + ");" + param4 + ";void(0);"),"_self");
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void {
      _dispatcher.addEventListener(param1,param2,param3,param4,param5);
    }

    public static function removeEventListener(param1:String, param2:Function) : void {
      _dispatcher.removeEventListener(param1,param2,false);
    }

    public static function dispatchEvent(param1:Event) : Boolean {
      return _dispatcher.dispatchEvent(param1);
    }

    public static function hasEventListener(param1:String) : Boolean {
      return _dispatcher.hasEventListener(param1);
    }

    public static function getBaseURL() : String {
      var local1:String = null;
      if(_availability) {
        local1 = String(ExternalInterface.call("SWFAddress.getBaseURL"));
      }
      return local1 == null || local1 == "null" || !_availability ? "" : local1;
    }

    public static function getStrict() : Boolean {
      var local1:String = null;
      if(_availability) {
        local1 = ExternalInterface.call("SWFAddress.getStrict") as String;
      }
      return local1 == null ? _strict : local1 == "true";
    }

    public static function setStrict(param1:Boolean) : void {
      if(_availability) {
        ExternalInterface.call("SWFAddress.setStrict",param1);
      }
      _strict = param1;
    }

    public static function getHistory() : Boolean {
      return _availability ? ExternalInterface.call("SWFAddress.getHistory") as Boolean : false;
    }

    public static function setHistory(param1:Boolean) : void {
      if(_availability) {
        ExternalInterface.call("SWFAddress.setHistory",param1);
      }
    }

    public static function getTracker() : String {
      return _availability ? ExternalInterface.call("SWFAddress.getTracker") as String : "";
    }

    public static function setTracker(param1:String) : void {
      if(_availability) {
        ExternalInterface.call("SWFAddress.setTracker",param1);
      }
    }

    public static function getTitle() : String {
      var local1:String = _availability ? ExternalInterface.call("SWFAddress.getTitle") as String : "";
      if(local1 == "undefined" || local1 == null) {
        local1 = "";
      }
      return local1;
    }

    public static function setTitle(param1:String) : void {
      if(_availability) {
        ExternalInterface.call("SWFAddress.setTitle",param1);
      }
    }

    public static function getStatus() : String {
      var local1:String = _availability ? ExternalInterface.call("SWFAddress.getStatus") as String : "";
      if(local1 == "undefined" || local1 == null) {
        local1 = "";
      }
      return local1;
    }

    public static function setStatus(param1:String) : void {
      if(_availability) {
        ExternalInterface.call("SWFAddress.setStatus",param1);
      }
    }

    public static function resetStatus() : void {
      if(_availability) {
        ExternalInterface.call("SWFAddress.resetStatus");
      }
    }

    public static function getValue() : String {
      return _value || "";
    }

    public static function setValue(param1:String, param2:Boolean = true) : void {
      if(param1 == "undefined" || param1 == null) {
        param1 = "";
      }
      if(SWFAddress._value == param1) {
        return;
      }
      if(_availability && SWFAddress._init) {
        ExternalInterface.call("SWFAddress.setValue",param1);
      } else {
        URLhistory.push(_value);
      }
      SWFAddress._value = param1;
      if(param2) {
        _dispatchEvent(SWFAddressEvent.CHANGE);
      }
    }

    public static function getPath() : String {
      var local1:String = SWFAddress.getValue();
      if(local1.indexOf("?") != -1) {
        return local1.split("?")[0];
      }
      return local1;
    }

    public static function getPathNames() : Array {
      var local1:String = SWFAddress.getPath();
      var local2:Array = local1.split("/");
      if(local1.substr(0,1) == "/" || local1.length == 0) {
        local2.splice(0,1);
      }
      if(local1.substr(local1.length - 1,1) == "/") {
        local2.splice(local2.length - 1,1);
      }
      return local2;
    }

    public static function getQueryString() : String {
      var local1:String = SWFAddress.getValue();
      var local2:Number = Number(local1.indexOf("?"));
      if(local2 != -1 && local2 < local1.length) {
        return local1.substr(local2 + 1);
      }
      return "";
    }

    private static function fetchParameter(param1:String, param2:String) : String {
      var local4:Array = null;
      var local5:Array = null;
      var local6:Number = NaN;
      var local3:Number = Number(param2.indexOf("?"));
      if(local3 != -1) {
        param2 = param2.substr(local3 + 1);
        local4 = param2.split("&");
        local6 = local4.length;
        while(Boolean(local6--)) {
          local5 = local4[local6].split("=");
          if(local5[0] == param1) {
            return local5[1];
          }
        }
      }
      return "";
    }

    public static function getParameter(param1:String) : String {
      var local2:String = SWFAddress.getValue();
      return fetchParameter(param1,local2);
    }

    public static function getQueryParameter(param1:String) : String {
      var local2:String = SWFAddress.getBaseURL();
      return fetchParameter(param1,local2);
    }

    public static function getParameterNames() : Array {
      var local4:Array = null;
      var local5:Number = NaN;
      var local1:String = SWFAddress.getValue();
      var local2:Number = Number(local1.indexOf("?"));
      var local3:Array = new Array();
      if(local2 != -1) {
        local1 = local1.substr(local2 + 1);
        if(local1 != "" && local1.indexOf("=") != -1) {
          local4 = local1.split("&");
          local5 = 0;
          while(local5 < local4.length) {
            local3.push(local4[local5].split("=")[0]);
            local5++;
          }
        }
      }
      return local3;
    }

    public static function reload() : void {
      if(_availability) {
        ExternalInterface.call("SWFAddress.reload");
      } else if(StartupSettings.isDesktop) {
        StartupSettings.closeApplication();
      }
    }
  }
}
