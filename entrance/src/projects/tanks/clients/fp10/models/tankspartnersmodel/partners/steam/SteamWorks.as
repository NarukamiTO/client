package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.steam {
  import flash.utils.ByteArray;
  import flash.utils.getDefinitionByName;

  public class SteamWorks {
    private var instance:Object;

    public function SteamWorks() {
      super();
      var local1:Class = getDefinitionByName("com.amanitadesign.steam.FRESteamWorks") as Class;
      this.instance = new local1();
    }

    public function addEventListener(param1:String, param2:Function) : void {
      this.instance.addEventListener(param1,param2);
    }

    public function removeEventListener(param1:String, param2:Function) : void {
      this.instance.removeEventListener(param1,param2);
    }

    public function init() : Boolean {
      return this.instance.init();
    }

    public function getAuthSessionTicket(param1:ByteArray) : uint {
      return this.instance.getAuthSessionTicket(param1);
    }

    public function getAppID() : int {
      return this.instance.getAppID();
    }

    public function getUserID() : String {
      return this.instance.getUserID();
    }

    public function getCurrentGameLanguage() : String {
      return this.instance.getCurrentGameLanguage();
    }

    public function microTxnResult() : Object {
      return this.instance.microTxnResult();
    }
  }
}
