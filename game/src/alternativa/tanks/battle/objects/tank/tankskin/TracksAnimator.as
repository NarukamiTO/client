package alternativa.tanks.battle.objects.tank.tankskin {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.objects.tank.*;
  import alternativa.tanks.battle.objects.tank.tankchassis.SuspensionRay;
  import alternativa.tanks.battle.objects.tank.tankchassis.Track;
  import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
  import alternativa.tanks.utils.MathUtils;

  public class TracksAnimator {
    private static const MIN_TRACK_SPEED:Number = 100;
    private static const _bodyPointVelocity:Vector3 = new Vector3();

    private var chassis:TrackedChassis;
    private var skin:TankSkin;
    private var maxSpeedSmoother:ValueSmoother;

    public function TracksAnimator(param1:TrackedChassis, param2:TankSkin, param3:ValueSmoother) {
      super();
      this.chassis = param1;
      this.skin = param2;
      this.maxSpeedSmoother = param3;
    }

    public function animate(param1:Number) : void {
      this.calculateTracksAnimationSpeed(param1);
      this.skin.updateTracks(param1 * this.chassis.leftTrack.animationSpeed,param1 * this.chassis.rightTrack.animationSpeed);
    }

    private function calculateTracksAnimationSpeed(param1:Number) : void {
      this.calculateTrackAnimationSpeed(this.chassis.leftTrack,param1);
      this.calculateTrackAnimationSpeed(this.chassis.rightTrack,param1);
    }

    private function calculateTrackAnimationSpeed(param1:Track, param2:Number) : void {
      if(this.hasCorrectContacts(param1)) {
        this.animateTrackWithContacts(param1,param2);
      } else {
        this.animateTrackWithoutContacts(param1,param2);
      }
    }

    private function hasCorrectContacts(param1:Track) : Boolean {
      return param1.body.baseMatrix.m22 > 0 && param1.numContacts > 0;
    }

    private function animateTrackWithContacts(param1:Track, param2:Number) : void {
      var local4:Number = NaN;
      var local3:Number = this.getTrackSpeed(param1);
      if(this.requiresSynchronizedAnimation(param1,local3)) {
        param1.animationSpeed = local3;
      } else {
        local4 = this.getDesiredSpeedCoeff(param1) * MIN_TRACK_SPEED;
        param1.setAnimationSpeed(local4,this.chassis.getAcceleration() * param2);
      }
    }

    private function getTrackSpeed(param1:Track) : Number {
      var local2:Vector3 = param1.averageSurfaceVelocity;
      var local3:SuspensionRay = param1.rays[param1.numRays >> 1];
      this.getBodyPointVelocity(param1.body,local3.getGlobalOrigin(),_bodyPointVelocity);
      var local4:Number = _bodyPointVelocity.x - local2.x;
      var local5:Number = _bodyPointVelocity.y - local2.y;
      var local6:Number = _bodyPointVelocity.z - local2.z;
      var local7:Matrix3 = param1.body.baseMatrix;
      return local4 * local7.m01 + local5 * local7.m11 + local6 * local7.m21;
    }

    private function getBodyPointVelocity(param1:Body, param2:Vector3, param3:Vector3) : void {
      var local5:Number = NaN;
      var local8:Vector3 = null;
      var local4:Vector3 = param1.state.position;
      local5 = param2.x - local4.x;
      var local6:Number = param2.y - local4.y;
      var local7:Number = param2.z - local4.z;
      local8 = param1.state.angularVelocity;
      param3.x = local8.y * local7 - local8.z * local6;
      param3.y = local8.z * local5 - local8.x * local7;
      param3.z = local8.x * local6 - local8.y * local5;
      var local9:Vector3 = param1.state.velocity;
      param3.x += local9.x;
      param3.y += local9.y;
      param3.z += local9.z;
    }

    private function requiresSynchronizedAnimation(param1:Track, param2:Number) : Boolean {
      var local3:Number = this.getDesiredSpeedCoeff(param1);
      return Math.abs(param2) > 0.8 * MIN_TRACK_SPEED || local3 == 0 || MathUtils.numberSign(param2,1) * MathUtils.sign(local3) == -1;
    }

    private function getDesiredSpeedCoeff(param1:Track) : Number {
      var local2:int = this.chassis.getActualMovementDirection();
      var local3:int = this.chassis.getActualTurnDirection();
      var local4:Number = 0;
      if(local2 == 0) {
        local4 = param1.side * local3 * 0.5;
      } else if(local3 == 0) {
        local4 = local2;
      } else {
        local4 = local2 * (3 + param1.side * local3) / 4;
      }
      return local4;
    }

    private function animateTrackWithoutContacts(param1:Track, param2:Number) : void {
      var local3:Number = this.getDesiredSpeedCoeff(param1);
      param1.setAnimationSpeed(local3 * this.maxSpeedSmoother.getTargetValue(),this.chassis.getAcceleration() * param2);
    }
  }
}
