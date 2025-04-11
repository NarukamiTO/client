package projects.tanks.client.panel.model.rankupbonus.alert {
  public class RankUpBonusAlertItem {
    private var _accruedBonusCrystals:int;
    private var _alertPictureUrl:String;

    public function RankUpBonusAlertItem(param1:int = 0, param2:String = null) {
      super();
      this._accruedBonusCrystals = param1;
      this._alertPictureUrl = param2;
    }

    public function get accruedBonusCrystals() : int {
      return this._accruedBonusCrystals;
    }

    public function set accruedBonusCrystals(param1:int) : void {
      this._accruedBonusCrystals = param1;
    }

    public function get alertPictureUrl() : String {
      return this._alertPictureUrl;
    }

    public function set alertPictureUrl(param1:String) : void {
      this._alertPictureUrl = param1;
    }

    public function toString() : String {
      var local1:String = "RankUpBonusAlertItem [";
      local1 += "accruedBonusCrystals = " + this.accruedBonusCrystals + " ";
      local1 += "alertPictureUrl = " + this.alertPictureUrl + " ";
      return local1 + "]";
    }
  }
}
