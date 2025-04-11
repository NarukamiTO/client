package projects.tanks.client.clans.panel.loadingclan {
  public class ClanLoadingPanelCC {
    private var _clanButtonVisible:Boolean;
    private var _minRankForCreateClan:int;

    public function ClanLoadingPanelCC(param1:Boolean = false, param2:int = 0) {
      super();
      this._clanButtonVisible = param1;
      this._minRankForCreateClan = param2;
    }

    public function get clanButtonVisible() : Boolean {
      return this._clanButtonVisible;
    }

    public function set clanButtonVisible(param1:Boolean) : void {
      this._clanButtonVisible = param1;
    }

    public function get minRankForCreateClan() : int {
      return this._minRankForCreateClan;
    }

    public function set minRankForCreateClan(param1:int) : void {
      this._minRankForCreateClan = param1;
    }

    public function toString() : String {
      var local1:String = "ClanLoadingPanelCC [";
      local1 += "clanButtonVisible = " + this.clanButtonVisible + " ";
      local1 += "minRankForCreateClan = " + this.minRankForCreateClan + " ";
      return local1 + "]";
    }
  }
}
