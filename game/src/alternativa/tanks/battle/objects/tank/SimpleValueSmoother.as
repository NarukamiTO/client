package alternativa.tanks.battle.objects.tank {
  public class SimpleValueSmoother implements ValueSmoother {
    private var currentValue:Number;
    private var targetValue:Number;
    private var smoothingSpeedUp:Number;
    private var smoothingSpeedDown:Number;

    public function SimpleValueSmoother(param1:Number, param2:Number, param3:Number, param4:Number) {
      super();
      this.smoothingSpeedUp = param1;
      this.smoothingSpeedDown = param2;
      this.targetValue = param3;
      this.currentValue = param4;
    }

    public function reset(param1:Number) : void {
      this.currentValue = param1;
      this.targetValue = param1;
    }

    public function update(param1:Number) : Number {
      if(this.currentValue < this.targetValue) {
        this.currentValue += this.smoothingSpeedUp * param1;
        if(this.currentValue > this.targetValue) {
          this.currentValue = this.targetValue;
        }
      } else if(this.currentValue > this.targetValue) {
        this.currentValue -= this.smoothingSpeedDown * param1;
        if(this.currentValue < this.targetValue) {
          this.currentValue = this.targetValue;
        }
      }
      return this.currentValue;
    }

    public function setTargetValue(param1:Number) : void {
      this.targetValue = param1;
    }

    public function getTargetValue() : Number {
      return this.targetValue;
    }
  }
}
