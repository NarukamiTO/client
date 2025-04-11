package alternativa.tanks.models.weapons.targeting.processor {
  public class PrecisionTargetingParams {
    private var _numRays:int;
    private var _radius:Number;

    public function PrecisionTargetingParams(param1:int, param2:Number) {
      super();
      this._numRays = param1;
      this._radius = param2;
    }

    public function get numRays() : int {
      return this._numRays;
    }

    public function get radius() : Number {
      return this._radius;
    }
  }
}
