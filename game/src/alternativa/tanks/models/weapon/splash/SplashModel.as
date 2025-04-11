package alternativa.tanks.models.weapon.splash {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.WeaponConst;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.physics.TankBody;
  import alternativa.tanks.physics.TanksCollisionDetector;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.tankparts.weapon.splash.ISplashModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashModelBase;

  [ModelInfo]
  public class SplashModel extends SplashModelBase implements ISplashModelBase, ObjectLoadListener, Splash {
    [Inject]
    public static var battleService:BattleService;

    private static const vectorToTarget:Vector3 = new Vector3();
    private static const forceDirection:Vector3 = new Vector3();
    private static const vector:Vector3 = new Vector3();
    private static const rayHit:RayHit = new RayHit();

    public function SplashModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:SplashCC = getInitParam();
      var local2:SplashParams = null;
      if(local1 != null) {
        local2 = new SplashParams(BattleUtils.toClientScale(local1.radiusOfMaxSplashDamage),BattleUtils.toClientScale(local1.splashDamageRadius),local1.minSplashDamagePercent,local1.impactForce * WeaponConst.BASE_IMPACT_FORCE.getNumber());
      }
      putData(SplashParams,local2);
    }

    public function applySplashForce(param1:Vector3, param2:Number, param3:Body, param4:SplashParams = null) : Boolean {
      var local7:TankBody = null;
      var local8:Body = null;
      var local9:Tank = null;
      var local10:Vector3 = null;
      var local11:Number = NaN;
      if(param4 == null) {
        param4 = SplashParams(getData(SplashParams));
        if(param4 == null) {
          return false;
        }
      }
      var local5:Number = param4.getSplashRadius() * param4.getSplashRadius();
      var local6:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      for each(local7 in local6.getTankBodies()) {
        local8 = local7.body;
        local9 = local8.tank;
        if(local9.state == ClientTankState.ACTIVE && local8 != param3) {
          local10 = local9.getBody().state.position;
          vectorToTarget.diff(local10,param1);
          local11 = vectorToTarget.lengthSqr();
          if(local11 <= local5) {
            if(!this.isTankOccluded(local9,param1)) {
              forceDirection.copy(vectorToTarget);
              forceDirection.normalize();
              local9.applyWeaponHit(local9.getBody().state.position,forceDirection,param2 * param4.getImpactForce(Math.sqrt(local11)));
            }
          }
        }
      }
      return true;
    }

    private function isTankOccluded(param1:Tank, param2:Vector3) : Boolean {
      var local3:Body = param1.getBody();
      var local4:Number = 0.75 * param1.getHalfLength();
      return this.isPointOccluded(param2,local3,0) && this.isPointOccluded(param2,local3,-local4) && this.isPointOccluded(param2,local3,local4);
    }

    private function isPointOccluded(param1:Vector3, param2:Body, param3:Number) : Boolean {
      vector.reset(0,param3,0);
      vector.transform3(param2.baseMatrix);
      vector.add(param2.state.position);
      vector.subtract(param1);
      var local4:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      return local4.raycastStatic(param1,vector,CollisionGroup.STATIC,1,null,rayHit);
    }
  }
}
