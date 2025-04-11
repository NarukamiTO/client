package projects.tanks.client.clans.user {
  public class ClanUserCC {
    private var _clan:Boolean;
    private var _giveBonusesClan:Boolean;
    private var _loadingInServiceSpace:Boolean;
    private var _restrictionTimeJoinClanInSec:int;
    private var _showBuyLicenseButton:Boolean;
    private var _showOtherClan:Boolean;

    public function ClanUserCC(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:int = 0, param5:Boolean = false, param6:Boolean = false) {
      super();
      this._clan = param1;
      this._giveBonusesClan = param2;
      this._loadingInServiceSpace = param3;
      this._restrictionTimeJoinClanInSec = param4;
      this._showBuyLicenseButton = param5;
      this._showOtherClan = param6;
    }

    public function get clan() : Boolean {
      return this._clan;
    }

    public function set clan(param1:Boolean) : void {
      this._clan = param1;
    }

    public function get giveBonusesClan() : Boolean {
      return this._giveBonusesClan;
    }

    public function set giveBonusesClan(param1:Boolean) : void {
      this._giveBonusesClan = param1;
    }

    public function get loadingInServiceSpace() : Boolean {
      return this._loadingInServiceSpace;
    }

    public function set loadingInServiceSpace(param1:Boolean) : void {
      this._loadingInServiceSpace = param1;
    }

    public function get restrictionTimeJoinClanInSec() : int {
      return this._restrictionTimeJoinClanInSec;
    }

    public function set restrictionTimeJoinClanInSec(param1:int) : void {
      this._restrictionTimeJoinClanInSec = param1;
    }

    public function get showBuyLicenseButton() : Boolean {
      return this._showBuyLicenseButton;
    }

    public function set showBuyLicenseButton(param1:Boolean) : void {
      this._showBuyLicenseButton = param1;
    }

    public function get showOtherClan() : Boolean {
      return this._showOtherClan;
    }

    public function set showOtherClan(param1:Boolean) : void {
      this._showOtherClan = param1;
    }

    public function toString() : String {
      var local1:String = "ClanUserCC [";
      local1 += "clan = " + this.clan + " ";
      local1 += "giveBonusesClan = " + this.giveBonusesClan + " ";
      local1 += "loadingInServiceSpace = " + this.loadingInServiceSpace + " ";
      local1 += "restrictionTimeJoinClanInSec = " + this.restrictionTimeJoinClanInSec + " ";
      local1 += "showBuyLicenseButton = " + this.showBuyLicenseButton + " ";
      local1 += "showOtherClan = " + this.showOtherClan + " ";
      return local1 + "]";
    }
  }
}
