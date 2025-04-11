package alternativa.tanks.models.weapon.shotgun {
  import alternativa.math.Vector3;
  import mx.utils.StringUtil;

  public class ShotgunTargetingDirection {
    private var direction:Vector3 = new Vector3();
    private var maxPriority:Number;

    public function ShotgunTargetingDirection(param1:Vector3, param2:Number) {
      super();
      this.init(param1,param2);
    }

    public function init(param1:Vector3, param2:Number) : void {
      this.direction.copy(param1);
      this.maxPriority = param2;
    }

    public function getDirection() : Vector3 {
      return this.direction;
    }

    public function getMaxPriority() : Number {
      return this.maxPriority;
    }

    public function toString() : String {
      return StringUtil.substitute("TargetingDirection[direction={0}, maxPriority={1}]",this.direction,this.maxPriority.toFixed(0));
    }
  }
}
