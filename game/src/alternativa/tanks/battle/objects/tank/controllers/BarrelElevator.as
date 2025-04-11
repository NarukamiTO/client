package alternativa.tanks.battle.objects.tank.controllers {
  import alternativa.math.Matrix3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.objects.tank.SimpleValueSmoother;
  import alternativa.tanks.battle.objects.tank.ValueSmoother;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.utils.BitMask;
  import alternativa.tanks.utils.MathUtils;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretControlType;

  public final class BarrelElevator implements WeaponMount {
    public static const STOP:int = 0;
    public static const UP:int = 1;
    public static const DOWN:int = 2;
    public static const CENTER:int = 3;

    private var maxTurnSpeedSmoother:ValueSmoother = new SimpleValueSmoother(0.3,10,0,0);
    private var maxTurnSpeed:Number = 0;
    private var turnAcceleration:Number = 0;
    private var turnSpeed:Number = 0;
    private var defaultElevation:Number;
    private var minElevation:Number;
    private var maxElevation:Number;
    private var prevElevation:Number;
    private var currElevation:Number;
    private var interpolatedElevation:Number;

    private const locks:BitMask = new BitMask();

    private var userControl:int;
    private var realControl:int;
    private var elevationDirection:int;

    public function BarrelElevator(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) {
      super();
      this.defaultElevation = param1;
      this.minElevation = param2;
      this.maxElevation = param3;
      this.prevElevation = param1;
      this.currElevation = param1;
      this.interpolatedElevation = param1;
      this.setMaxTurnSpeed(param4,true);
      this.turnAcceleration = param5;
    }

    public function getRealControl() : int {
      return this.realControl;
    }

    public function getBarrelPhysicsElevation() : Number {
      return this.currElevation;
    }

    public function reset() : void {
      this.prevElevation = this.defaultElevation;
      this.currElevation = this.defaultElevation;
      this.interpolatedElevation = this.defaultElevation;
    }

    public function setUserControl(param1:int) : void {
      this.userControl = param1;
      if(this.isNotLocked()) {
        this.setRealControl(param1);
      }
    }

    public function rotate(param1:Number, param2:Matrix3) : void {
      this.maxTurnSpeed = this.maxTurnSpeedSmoother.update(param1);
      this.prevElevation = this.currElevation;
      if(this.isLocked()) {
        this.turnSpeed = 0;
        this.elevationDirection = 0;
        return;
      }
      switch(this.realControl) {
        case STOP:
          this.stop();
          break;
        case UP:
          this.rotateInDirection(1,param1);
          break;
        case DOWN:
          this.rotateInDirection(-1,param1);
          break;
        case CENTER:
          this.center(param1);
      }
    }

    private function stop() : void {
      this.elevationDirection = 0;
      this.turnSpeed = 0;
    }

    private function rotateInDirection(param1:int, param2:Number) : void {
      if(this.elevationDirection != param1) {
        this.elevationDirection = param1;
        this.turnSpeed = 0;
      }
      this.currElevation += this.turnSpeed * param2;
      this.turnSpeed = MathUtils.moveValueTowards(this.turnSpeed,param1 * this.maxTurnSpeed,this.turnAcceleration * param2);
      if(this.currElevation < this.minElevation || this.currElevation > this.maxElevation) {
        this.currElevation = MathUtils.clamp(this.currElevation,this.minElevation,this.maxElevation);
        this.elevationDirection = 0;
        this.turnSpeed = 0;
      }
    }

    private function center(param1:Number) : void {
      if(this.currElevation == this.defaultElevation) {
        this.elevationDirection = 0;
        this.turnSpeed = 0;
      } else {
        this.elevationDirection = this.currElevation < this.defaultElevation ? 1 : -1;
        this.currElevation = MathUtils.moveValueTowards(this.currElevation,this.defaultElevation,Math.abs(this.turnSpeed * param1));
        this.turnSpeed = MathUtils.moveValueTowards(this.turnSpeed,this.elevationDirection * this.maxTurnSpeed,this.turnAcceleration * param1);
      }
    }

    public function interpolate(param1:Number, param2:int) : void {
      this.interpolatedElevation = this.prevElevation + param1 * (this.currElevation - this.prevElevation);
    }

    private function isLocked() : Boolean {
      return this.locks.isNotEmpty();
    }

    private function isNotLocked() : Boolean {
      return this.locks.isEmpty();
    }

    public function isRotating() : Boolean {
      return this.elevationDirection != 0;
    }

    public function getBarrelInterpolatedElevation() : Number {
      return this.interpolatedElevation;
    }

    public function setBarrelElevation(param1:Number) : void {
      this.currElevation = param1;
    }

    public function setMaxTurnSpeed(param1:Number, param2:Boolean) : void {
      if(param2) {
        this.maxTurnSpeed = param1;
        this.maxTurnSpeedSmoother.reset(param1);
      } else {
        this.maxTurnSpeedSmoother.setTargetValue(param1);
      }
    }

    public function getTurnAcceleration() : Number {
      return this.turnAcceleration;
    }

    public function setTurnAcceleration(param1:Number) : void {
      this.turnAcceleration = param1;
    }

    public function lock(param1:int) : void {
      var local2:Boolean = this.isNotLocked();
      this.locks.setBits(param1);
      if(local2 && this.isLocked()) {
        this.setRealControl(STOP);
      }
    }

    public function unlock(param1:int) : void {
      var local2:Boolean = this.isLocked();
      this.locks.clearBits(param1);
      if(local2 && this.isNotLocked()) {
        this.setRealControl(this.userControl);
      }
    }

    private function setRealControl(param1:int) : void {
      this.realControl = param1;
    }

    public function getTurretInterpolatedDirection() : Number {
      return 0;
    }

    public function getTurretPhysicsDirection() : Number {
      return 0;
    }

    public function updatePhysics(param1:Body) : void {
    }

    public function setTurretPhysicsDirection(param1:Number) : void {
    }

    public function getTurretRealControlType() : TurretControlType {
      return TurretControlType.ROTATION_DIRECTION;
    }

    public function getTurretRealControlInput() : Number {
      return 0;
    }

    public function getTurretTurnSpeedNumber() : int {
      return 0;
    }

    public function setTurretControlState(param1:TurretControlType, param2:Number, param3:int) : void {
    }

    public function setGyroscopePower(param1:Number) : void {
    }
  }
}
