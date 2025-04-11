package alternativa.tanks.models.weapon.healing.targeting {
  import alternativa.math.Vector3;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapons.targeting.direction.TargetingDirection;
  import alternativa.tanks.models.weapons.targeting.direction.TargetingDirectionCalculator;

  public class IsisDirectionCalculator implements TargetingDirectionCalculator {
    private const NUMBER_SIDE_POINTS:int = 11;

    private var upDirection:Vector3 = new Vector3();
    private var currentDirection:Vector3 = new Vector3();
    private var angle:Number;
    private var screenSize:Number;
    private var bonusDirection:Vector3;

    public function IsisDirectionCalculator(param1:Number) {
      super();
      this.angle = param1 / 2;
      this.screenSize = Math.tan(this.angle) * 2;
    }

    public function setBonusDirection(param1:Vector3) : void {
      this.bonusDirection = param1;
    }

    public function resetBonusDirection() : void {
      this.bonusDirection = null;
    }

    public function getDirections(param1:AllGlobalGunParams) : Vector.<TargetingDirection> {
      var local6:Number = NaN;
      var local7:int = 0;
      var local8:Number = NaN;
      this.upDirection.cross2(param1.elevationAxis,param1.direction);
      var local2:Vector.<TargetingDirection> = new Vector.<TargetingDirection>();
      var local3:Number = this.screenSize / (this.NUMBER_SIDE_POINTS - 1);
      var local4:Number = -this.screenSize * 0.5;
      var local5:int = 0;
      while(local5 < this.NUMBER_SIDE_POINTS) {
        local6 = -this.screenSize * 0.5;
        local7 = 0;
        while(local7 < this.NUMBER_SIDE_POINTS) {
          this.currentDirection.copy(param1.direction);
          this.currentDirection.addScaled(local4,this.upDirection);
          this.currentDirection.addScaled(local6,param1.elevationAxis);
          this.currentDirection.normalize();
          local8 = Math.acos(this.currentDirection.dot(param1.direction));
          if(local8 <= this.angle) {
            local2.push(new TargetingDirection(this.currentDirection,local8,Number.MAX_VALUE));
          }
          local6 += local3;
          local7++;
        }
        local4 += local3;
        local5++;
      }
      if(this.bonusDirection != null) {
        local2.push(new TargetingDirection(this.bonusDirection,Math.acos(this.bonusDirection.dot(param1.direction)),Number.MAX_VALUE,10));
      }
      return local2;
    }
  }
}
