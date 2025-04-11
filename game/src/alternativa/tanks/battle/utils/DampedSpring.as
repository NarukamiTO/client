package alternativa.tanks.battle.utils {
  public class DampedSpring {
    private var a:Number = 0;
    private var b:Number = 0;
    private var epsilon:Number = 0;
    private var velocity:Number = 0;
    private var acceleration:Number = 0;

    public var value:Number = 0;

    public function DampedSpring(param1:Number, param2:Number, param3:Number) {
      super();
      this.a = 2 * param1 * param2;
      this.b = param1 * param1;
      this.epsilon = param3;
    }

    public function reset(param1:Number = 0, param2:Number = 0) : void {
      this.value = param1;
      this.velocity = param2;
    }

    public function resetValue(param1:Number) : void {
      this.value = param1;
    }

    public function update(param1:Number, param2:Number) : void {
      var local3:Number = this.value - param2 + param1 * this.velocity;
      this.velocity += param1 * this.acceleration;
      var local4:Number = this.difference(local3,0,this.epsilon);
      this.acceleration = -this.a * this.velocity - this.b * local4;
      this.value = param2 + local3;
    }

    private function difference(param1:Number, param2:Number, param3:Number) : Number {
      var local4:Number = param1 - param2;
      if(local4 > param3) {
        return local4 - param3;
      }
      if(local4 < -param3) {
        return local4 + param3;
      }
      return 0;
    }
  }
}
