package alternativa.tanks.battle.objects.tank.controllers {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.SimpleValueSmoother;
  import alternativa.tanks.battle.objects.tank.ValueSmoother;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.utils.DampedSpring;
  import alternativa.tanks.utils.BitMask;
  import alternativa.tanks.utils.MathUtils;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretControlType;

  public final class Turret implements WeaponMount {
    public static const TURN_SPEED_COUNT:int = 3;

    private static const ANGLE_EPSILON:Number = MathUtils.toRadians(0.5);
    private static const v:Vector3 = new Vector3();
    private static const zAxisPrev:Vector3 = new Vector3();
    private static const yAxisPrev:Vector3 = new Vector3();
    private static const yAxisNext:Vector3 = new Vector3();
    private static const tmpVector:Vector3 = new Vector3();

    private var controlType:TurretControlType = TurretControlType.ROTATION_DIRECTION;
    private var controlInput:Number = 0;
    private var realControlType:TurretControlType = TurretControlType.ROTATION_DIRECTION;
    private var realControlInput:Number = 0;
    private var maxTurnSpeedSmoother:ValueSmoother = new SimpleValueSmoother(0.3,10,0,0);
    private var maxTurnSpeed:Number = 0;
    private var turnAcceleration:Number = 0;
    private var turnSpeed:Number = 0;
    private var turnSpeedNumber:int = 3;
    private var prevDirection:Number = 0;
    private var currDirection:Number = 0;
    private var interpolatedDirection:Number = 0;
    private var prevTurnDirection:int;
    private var barrelElevation:Number = 0;
    private var gyroscopePower:Number;
    private var lockMask:BitMask = new BitMask();

    private const spring:DampedSpring = new DampedSpring(10,1,0);

    public function Turret(param1:Number, param2:Number) {
      super();
      this.setMaxTurnSpeed(param1,true);
      this.turnAcceleration = param2;
    }

    public function getTurretRealControlType() : TurretControlType {
      return this.realControlType;
    }

    public function getTurretRealControlInput() : Number {
      return this.realControlInput;
    }

    public function getTurretTurnSpeedNumber() : int {
      return this.turnSpeedNumber;
    }

    public function setTurretControlState(param1:TurretControlType, param2:Number, param3:int) : void {
      this.controlType = param1;
      this.controlInput = param2;
      this.turnSpeedNumber = param3;
      if(this.isNotLocked()) {
        this.setRealControlState(param1,param2);
      }
    }

    public function getBarrelInterpolatedElevation() : Number {
      return this.barrelElevation;
    }

    public function setBarrelElevation(param1:Number) : void {
      this.barrelElevation = param1;
    }

    public function lock(param1:int) : void {
      var local2:Boolean = this.isLocked();
      this.lockMask.change(param1,true);
      if(this.isLocked() && !local2) {
        this.setRealControlState(TurretControlType.ROTATION_DIRECTION,0);
      }
    }

    public function unlock(param1:int) : void {
      var local2:Boolean = this.isLocked();
      this.lockMask.change(param1,false);
      if(!this.isLocked() && local2) {
        this.setRealControlState(this.controlType,this.controlInput);
      }
    }

    private function setRealControlState(param1:TurretControlType, param2:Number) : void {
      this.realControlType = param1;
      this.realControlInput = param2;
    }

    public function setTurretPhysicsDirection(param1:Number) : void {
      this.currDirection = MathUtils.clampAngle(param1);
    }

    public function getTurretPhysicsDirection() : Number {
      return this.currDirection;
    }

    public function setRemoteDirection(param1:Number) : void {
      var local2:Number = MathUtils.clampAngleDelta(this.interpolatedDirection,param1);
      this.spring.resetValue(local2);
      this.prevDirection = param1;
      this.currDirection = param1;
    }

    public function rotate(param1:Number, param2:Matrix3) : void {
      var local3:Number = NaN;
      this.maxTurnSpeed = this.maxTurnSpeedSmoother.update(param1);
      this.prevDirection = this.currDirection;
      if(this.isLocked()) {
        this.turnSpeed = 0;
        return;
      }
      switch(this.realControlType) {
        case TurretControlType.ROTATION_DIRECTION:
          this.updateDirectionalRotation(param1);
          break;
        case TurretControlType.TARGET_ANGLE_LOCAL:
          this.rotateToLocalDirection(param1,this.realControlInput);
          break;
        case TurretControlType.TARGET_ANGLE_WORLD:
          local3 = this.getLocalDirectionFromWorldDirection(this.controlInput,param2);
          this.rotateToLocalDirection(param1,local3);
      }
    }

    private function updateDirectionalRotation(param1:Number) : void {
      var local2:Number = this.realControlInput;
      if(local2 == 0) {
        this.turnSpeed = 0;
      } else {
        if(this.prevTurnDirection != local2) {
          this.turnSpeed = 0;
        }
        this.currDirection = MathUtils.clampAngle(this.currDirection + this.turnSpeed * param1);
        this.turnSpeed = this.calculateTurnSpeed(this.turnSpeed,local2,param1);
      }
      this.prevTurnDirection = local2;
    }

    private function rotateToLocalDirection(param1:Number, param2:Number) : void {
      var local3:Number = MathUtils.clampAngleDelta(param2,this.currDirection);
      if(Math.abs(local3) < ANGLE_EPSILON) {
        this.currDirection = param2;
        this.turnSpeed = 0;
        return;
      }
      if(local3 * this.turnSpeed <= 0) {
        this.turnSpeed = 0;
      }
      var local4:Number = this.turnSpeed * param1;
      if(Math.abs(local4) > Math.abs(local3)) {
        this.currDirection = param2;
      } else {
        this.currDirection = MathUtils.clampAngle(this.currDirection + local4);
      }
      var local5:Number = MathUtils.sign(local3);
      this.turnSpeed = this.calculateTurnSpeed(this.turnSpeed,local5,param1);
    }

    private function calculateTurnSpeed(param1:Number, param2:Number, param3:Number) : Number {
      var local4:Number = this.maxTurnSpeed * this.turnSpeedNumber / TURN_SPEED_COUNT;
      return MathUtils.moveValueTowards(param1,param2 * local4,this.turnAcceleration * param3);
    }

    private function getLocalDirectionFromWorldDirection(param1:Number, param2:Matrix3) : Number {
      BattleUtils.fillDirectionVector(v,param1);
      v.transformTransposed3(param2);
      return BattleUtils.getDirectionAngle(v);
    }

    public function setGyroscopePower(param1:Number) : void {
      this.gyroscopePower = param1;
    }

    public function updatePhysics(param1:Body) : void {
      this.applyGyroscopeEffect(param1);
    }

    private function applyGyroscopeEffect(param1:Body) : void {
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local4:Number = NaN;
      if(this.gyroscopePower > 0) {
        param1.prevState.orientation.getYAxis(yAxisPrev);
        param1.prevState.orientation.getZAxis(zAxisPrev);
        param1.state.orientation.getYAxis(yAxisNext);
        tmpVector.cross2(yAxisNext,yAxisPrev);
        local2 = tmpVector.dot(zAxisPrev);
        local3 = yAxisPrev.dot(yAxisNext);
        local4 = Math.atan2(local2,local3);
        this.currDirection = MathUtils.clampAngle(this.currDirection + local4 * this.gyroscopePower);
      }
    }

    public function interpolate(param1:Number, param2:int) : void {
      this.spring.update(0.001 * param2,0);
      var local3:Number = MathUtils.clampAngleDelta(this.currDirection,this.prevDirection);
      this.interpolatedDirection = MathUtils.clampAngle(this.prevDirection + param1 * local3 + this.spring.value);
    }

    public function getTurretInterpolatedDirection() : Number {
      return this.interpolatedDirection;
    }

    public function isRotating() : Boolean {
      return this.turnSpeed != 0;
    }

    public function reset() : void {
      this.turnSpeed = 0;
      this.prevDirection = 0;
      this.currDirection = 0;
      this.interpolatedDirection = 0;
      this.maxTurnSpeedSmoother.reset(this.maxTurnSpeedSmoother.getTargetValue());
      this.spring.reset(0,0);
    }

    public function setMaxTurnSpeed(param1:Number, param2:Boolean) : void {
      if(param2) {
        this.maxTurnSpeed = param1;
        this.maxTurnSpeedSmoother.reset(param1);
      } else {
        this.maxTurnSpeedSmoother.setTargetValue(param1);
      }
    }

    public function setTurnAcceleration(param1:Number) : void {
      this.turnAcceleration = param1;
    }

    public function getTurnAcceleration() : Number {
      return this.turnAcceleration;
    }

    private function isLocked() : Boolean {
      return !this.lockMask.isEmpty();
    }

    private function isNotLocked() : Boolean {
      return this.lockMask.isEmpty();
    }
  }
}
