package alternativa.tanks.models.controlpoints {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.Trigger;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.physics.CollisionGroup;

  public class KeyPointTrigger implements Trigger {
    private static const rayHit:RayHit = new RayHit();

    private var center:Vector3;
    private var dominationModel:IDominationModel;
    private var capturingRadius:Number;
    private var inCapturingZone:Boolean;
    private var mineRestrictionRadius:Number;
    private var inMineRestrictionZone:Boolean;
    private var pointId:int;
    private var keypointVisorHeight:Number;
    private var collisionDetector:CollisionDetector;

    public function KeyPointTrigger(param1:Vector3, param2:Number, param3:Number, param4:int, param5:IDominationModel, param6:CollisionDetector, param7:Number) {
      super();
      this.center = param1;
      this.capturingRadius = param2;
      this.pointId = param4;
      this.dominationModel = param5;
      this.mineRestrictionRadius = param3;
      this.collisionDetector = param6;
      this.keypointVisorHeight = param7;
    }

    public function reset() : void {
      this.inCapturingZone = false;
      this.inMineRestrictionZone = false;
    }

    public function checkTrigger(param1:Body) : void {
      var local3:Vector3 = null;
      var local2:Tank = param1.tank;
      if(local2.state == ClientTankState.ACTIVE) {
        local3 = param1.state.position;
        this.checkCapturingZone(local3);
        this.checkMineRestrictionZone(local3);
      } else {
        if(this.inCapturingZone) {
          this.inCapturingZone = false;
          this.dominationModel.onLeavePointCapturingZone(this.pointId);
        }
        if(this.inMineRestrictionZone) {
          this.inMineRestrictionZone = false;
          this.dominationModel.onLeaveMineRestrictionZone(this.pointId);
        }
      }
    }

    private function checkCapturingZone(param1:Vector3) : void {
      var local2:Number = Vector3.distanceBetween(param1,this.center);
      if(this.inCapturingZone) {
        if(local2 > this.capturingRadius || !this.isTankInCapturingZone(param1)) {
          this.inCapturingZone = false;
          this.dominationModel.onLeavePointCapturingZone(this.pointId);
        }
      } else if(local2 <= this.capturingRadius && this.isTankInCapturingZone(param1)) {
        this.inCapturingZone = true;
        this.dominationModel.onEnterPointCapturingZone(this.pointId);
      }
    }

    private function checkMineRestrictionZone(param1:Vector3) : void {
      var local2:Number = param1.distanceToXY(this.center);
      if(this.inMineRestrictionZone) {
        if(local2 > this.mineRestrictionRadius || !this.isGroundPointInCapturingZone(param1)) {
          this.inMineRestrictionZone = false;
          this.dominationModel.onLeaveMineRestrictionZone(this.pointId);
        }
      } else if(local2 <= this.mineRestrictionRadius && this.isGroundPointInCapturingZone(param1)) {
        this.inMineRestrictionZone = true;
        this.dominationModel.onEnterMineRestrictionZone(this.pointId);
      }
    }

    private function isTankInCapturingZone(param1:Vector3) : Boolean {
      var local2:Vector3 = new Vector3(this.center.x,this.center.y,this.center.z + this.keypointVisorHeight);
      var local3:Vector3 = param1.clone().subtract(local2);
      return !this.collisionDetector.raycastStatic(local2,local3,CollisionGroup.STATIC,1,null,rayHit);
    }

    private function isGroundPointInCapturingZone(param1:Vector3) : Boolean {
      var local2:Vector3 = null;
      var local3:Vector3 = null;
      var local4:Vector3 = null;
      local2 = new Vector3(this.center.x,this.center.y,this.center.z + this.keypointVisorHeight);
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
