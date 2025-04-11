package platform.client.fp10.core.service.address.impl {
  import flash.events.Event;
  import platform.client.fp10.core.service.address.AddressService;
  import swfaddress.SWFAddress;
  import swfaddress.SWFAddressEvent;

  public class AddressServiceImpl implements AddressService {
    public function AddressServiceImpl() {
      super();
      this.addEventListener(SWFAddressEvent.CHANGE,function(param1:Event):void {
      });
    }

    public function back() : void {
      SWFAddress.back();
    }

    public function forward() : void {
      SWFAddress.forward();
    }

    public function up() : void {
      SWFAddress.up();
    }

    public function go(param1:int) : void {
      SWFAddress.go(param1);
    }

    public function href(param1:String, param2:String = "_self") : void {
      SWFAddress.href(param1,param2);
    }

    public function popup(param1:String, param2:String = "popup", param3:String = "\"\"", param4:String = "") : void {
      SWFAddress.popup(param1,param2,param3,param4);
    }

    public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void {
      SWFAddress.addEventListener(param1,param2,param3,param4,param5);
    }

    public function removeEventListener(param1:String, param2:Function) : void {
      SWFAddress.removeEventListener(param1,param2);
    }

    public function dispatchEvent(param1:Event) : Boolean {
      return SWFAddress.dispatchEvent(param1);
    }

    public function hasEventListener(param1:String) : Boolean {
      return SWFAddress.hasEventListener(param1);
    }

    public function getBaseURL() : String {
      return SWFAddress.getBaseURL();
    }

    public function getStrict() : Boolean {
      return SWFAddress.getStrict();
    }

    public function setStrict(param1:Boolean) : void {
      SWFAddress.setStrict(param1);
    }

    public function getHistory() : Boolean {
      return SWFAddress.getHistory();
    }

    public function setHistory(param1:Boolean) : void {
      SWFAddress.setHistory(param1);
    }

    public function getTracker() : String {
      return SWFAddress.getTracker();
    }

    public function setTracker(param1:String) : void {
      SWFAddress.setTracker(param1);
    }

    public function getTitle() : String {
      return SWFAddress.getTitle();
    }

    public function setTitle(param1:String) : void {
      SWFAddress.setTitle(param1);
    }

    public function getStatus() : String {
      return SWFAddress.getStatus();
    }

    public function setStatus(param1:String) : void {
      SWFAddress.setStatus(param1);
    }

    public function resetStatus() : void {
      SWFAddress.resetStatus();
    }

    public function getValue() : String {
      return SWFAddress.getValue();
    }

    public function setValue(param1:String, param2:Boolean = true) : void {
      SWFAddress.setValue(param1,param2);
    }

    public function getPath() : String {
      return SWFAddress.getPath();
    }

    public function getPathNames() : Array {
      return SWFAddress.getPathNames();
    }

    public function getQueryString() : String {
      return SWFAddress.getQueryString();
    }

    public function getParameter(param1:String) : String {
      return SWFAddress.getParameter(param1);
    }

    public function getParameterNames() : Array {
      return SWFAddress.getParameterNames();
    }

    public function reload() : void {
      SWFAddress.reload();
    }

    public function getQueryParameter(param1:String) : String {
      return SWFAddress.getQueryParameter(param1);
    }
  }
}
