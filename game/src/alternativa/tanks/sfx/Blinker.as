package alternativa.tanks.sfx {
  public class Blinker {
    private var initialInterval:int;
    private var minInterval:int;
    private var intervalDecrement:int;
    private var maxValue:Number;
    private var minValue:Number;
    private var speedCoeff:Number;
    private var value:Number;
    private var _speed:Number;
    private var valueDelta:Number;
    private var switchTime:int;
    private var currInterval:int;

    public function Blinker(param1:int, param2:int, param3:int, param4:Number, param5:Number, param6:Number) {
      super();
      this.initialInterval = param1;
      this.minInterval = param2;
      this.intervalDecrement = param3;
      this.minValue = param4;
      this.maxValue = param5;
      this.speedCoeff = param6;
      this.valueDelta = param5 - param4;
    }

    public function setInitialInterval(param1:int) : void {
      this.initialInterval = param1;
    }

    public function init(param1:int) : void {
      this.value = this.maxValue;
      this.currInterval = this.initialInterval;
      this._speed = this.getSpeed(-1);
      this.switchTime = param1 + this.currInterval;
    }

    public function setMaxValue(param1:Number) : void {
      if(param1 >= this.minValue) {
        this.maxValue = param1;
        this.valueDelta = this.maxValue - this.minValue;
      }
    }

    public function setMinValue(param1:Number) : void {
      if(param1 <= this.maxValue) {
        this.minValue = param1;
        this.valueDelta = this.maxValue - this.minValue;
      }
    }

    public function getMinValue() : Number {
      return this.minValue;
    }

    public function updateValue(param1:int, param2:int) : Number {
      this.value += this._speed * param2;
      if(this.value > this.maxValue) {
        this.value = this.maxValue;
      }
      if(this.value < this.minValue) {
        this.value = this.minValue;
      }
      if(param1 >= this.switchTime) {
        if(this.currInterval > this.minInterval) {
          this.currInterval -= this.intervalDecrement;
          if(this.currInterval < this.minInterval) {
            this.currInterval = this.minInterval;
          }
        }
        this.switchTime = param1 + this.currInterval;
        if(this._speed < 0) {
          this._speed = this.getSpeed(1);
        } else {
          this._speed = this.getSpeed(-1);
        }
      }
      return this.value;
    }

    private function getSpeed(param1:Number) : Number {
      return param1 * this.speedCoeff * this.valueDelta / this.currInterval;
    }
  }
}
