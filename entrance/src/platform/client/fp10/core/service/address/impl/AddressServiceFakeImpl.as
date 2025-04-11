package platform.client.fp10.core.service.address.impl {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import flash.events.Event;
  import platform.client.fp10.core.service.address.AddressService;

  public class AddressServiceFakeImpl implements AddressService {
    [Inject]
    public static var launcherParams:ILauncherParams;

    public function AddressServiceFakeImpl() {
      super();
    }

    public function back() : void {
    }

    public function forward() : void {
    }

    public function up() : void {
    }

    public function go(param1:int) : void {
    }

    public function href(param1:String, param2:String = "_self") : void {
    }

    public function popup(param1:String, param2:String = "popup", param3:String = "\"\"", param4:String = "") : void {
    }

    public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void {
    }

    public function removeEventListener(param1:String, param2:Function) : void {
    }

    public function dispatchEvent(param1:Event) : Boolean {
      return false;
    }

    public function hasEventListener(param1:String) : Boolean {
      return false;
    }

    public function getBaseURL() : String {
      return launcherParams.getParameter("baseurl");
    }

    public function getStrict() : Boolean {
      return false;
    }

    public function setStrict(param1:Boolean) : void {
    }

    public function getHistory() : Boolean {
      return false;
    }

    public function setHistory(param1:Boolean) : void {
    }

    public function getTracker() : String {
      return "";
    }

    public function setTracker(param1:String) : void {
    }

    public function getTitle() : String {
      return "";
    }

    public function setTitle(param1:String) : void {
    }

    public function getStatus() : String {
      return "";
    }

    public function setStatus(param1:String) : void {
    }

    public function resetStatus() : void {
    }

    public function getValue() : String {
      return launcherParams.getParameter("hashparams","");
    }

    public function setValue(param1:String, param2:Boolean = true) : void {
      launcherParams.setParameter("hashparams",param1);
    }

    public function getPath() : String {
      return "";
    }

    public function getPathNames() : Array {
      return [];
    }

    public function getQueryString() : String {
      return "";
    }

    public function getParameter(param1:String) : String {
      return "";
    }

    public function getQueryParameter(param1:String) : String {
      return launcherParams.getParameter(param1,"");
    }

    public function getParameterNames() : Array {
      return [];
    }

    public function reload() : void {
    }
  }
}
