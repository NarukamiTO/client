package alternativa.tanks.models.tank.killhandlers {
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.death.TankDeadEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.TankControlLockBits;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.configuration.TankConfiguration;
  import alternativa.tanks.models.tank.explosion.ITankExplosionModel;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.models.tank.spawn.ReadyToSpawnTask;
  import alternativa.tanks.sfx.LightAnimation;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class CommonTankDieHandler {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    public function CommonTankDieHandler() {
      super();
    }

    protected static function getTankModel(param1:IGameObject) : ITankModel {
      return ITankModel(param1.adapt(ITankModel));
    }

    private static function createDeathEffects(param1:Tank) : void {
      param1.getBody().clearAccumulators();
      param1.getBody().state.velocity.z = param1.getBody().state.velocity.z + 500;
      param1.getBody().state.angularVelocity.reset(2,2,2);
      param1.getSkin().setDeadState();
      var local2:TankConfiguration = TankConfiguration(param1.user.adapt(TankConfiguration));
      var local3:IGameObject = local2.getHullObject();
      var local4:ITankExplosionModel = ITankExplosionModel(local3.adapt(ITankExplosionModel));
      local4.createExplosionEffects(local3,param1,getExplosionAnimation(local3));
    }

    private static function getExplosionAnimation(param1:IGameObject) : LightAnimation {
      var local2:LightingSFXEntity = HullCommon(param1.adapt(HullCommon)).getCC().lightingSFXEntity;
      return new LightingSfx(local2).createAnimation("explosion");
    }

    protected function killTank(param1:IGameObject, param2:int) : void {
      var local3:ITankModel = getTankModel(param1);
      local3.lockMovementControl(TankControlLockBits.DEAD);
      local3.getWeaponController().lockWeapon(TankControlLockBits.DEAD,false);
      local3.getWeaponController().deactivateWeapon();
      var local4:Tank = local3.getTank();
      local4.kill();
      var local5:BattleRunner = battleService.getBattleRunner();
      local5.addLogicUnit(new ReadyToSpawnTask(getTimer() + param2,local4));
      createDeathEffects(local4);
      battleEventDispatcher.dispatchEvent(new TankDeadEvent(param1));
    }
  }
}
