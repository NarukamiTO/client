package projects.tanks.client.clans.license.user {
  import platform.client.fp10.core.type.IGameObject;

  public class LicenseClanUserCC {
    private var _clanLicense:Boolean;
    private var _licenseGarageObject:IGameObject;

    public function LicenseClanUserCC(param1:Boolean = false, param2:IGameObject = null) {
      super();
      this._clanLicense = param1;
      this._licenseGarageObject = param2;
    }

    public function get clanLicense() : Boolean {
      return this._clanLicense;
    }

    public function set clanLicense(param1:Boolean) : void {
      this._clanLicense = param1;
    }

    public function get licenseGarageObject() : IGameObject {
      return this._licenseGarageObject;
    }

    public function set licenseGarageObject(param1:IGameObject) : void {
      this._licenseGarageObject = param1;
    }

    public function toString() : String {
      var local1:String = "LicenseClanUserCC [";
      local1 += "clanLicense = " + this.clanLicense + " ";
      local1 += "licenseGarageObject = " + this.licenseGarageObject + " ";
      return local1 + "]";
    }
  }
}
