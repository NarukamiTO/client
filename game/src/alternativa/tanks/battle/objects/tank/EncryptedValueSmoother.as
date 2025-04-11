package alternativa.tanks.battle.objects.tank {
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;

  public class EncryptedValueSmoother implements ValueSmoother {
    private var currentValue:EncryptedNumber;
    private var targetValue:EncryptedNumber;
    private var smoothingSpeedUp:Number;
    private var smoothingSpeedDown:Number;

    public function EncryptedValueSmoother(param1:Number, param2:Number, param3:Number, param4:Number) {
      super();
      this.smoothingSpeedUp = param1;
      this.smoothingSpeedDown = param2;
      this.targetValue = new EncryptedNumberImpl(param3);
      this.currentValue = new EncryptedNumberImpl(param4);
    }

    public function reset(param1:Number) : void {
      this.currentValue.setNumber(param1);
      this.targetValue.setNumber(param1);
    }

    public function update(param1:Number) : Number {
      var local2:Number = Number(this.currentValue.getNumber());
      var local3:Number = Number(this.targetValue.getNumber());
      if(local2 < local3) {
        local2 += this.smoothingSpeedUp * param1;
        if(local2 > local3) {
          local2 = local3;
        }
      } else if(local2 > local3) {
        local2 -= this.smoothingSpeedDown * param1;
        if(local2 < local3) {
          local2 = local3;
        }
      }
      this.currentValue.setNumber(local2);
      return local2;
    }

    public function setTargetValue(param1:Number) : void {
      this.targetValue.setNumber(param1);
    }

    public function getTargetValue() : Number {
      return this.targetValue.getNumber();
    }
  }
}
