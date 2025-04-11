package projects.tanks.client.users.model.userbattlestatistics.rank {
  public class RankBounds {
    private var _lowBound:int;
    private var _topBound:int;

    public function RankBounds(param1:int = 0, param2:int = 0) {
      super();
      this._lowBound = param1;
      this._topBound = param2;
    }

    public function get lowBound() : int {
      return this._lowBound;
    }

    public function set lowBound(param1:int) : void {
      this._lowBound = param1;
    }

    public function get topBound() : int {
      return this._topBound;
    }

    public function set topBound(param1:int) : void {
      this._topBound = param1;
    }

    public function toString() : String {
      var local1:String = "RankBounds [";
      local1 += "lowBound = " + this.lowBound + " ";
      local1 += "topBound = " + this.topBound + " ";
      return local1 + "]";
    }
  }
}
