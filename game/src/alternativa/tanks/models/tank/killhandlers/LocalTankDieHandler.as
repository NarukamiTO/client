package alternativa.tanks.models.tank.killhandlers {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.LocalTankKilledEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.physics.CollisionGroup;
  import platform.client.fp10.core.type.IGameObject;

  public class LocalTankDieHandler extends CommonTankDieHandler implements TankDieHandler {
    public function LocalTankDieHandler() {
      super();
    }

    private static function disableBonusesPickup(param1:ITankModel) : void {
      var local2:Tank = param1.getTank();
      local2.setBodyCollisionGroup(local2.getBodyCollisionGroup() & ~CollisionGroup.BONUS_WITH_TANK);
    }

    public function handleTankDie(param1:IGameObject, param2:int) : void {
      var local3:ITankModel = getTankModel(param1);
      local3.sendStateCorrection(true);
      local3.sendDeathConfirmationCommand();
      killTank(param1,param2);
      disableBonusesPickup(local3);
      battleService.lockFollowCamera();
      var local4:BattleEventDispatcher = battleEventDispatcher;
      local4.dispatchEvent(LocalTankKilledEvent.EVENT);
    }
  }
}
