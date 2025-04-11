package alternativa.tanks.battle.objects.tank.tankchassis {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.objects.tank.TankConst;
  import alternativa.tanks.battle.objects.tank.ValueSmoother;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;
  import alternativa.tanks.utils.MathUtils;

  public class TrackedChassis {
    public static const TURN_SPEED_COUNT:int = 7;

    private static const MIN_ACCELERATION:Number = 400;
    private static const _xAxis:Vector3 = new Vector3();
    private static const _yAxis:Vector3 = new Vector3();
    private static const _zAxis:Vector3 = new Vector3();
    private static const _surfaceVelocity:Vector3 = new Vector3();
    private static const _surfaceAngularVelocity:Vector3 = new Vector3();
    private static const _relativeVelocity:Vector3 = new Vector3();
    private static const _relativeAngularVelocity:Vector3 = new Vector3();
    private static const _forceVector:Vector3 = new Vector3();
    private static const _midPoint:Vector3 = new Vector3();

    private var body:Body;
    private var suspensionParams:SuspensionParams;
    private var maxSpeedSmoother:ValueSmoother;

    public var leftTrack:Track;
    public var rightTrack:Track;
    public var movementDirection:int;
    public var turnDirection:int;
    public var turnSpeedNumber:int;
    public var inverseBackTurnMovement:Boolean;

    private const _acceleration:EncryptedNumber = new EncryptedNumberImpl();
    private const _reverseAcceleration:EncryptedNumber = new EncryptedNumberImpl();
    private const _sideAcceleration:EncryptedNumber = new EncryptedNumberImpl();
    private const _turnAcceleration:EncryptedNumber = new EncryptedNumberImpl();
    private const _reverseTurnAcceleration:EncryptedNumber = new EncryptedNumberImpl();
    private const _stabilizationAcceleration:EncryptedNumber = new EncryptedNumberImpl();

    public function TrackedChassis(param1:Body, param2:SuspensionParams, param3:ValueSmoother, param4:Vector3) {
      super();
      this.body = param1;
      this.suspensionParams = param2;
      this.maxSpeedSmoother = param3;
      this.createTracks(TankConst.NUM_RAYS_PER_TRACK,param4);
    }

    private function createTracks(param1:int, param2:Vector3) : void {
      var local3:Number = param2.y * 0.8;
      var local4:Number = param2.x - 40;
      this.leftTrack = new Track(this.body,param1,new Vector3(-0.5 * local4,0,-0.5 * param2.z + TankConst.RAY_OFFSET),local3,this.suspensionParams,-1);
      this.rightTrack = new Track(this.body,param1,new Vector3(0.5 * local4,0,-0.5 * param2.z + TankConst.RAY_OFFSET),local3,this.suspensionParams,1);
    }

    public function setAcceleration(param1:Number) : void {
      this._acceleration.setNumber(param1);
    }

    public function setReverseAcceleration(param1:Number) : void {
      this._reverseAcceleration.setNumber(param1);
    }

    public function setSideAcceleration(param1:Number) : void {
      this._sideAcceleration.setNumber(param1);
    }

    public function setTurnAcceleration(param1:Number) : void {
      this._turnAcceleration.setNumber(param1);
    }

    public function setReverseTurnAcceleration(param1:Number) : void {
      this._reverseTurnAcceleration.setNumber(param1);
    }

    public function setStabilizationAcceleration(param1:Number) : void {
      this._stabilizationAcceleration.setNumber(param1);
    }

    public function getAcceleration() : Number {
      return this._acceleration.getNumber();
    }

    public function getActualMovementDirection() : int {
      return this.movementDirection;
    }

    public function getActualTurnDirection() : int {
      return this.turnDirection;
    }

    public function setTracksCollisionGroup(param1:int) : void {
      this.leftTrack.setCollisionGroup(param1);
      this.rightTrack.setCollisionGroup(param1);
    }

    public function applyForces(param1:Number, param2:Number, param3:Number) : void {
      this.adjustSuspensionSpringCoeff();
      this.calculateSuspensionContacts(param3);
      this.applyMovementForces(param1,param2,param3);
      this.applySlopeHack();
    }

    private function adjustSuspensionSpringCoeff() : void {
      var local1:Number = this.body.scene.gravity.length() * this.body.mass;
      this.suspensionParams.springCoeff = local1 / (2 * TankConst.NUM_RAYS_PER_TRACK * (this.suspensionParams.maxRayLength - this.suspensionParams.nominalRayLength));
    }

    private function calculateSuspensionContacts(param1:Number) : void {
      this.leftTrack.calculateSuspensionContacts(param1);
      this.rightTrack.calculateSuspensionContacts(param1);
    }

    private function applyMovementForces(param1:Number, param2:Number, param3:Number) : void {
      if(this.leftTrack.numContacts + this.rightTrack.numContacts > 0) {
        this.doApplyMovementForces(param1,param2,param3);
      }
    }

    private function doApplyMovementForces(param1:Number, param2:Number, param3:Number) : void {
      var local4:Vector3 = null;
      var local5:Vector3 = null;
      var local6:Matrix3 = null;
      var local7:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:int = 0;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Number = NaN;
      var local30:int = 0;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Number = NaN;
      local4 = this.body.state.velocity;
      local5 = this.body.state.angularVelocity;
      local6 = this.body.baseMatrix;
      _xAxis.x = local6.m00;
      _xAxis.y = local6.m10;
      _xAxis.z = local6.m20;
      _yAxis.x = local6.m01;
      _yAxis.y = local6.m11;
      _yAxis.z = local6.m21;
      _zAxis.x = local6.m02;
      _zAxis.y = local6.m12;
      _zAxis.z = local6.m22;
      local7 = 1;
      var local8:Number = Math.PI / 4;
      var local9:Number = TankConst.MAX_SLOPE_ANGLE;
      if(_zAxis.z < Math.cos(local8)) {
        if(_zAxis.z < Math.cos(local9)) {
          local7 = 0;
        } else {
          local7 = (local9 - Math.acos(_zAxis.z)) / (local9 - local8);
        }
      }
      this.calculateSurfaceVelocities(_surfaceVelocity,_surfaceAngularVelocity);
      _relativeVelocity.x = local4.x - _surfaceVelocity.x;
      _relativeVelocity.y = local4.y - _surfaceVelocity.y;
      _relativeVelocity.z = local4.z - _surfaceVelocity.z;
      _relativeAngularVelocity.x = local5.x - _surfaceAngularVelocity.x;
      _relativeAngularVelocity.y = local5.y - _surfaceAngularVelocity.y;
      _relativeAngularVelocity.z = local5.z - _surfaceAngularVelocity.z;
      var local10:Number = _relativeVelocity.x * _yAxis.x + _relativeVelocity.y * _yAxis.y + _relativeVelocity.z * _yAxis.z;
      var local11:Number = _relativeAngularVelocity.x * _zAxis.x + _relativeAngularVelocity.y * _zAxis.y + _relativeAngularVelocity.z * _zAxis.z;
      var local12:Number = _relativeVelocity.x * _xAxis.x + _relativeVelocity.y * _xAxis.y + _relativeVelocity.z * _xAxis.z;
      var local13:Number = this._sideAcceleration.getNumber() * local7 * param3;
      if(local12 < 0) {
        if(local13 > -local12) {
          local12 = 0;
        } else {
          local12 += local13;
        }
      } else if(local12 > 0) {
        if(local13 > local12) {
          local12 = 0;
        } else {
          local12 -= local13;
        }
      }
      _relativeVelocity.setLengthAlongDirection(_xAxis,local12);
      local4.x = _surfaceVelocity.x + _relativeVelocity.x;
      local4.y = _surfaceVelocity.y + _relativeVelocity.y;
      local4.z = _surfaceVelocity.z + _relativeVelocity.z;
      var local14:int = this.leftTrack.numContacts;
      var local15:int = this.rightTrack.numContacts;
      var local16:Number = Number(this._acceleration.getNumber());
      var local17:Number = Number(this._turnAcceleration.getNumber());
      if(local14 > 0 || local15 > 0) {
        local18 = 0;
        if(this.movementDirection == 0) {
          local18 = -MathUtils.sign(local10) * local16 * param3;
          if(MathUtils.sign(local10) != MathUtils.sign(local10 + local18)) {
            local18 = -local10;
          }
        } else {
          if(MathUtils.sign(local10) * MathUtils.sign(this.movementDirection) < 0) {
            local16 = Number(this._reverseAcceleration.getNumber());
          }
          local18 = this.movementDirection * local16 * param3;
        }
        local19 = MathUtils.clamp(local10 + local18,-param1,param1);
        local20 = local19 - local10;
        local21 = 1;
        local22 = MathUtils.clamp(1 - Math.abs(local10 / param1),0,1);
        if(local22 < local21 && this.movementDirection * MathUtils.sign(local10) > 0) {
          local20 *= local22 / local21;
        }
        local23 = local20 / param3;
        if(Math.abs(local23) < MIN_ACCELERATION && Math.abs(local19) > 0.5 * this.maxSpeedSmoother.getTargetValue()) {
          local23 = MathUtils.numberSign(local23,0.1) * MIN_ACCELERATION;
        }
        local24 = local23 * this.body.mass;
        local25 = local14 + local15;
        local26 = local24 * (local25 + 0.21 * (20 - local25)) / 10;
        local27 = local26 / local25;
        local28 = Math.PI / 4;
        local29 = Math.PI / 3;
        local30 = 0;
        while(local30 < TankConst.NUM_RAYS_PER_TRACK) {
          this.applyForceFromRay(this.leftTrack.rays[local30],_yAxis,local27,local29,local28);
          this.applyForceFromRay(this.rightTrack.rays[local30],_yAxis,local27,local29,local28);
          local30++;
        }
        local31 = 1;
        if(local14 == 0 || local15 == 0) {
          local31 = 0.5;
        }
        local32 = 0;
        if(this.turnDirection == 0) {
          local32 = -MathUtils.sign(local11) * this._stabilizationAcceleration.getNumber() * local7 * param3;
          if(MathUtils.sign(local11) != MathUtils.sign(local11 + local32)) {
            local32 = -local11;
          }
        } else {
          if(this.isReversedTurn(this.turnDirection,local11,this.movementDirection,this.inverseBackTurnMovement)) {
            local17 = Number(this._reverseTurnAcceleration.getNumber());
          }
          local32 = this.turnDirection * local17 * local7 * param3;
          if(this.movementDirection == -1 && this.inverseBackTurnMovement) {
            local32 = -local32;
          }
        }
        local33 = param2;
        if(this.turnDirection != 0) {
          local33 = param2 * this.turnSpeedNumber / TURN_SPEED_COUNT;
        }
        local34 = local33 * local31;
        local35 = MathUtils.clamp(local11 + local32,-local34,local34);
        _relativeAngularVelocity.setLengthAlongDirection(_zAxis,local35);
        local5.x = _surfaceAngularVelocity.x + _relativeAngularVelocity.x;
        local5.y = _surfaceAngularVelocity.y + _relativeAngularVelocity.y;
        local5.z = _surfaceAngularVelocity.z + _relativeAngularVelocity.z;
      }
    }

    private function isReversedTurn(param1:int, param2:Number, param3:int, param4:Boolean) : Boolean {
      var local5:int = param4 && param3 < 0 ? -1 : 1;
      return param1 * param2 * local5 < 0;
    }

    private function calculateSurfaceVelocities(param1:Vector3, param2:Vector3) : void {
      var local4:SuspensionRay = null;
      var local5:int = 0;
      var local6:Vector3 = null;
      var local3:Number = 1 / (this.leftTrack.numContacts + this.rightTrack.numContacts);
      var local7:Number = 0;
      var local8:Number = 0;
      var local9:Number = 0;
      local5 = 0;
      while(local5 < TankConst.NUM_RAYS_PER_TRACK) {
        local4 = this.leftTrack.rays[local5];
        if(local4.hasCollision) {
          local6 = local4.rayHit.position;
          local7 += local6.x;
          local8 += local6.y;
          local9 += local6.z;
        }
        local4 = this.rightTrack.rays[local5];
        if(local4.hasCollision) {
          local6 = local4.rayHit.position;
          local7 += local6.x;
          local8 += local6.y;
          local9 += local6.z;
        }
        local5++;
      }
      local7 *= local3;
      local8 *= local3;
      local9 *= local3;
      _midPoint.x = local7;
      _midPoint.y = local8;
      _midPoint.z = local9;
      param1.x = 0;
      param1.y = 0;
      param1.z = 0;
      param2.x = 0;
      param2.y = 0;
      param2.z = 0;
      local5 = 0;
      while(local5 < TankConst.NUM_RAYS_PER_TRACK) {
        this.addVelocitiesFromRay(this.leftTrack.rays[local5],_midPoint,param1,param2);
        this.addVelocitiesFromRay(this.rightTrack.rays[local5],_midPoint,param1,param2);
        local5++;
      }
      param1.x *= local3;
      param1.y *= local3;
      param1.z *= local3;
      param2.x *= local3;
      param2.y *= local3;
      param2.z *= local3;
    }

    private function addVelocitiesFromRay(param1:SuspensionRay, param2:Vector3, param3:Vector3, param4:Vector3) : void {
      var local5:Vector3 = null;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Vector3 = null;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      if(param1.hasCollision) {
        param3.x += param1.contactVelocity.x;
        param3.y += param1.contactVelocity.y;
        param3.z += param1.contactVelocity.z;
        local5 = param1.rayHit.position;
        local6 = local5.x - param2.x;
        local7 = local5.y - param2.y;
        local8 = local5.z - param2.z;
        local9 = local6 * local6 + local7 * local7 + local8 * local8;
        if(local9 > 1) {
          local10 = 1 / local9;
          local11 = param1.contactVelocity;
          local12 = (local7 * local11.z - local8 * local11.y) * local10;
          local13 = (local8 * local11.x - local6 * local11.z) * local10;
          local14 = (local6 * local11.y - local7 * local11.x) * local10;
          param4.x += local12;
          param4.y += local13;
          param4.z += local14;
        }
      }
    }

    private function applyForceFromRay(param1:SuspensionRay, param2:Vector3, param3:Number, param4:Number, param5:Number) : void {
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      if(param1.hasCollision) {
        local6 = param2.x;
        local7 = param2.y;
        local8 = param2.z;
        local9 = local6 * local6 + local7 * local7 + local8 * local8;
        if(local9 > 0.00001) {
          local10 = Math.acos(param1.rayHit.normal.z);
          if(local10 < 0) {
            local10 = -local10;
          }
          if(local10 < param4) {
            local11 = param3 / Math.sqrt(local9);
            if(local10 > param5) {
              local11 *= (param4 - local10) / (param4 - param5);
            }
            _forceVector.x = local6 * local11;
            _forceVector.y = local7 * local11;
            _forceVector.z = local8 * local11;
            this.body.addWorldForceAtLocalPoint(param1.getOrigin(),_forceVector);
          }
        }
      }
    }

    private function applySlopeHack() : void {
      var local1:Matrix3 = null;
      var local2:Vector3 = null;
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      if(this.rightTrack.numContacts >= this.rightTrack.numRays >> 1 || this.leftTrack.numContacts >= this.leftTrack.numRays >> 1) {
        local1 = this.body.baseMatrix;
        local2 = this.body.scene.gravity;
        local3 = local2.x * local1.m02 + local2.y * local1.m12 + local2.z * local1.m22;
        local4 = local2.length();
        local5 = Math.SQRT1_2 * local4;
        if(local3 < -local5 || local3 > local5) {
          local6 = (local1.m02 * local3 - local2.x) * this.body.mass;
          local7 = (local1.m12 * local3 - local2.y) * this.body.mass;
          local8 = (local1.m22 * local3 - local2.z) * this.body.mass;
          this.body.addForceXYZ(local6,local7,local8);
        }
      }
    }
  }
}
