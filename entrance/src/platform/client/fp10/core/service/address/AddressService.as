package platform.client.fp10.core.service.address {
  import flash.events.Event;

  public interface AddressService {
    function back() : void;
    function forward() : void;
    function up() : void;
    function go(param1:int) : void;
    function href(param1:String, param2:String = "_self") : void;
    function popup(param1:String, param2:String = "popup", param3:String = "\"\"", param4:String = "") : void;
    function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void;
    function removeEventListener(param1:String, param2:Function) : void;
    function dispatchEvent(param1:Event) : Boolean;
    function hasEventListener(param1:String) : Boolean;
    function getBaseURL() : String;
    function getStrict() : Boolean;
    function setStrict(param1:Boolean) : void;
    function getHistory() : Boolean;
    function setHistory(param1:Boolean) : void;
    function getTracker() : String;
    function setTracker(param1:String) : void;
    function getTitle() : String;
    function setTitle(param1:String) : void;
    function getStatus() : String;
    function setStatus(param1:String) : void;
    function resetStatus() : void;
    function getValue() : String;
    function setValue(param1:String, param2:Boolean = true) : void;
    function getPath() : String;
    function getPathNames() : Array;
    function getQueryString() : String;
    function getParameter(param1:String) : String;
    function getQueryParameter(param1:String) : String;
    function getParameterNames() : Array;
    function reload() : void;
  }
}
