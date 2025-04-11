package alternativa.tanks.models.battle.commonflag {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.Trigger;
  import alternativa.tanks.physics.CollisionGroup;

  public class FlagBaseTrigger implements Trigger {
    private static const FLAG_VISOR_HEIGHT:Number = 250;
    private static const rayHit:RayHit = new RayHit();

    private var center:Vector3;
    private var radiusSquared:Number;
    private var commonFlagModel:IFlagBaseTrigerEvents;
    private var inZone:Boolean;
    private var collisionDetector:CollisionDetector;

    public function FlagBaseTrigger(param1:Vector3, param2:Number, param3:IFlagBaseTrigerEvents, param4:CollisionDetector) {
      super();
      this.collisionDetector = param4;
      this.center = param1.clone();
      this.radiusSquared = param2 * param2;
      this.commonFlagModel = param3;
    }

    public function reset() : void {
      this.inZone = false;
    }

    public function checkTrigger(param1:Body) : void {
      var local2:Vector3 = param1.state.position;
      this.checkMineRestrictionZone(local2);
      var local3:Number = local2.x - this.center.x;
      var local4:Number = local2.y - this.center.y;
      var local5:Number = local2.z - this.center.z;
      var local6:Number = local3 * local3 + local4 * local4 + local5 * local5;
      if(this.inZone) {
        if(local6 > this.radiusSquared) {
          this.inZone = false;
          this.commonFlagModel.onLeaveFlagBaseZone();
        }
      } else if(local6 <= this.radiusSquared) {
        this.inZone = true;
        this.commonFlagModel.onEnterFlagBaseZone();
      }
    }

    private function checkMineRestrictionZone(param1:Vector3) : void {
      var local2:Number = param1.distanceToXYSquared(this.center);
      if(this.inZone) {
        if(local2 > this.radiusSquared || !this.isGroundPointInCapturingZone(param1)) {
          this.inZone = false;
          this.commonFlagModel.onLeaveFlagBaseZone();
        }
      } else if(local2 <= this.radiusSquared && this.isGroundPointInCapturingZone(param1)) {
        this.inZone = true;
        this.commonFlagModel.onEnterFlagBaseZone();
      }
    }

    private function isGroundPointInCapturingZone(param1:Vector3) : Boolean {
      var local3:Vector3 = null;
      var local4:Vector3 = null;
      var local2:Vector3 = new Vector3(this.center.x,this.center.y,this.center.z + FLAG_VISOR_HEIGHT);
      if(this.collisionDetector.raycastStatic(param1,Vector3.DOWN,CollisionGroup.STATIC,10000000000,null,rayHit)) {
        local3 = rayHit.position;
        local3.z += 0.1;
        local4 = local3.subtract(local2);
        return !this.collisionDetector.raycastStatic(local2,local4,CollisionGroup.STATIC,1,null,rayHit);
      }
      return false;
    }
  }
}
