package alternativa.tanks.models.tank.gearscore {
  public class GearScoreEntity {
    private var _score:int = 0;

    public function GearScoreEntity(param1:int) {
      super();
      this._score = param1;
    }

    public function get score() : int {
      return this._score;
    }

    public function set score(param1:int) : void {
      this._score = param1;
    }
  }
}
