package projects.tanks.client.panel.model.shop.premiumpackage {
  public class PremiumPackageCC {
    private var _durationInDays:int;

    public function PremiumPackageCC(param1:int = 0) {
      super();
      this._durationInDays = param1;
    }

    public function get durationInDays() : int {
      return this._durationInDays;
    }

    public function set durationInDays(param1:int) : void {
      this._durationInDays = param1;
    }

    public function toString() : String {
      var local1:String = "PremiumPackageCC [";
      local1 += "durationInDays = " + this.durationInDays + " ";
      return local1 + "]";
    }
  }
}
