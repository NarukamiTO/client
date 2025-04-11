package projects.tanks.client.clans.space.createclan {
  public class ClanCreateCC {
    private var _minRankForCreateClan:int;

    public function ClanCreateCC(param1:int = 0) {
      super();
      this._minRankForCreateClan = param1;
    }

    public function get minRankForCreateClan() : int {
      return this._minRankForCreateClan;
    }

    public function set minRankForCreateClan(param1:int) : void {
      this._minRankForCreateClan = param1;
    }

    public function toString() : String {
      var local1:String = "ClanCreateCC [";
      local1 += "minRankForCreateClan = " + this.minRankForCreateClan + " ";
      return local1 + "]";
    }
  }
}
