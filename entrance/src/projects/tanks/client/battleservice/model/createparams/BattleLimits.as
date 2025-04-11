package projects.tanks.client.battleservice.model.createparams {
  public class BattleLimits {
    private var _scoreLimit:int;
    private var _timeLimitInSec:int;

    public function BattleLimits(param1:int = 0, param2:int = 0) {
      super();
      this._scoreLimit = param1;
      this._timeLimitInSec = param2;
    }

    public function get scoreLimit() : int {
      return this._scoreLimit;
    }

    public function set scoreLimit(param1:int) : void {
      this._scoreLimit = param1;
    }

    public function get timeLimitInSec() : int {
      return this._timeLimitInSec;
    }

    public function set timeLimitInSec(param1:int) : void {
      this._timeLimitInSec = param1;
    }

    public function toString() : String {
      var local1:String = "BattleLimits [";
      local1 += "scoreLimit = " + this.scoreLimit + " ";
      local1 += "timeLimitInSec = " + this.timeLimitInSec + " ";
      return local1 + "]";
    }
  }
}
