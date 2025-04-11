package alternativa.tanks.camera {
  public class AngleValues {
    private var currentAngle:Number;
    private var totalAngle:Number;
    private var angularAcceleration:Number;
    private var angularSpeed:Number;
    private var angleDirection:Number;

    public function AngleValues() {
      super();
    }

    public function init(param1:Number, param2:Number, param3:Number) : void {
      this.totalAngle = param2 - param1;
      if(this.totalAngle < 0) {
        this.totalAngle = -this.totalAngle;
        this.angleDirection = -1;
      } else {
        this.angleDirection = 1;
      }
      if(this.totalAngle > Math.PI) {
        this.angleDirection = -this.angleDirection;
        this.totalAngle = 2 * Math.PI - this.totalAngle;
      }
      this.angularAcceleration = param3 * this.totalAngle;
      this.angularSpeed = 0;
      this.currentAngle = 0;
    }

    public function reverseAcceleration() : void {
      this.angularAcceleration = -this.angularAcceleration;
    }

    public function update(param1:Number) : Number {
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local4:Number = NaN;
      if(this.currentAngle < this.totalAngle) {
        local2 = this.angularAcceleration * param1;
        local3 = (this.angularSpeed + 0.5 * local2) * param1;
        this.angularSpeed += local2;
        local4 = this.totalAngle - this.currentAngle;
        if(local4 < local3) {
          local3 = local4;
        }
        this.currentAngle += local3;
        return local3 * this.angleDirection;
      }
      return 0;
    }
  }
}
