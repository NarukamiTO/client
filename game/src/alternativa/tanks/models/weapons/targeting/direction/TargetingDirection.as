package alternativa.tanks.models.weapons.targeting.direction {
  import alternativa.math.Vector3;
  import mx.utils.StringUtil;

  public class TargetingDirection {
    private var direction:Vector3;
    private var angle:Number;
    private var maxPriority:Number;
    private var bonusPriority:Number;

    public function TargetingDirection(param1:Vector3, param2:Number, param3:Number, param4:Number = 0) {
      super();
      this.direction = param1.clone();
      this.angle = param2;
      this.maxPriority = param3;
      this.bonusPriority = param4;
    }

    public static function comparator(param1:TargetingDirection, param2:TargetingDirection) : Number {
      return param2.maxPriority - param1.maxPriority;
    }

    public function getDirection() : Vector3 {
      return this.direction;
    }

    public function getAngle() : Number {
      return this.angle;
    }

    public function getMaxPriority() : Number {
      return this.maxPriority;
    }

    public function getBonusPriority() : Number {
      return this.bonusPriority;
    }

    public function toString() : String {
      return StringUtil.substitute("TargetingDirection[direction={0}, angle={1}, maxPriority={2}]",this.direction,this.angle.toFixed(2),this.maxPriority.toFixed(0));
    }
  }
}
