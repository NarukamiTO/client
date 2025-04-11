package projects.tanks.client.battlefield.models.tankparts.gearscore {
  public class BattleGearScoreCC {
    private var _score:int;

    public function BattleGearScoreCC(param1:int = 0) {
      super();
      this._score = param1;
    }

    public function get score() : int {
      return this._score;
    }

    public function set score(param1:int) : void {
      this._score = param1;
    }

    public function toString() : String {
      var local1:String = "BattleGearScoreCC [";
      local1 += "score = " + this.score + " ";
      return local1 + "]";
    }
  }
}
