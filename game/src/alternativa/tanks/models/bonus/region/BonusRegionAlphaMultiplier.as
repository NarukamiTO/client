package alternativa.tanks.models.bonus.region {
  public class BonusRegionAlphaMultiplier {
    private static const MIN_MULTIPLIER:Number = 0;
    private static const MAX_MULTIPLIER:Number = 1;

    private var _startTime:int;
    private var _duration:int;
    private var _startAlphaMesh:Number;
    private var _newAlpha:Number;

    public function BonusRegionAlphaMultiplier() {
      super();
    }

    private static function clamp(param1:Number) : Number {
      return Math.max(MIN_MULTIPLIER,Math.min(MAX_MULTIPLIER,param1));
    }

    public function init(param1:int, param2:int, param3:Number) : void {
      this._startTime = param1;
      this._duration = param2;
      this._startAlphaMesh = param3;
    }

    public function reset() : void {
      this._startTime = -1;
      this._duration = 0;
    }

    public function getAlphaMultiplier(param1:int, param2:Boolean) : Number {
      if(param1 > this._startTime + this._duration) {
        if(param2) {
          return MAX_MULTIPLIER;
        }
        return MIN_MULTIPLIER;
      }
      var local3:Number = (param1 - this._startTime) / this._duration;
      if(!param2) {
        local3 = 1 - local3;
      }
      return clamp(local3);
    }

    public function getAlpha(param1:int, param2:Boolean) : Number {
      var local4:Number = NaN;
      if(param1 > this._startTime + this._duration) {
        if(param2) {
          return MAX_MULTIPLIER;
        }
        return MIN_MULTIPLIER;
      }
      var local3:Number = (param1 - this._startTime) / this._duration;
      if(param2) {
        local4 = this._startAlphaMesh + (1 - this._startAlphaMesh) * local3;
      } else {
        local4 = this._startAlphaMesh * (1 - local3);
      }
      return clamp(local4);
    }

    public function get startAlphaMesh() : Number {
      return this._startAlphaMesh;
    }

    public function get newAlpha() : Number {
      return this._newAlpha;
    }

    public function set newAlpha(param1:Number) : void {
      this._newAlpha = param1;
    }
  }
}
