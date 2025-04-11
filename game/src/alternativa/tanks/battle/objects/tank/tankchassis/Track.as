package alternativa.tanks.battle.objects.tank.tankchassis {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleUtils;

  public class Track {
    public var body:Body;
    public var rays:Vector.<SuspensionRay>;
    public var numRays:int;
    public var numContacts:int;
    public var suspensionParams:SuspensionParams;
    public var animationSpeed:Number = 0;
    public var side:int;

    public const averageSurfaceVelocity:Vector3 = new Vector3();

    public function Track(param1:Body, param2:int, param3:Vector3, param4:Number, param5:SuspensionParams, param6:int) {
      super();
      this.body = param1;
      this.side = param6;
      this.setTrackParams(param2,param3,param4,param5);
    }

    private function setTrackParams(param1:int, param2:Vector3, param3:Number, param4:SuspensionParams) : void {
      var local7:Vector3 = null;
      this.numRays = param1;
      this.suspensionParams = param4;
      this.rays = new Vector.<SuspensionRay>(param1);
      var local5:Number = param3 / (param1 - 1);
      var local6:int = 0;
      while(local6 < param1) {
        local7 = new Vector3(param2.x,param2.y + 0.5 * param3 - local6 * local5,param2.z);
        this.rays[local6] = new SuspensionRay(this.body,local7,Vector3.DOWN,param4);
        local6++;
      }
    }

    public function setCollisionGroup(param1:int) : void {
      var local2:int = 0;
      while(local2 < this.numRays) {
        SuspensionRay(this.rays[local2]).collisionGroup = param1;
        local2++;
      }
    }

    public function hasContactsWithStatic() : Boolean {
      var local1:SuspensionRay = null;
      for each(local1 in this.rays) {
        if(local1.hasCollision && !BattleUtils.isTankBody(local1.rayHit.shape.body)) {
          return true;
        }
      }
      return false;
    }

    public function calculateSuspensionContacts(param1:Number) : void {
      var local4:SuspensionRay = null;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      this.numContacts = 0;
      this.averageSurfaceVelocity.x = 0;
      this.averageSurfaceVelocity.y = 0;
      this.averageSurfaceVelocity.z = 0;
      var local2:Vector3 = this.body.state.velocity;
      var local3:int = 0;
      while(local3 < this.numRays) {
        local4 = this.rays[local3];
        local4.update(param1);
        if(local4.hasCollision) {
          ++this.numContacts;
          this.body.addWorldForceScaled(local4.getGlobalOrigin(),local4.getGlobalDirection(),-local4.springForce);
          this.averageSurfaceVelocity.x += local4.contactVelocity.x;
          this.averageSurfaceVelocity.y += local4.contactVelocity.y;
          this.averageSurfaceVelocity.z += local4.contactVelocity.z;
          local5 = local2.x - local4.contactVelocity.x;
          local6 = local2.y - local4.contactVelocity.y;
          local7 = local2.z - local4.contactVelocity.z;
          local4.speed = Math.sqrt(local5 * local5 + local6 * local6 + local7 * local7);
        } else {
          local4.speed = 0;
        }
        local3++;
      }
      if(this.numContacts > 1) {
        this.averageSurfaceVelocity.x /= this.numContacts;
        this.averageSurfaceVelocity.y /= this.numContacts;
        this.averageSurfaceVelocity.z /= this.numContacts;
      }
    }

    public function setAnimationSpeed(param1:Number, param2:Number) : void {
      var local3:Number = NaN;
      if(this.animationSpeed < param1) {
        local3 = this.animationSpeed + param2;
        this.animationSpeed = local3 > param1 ? param1 : local3;
      } else if(this.animationSpeed > param1) {
        local3 = this.animationSpeed - param2;
        this.animationSpeed = local3 < param1 ? param1 : local3;
      }
    }
  }
}
