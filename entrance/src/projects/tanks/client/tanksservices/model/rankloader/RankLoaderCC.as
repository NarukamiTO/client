package projects.tanks.client.tanksservices.model.rankloader {
  public class RankLoaderCC {
    private var _ranks:Vector.<RankInfo>;

    public function RankLoaderCC(param1:Vector.<RankInfo> = null) {
      super();
      this._ranks = param1;
    }

    public function get ranks() : Vector.<RankInfo> {
      return this._ranks;
    }

    public function set ranks(param1:Vector.<RankInfo>) : void {
      this._ranks = param1;
    }

    public function toString() : String {
      var local1:String = "RankLoaderCC [";
      local1 += "ranks = " + this.ranks + " ";
      return local1 + "]";
    }
  }
}
