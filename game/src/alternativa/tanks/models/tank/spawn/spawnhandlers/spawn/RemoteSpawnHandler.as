package alternativa.tanks.models.tank.spawn.spawnhandlers.spawn {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import platform.client.fp10.core.type.IGameObject;

  public class RemoteSpawnHandler implements SpawnHandler {
    public function RemoteSpawnHandler() {
      super();
    }

    public function spawn(param1:Tank, param2:IGameObject) : void {
      var local3:ITankModel = ITankModel(param1.user.adapt(ITankModel));
      local3.addTankToExclusionSet(param1);
      local3.configureTankTitleAsRemote(param1.user);
    }
  }
}
