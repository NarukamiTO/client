package projects.tanks.client.panel.model.shop.crystalpackage {
  public class CrystalPackageCC {
    private var _bonusCrystals:int;
    private var _crystals:int;
    private var _premiumDurationInDays:int;

    public function CrystalPackageCC(param1:int = 0, param2:int = 0, param3:int = 0) {
      super();
      this._bonusCrystals = param1;
      this._crystals = param2;
      this._premiumDurationInDays = param3;
    }

    public function get bonusCrystals() : int {
      return this._bonusCrystals;
    }

    public function set bonusCrystals(param1:int) : void {
      this._bonusCrystals = param1;
    }

    public function get crystals() : int {
      return this._crystals;
    }

    public function set crystals(param1:int) : void {
      this._crystals = param1;
    }

    public function get premiumDurationInDays() : int {
      return this._premiumDurationInDays;
    }

    public function set premiumDurationInDays(param1:int) : void {
      this._premiumDurationInDays = param1;
    }

    public function toString() : String {
      var local1:String = "CrystalPackageCC [";
      local1 += "bonusCrystals = " + this.bonusCrystals + " ";
      local1 += "crystals = " + this.crystals + " ";
      local1 += "premiumDurationInDays = " + this.premiumDurationInDays + " ";
      return local1 + "]";
    }
  }
}
