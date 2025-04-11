package alternativa.tanks.models.tank.killhandlers {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import platform.client.fp10.core.type.IGameObject;

  public class RemoteTankDieHandler extends CommonTankDieHandler implements TankDieHandler, TankDeathConfirmationHandler {
    private var respawnDelay:int = 0;

    public function RemoteTankDieHandler() {
      super();
    }

    public function handleTankDie(param1:IGameObject, param2:int) : void {
      this.respawnDelay = param2;
      var local3:DeathConfirmationTimeoutTask = new DeathConfirmationTimeoutTask();
      local3.start(param1,this.handleDeathConfirmation);
    }

    public function handleDeathConfirmation(param1:IGameObject) : void {
      var local2:ITankModel = null;
      var local3:Tank = null;
      if(this.respawnDelay > 0) {
        local2 = getTankModel(param1);
        local3 = local2.getTank();
        if(local3.isInBattle()) {
          killTank(param1,this.respawnDelay);
        }
        this.respawnDelay = 0;
        local3.isLastHitPointSet = false;
      }
    }
  }
}
