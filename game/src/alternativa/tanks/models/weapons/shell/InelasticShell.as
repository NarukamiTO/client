package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.models.weapon.shared.MarginalCollider;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.utils.objectpool.Pool;
  import flash.errors.IllegalOperationError;

  public class InelasticShell extends Shell {
    protected static const _rayCastDirection:Vector3 = new Vector3();

    public function InelasticShell(param1:Pool) {
      super(param1);
    }

    override protected function update(param1:Number) : void {
      var local5:Boolean = false;
      var local6:Body = null;
      var local7:Vector3 = null;
      this.updatePosition(param1);
      _rayCastDirection.diff(currPosition,prevPosition);
      var local2:Number = _rayCastDirection.length();
      _rayCastDirection.normalize();
      var local3:CollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      if(local3.raycast(prevPosition,_rayCastDirection,CollisionGroup.WEAPON,local2,this,_rayHit)) {
        local5 = BattleUtils.isTankBody(_rayHit.shape.body) && !MarginalCollider.segmentWithStaticIntersection(prevPosition,_rayHit.position);
        _hitPoint.copy(_rayHit.position);
        if(local5) {
          local6 = _rayHit.shape.body;
        } else {
          local6 = null;
          _hitPoint.subtract(_rayCastDirection);
        }
        processHit(local6,_hitPoint,_rayCastDirection,local2);
        return;
      }
      var local4:int = 0;
      while(local4 < getNumRadialRays()) {
        local7 = radialPoints[local4];
        if(local3.raycast(local7,_rayCastDirection,CollisionGroup.WEAPON,local2,this,_rayHit)) {
          if(BattleUtils.isTankBody(_rayHit.shape.body)) {
            if(!MarginalCollider.segmentWithStaticIntersection(prevPosition,_rayHit.position)) {
              _hitPoint.copy(prevPosition).addScaled(_rayHit.t,_rayCastDirection);
              processHit(_rayHit.shape.body,_hitPoint,_rayCastDirection,local2);
              return;
            }
          }
        }
        local7.addScaled(local2,_rayCastDirection);
        local4++;
      }
      shellStates.updateState(currPosition,flightDirection);
      this.updateTotalDistance(param1);
      if(this.isFlightFinished()) {
        this.handleFlightFinish();
      }
    }

    override protected function processHitImpl(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:int) : void {
      shellStates.updateState(param2,param3,param5);
    }

    protected function updateTotalDistance(param1:Number) : void {
      totalDistance += param1 * this.getSpeed();
    }

    protected function handleFlightFinish() : void {
      destroy();
    }

    protected function isFlightFinished() : Boolean {
      return totalDistance > this.getMaxDistance();
    }

    protected function getMaxDistance() : Number {
      return Number.MAX_VALUE;
    }

    protected function getSpeed() : Number {
      throw new IllegalOperationError();
    }

    protected function updatePosition(param1:Number) : void {
      prevPosition.copy(currPosition);
      currPosition.addScaled(this.getSpeed() * param1,flightDirection);
    }
  }
}
