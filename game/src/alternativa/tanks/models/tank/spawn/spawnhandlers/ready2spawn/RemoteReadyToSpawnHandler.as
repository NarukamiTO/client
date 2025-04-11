package alternativa.tanks.models.tank.spawn.spawnhandlers.ready2spawn {
  import alternativa.tanks.models.tank.ITankModel;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;

  public class RemoteReadyToSpawnHandler implements ReadyToSpawnHandler, AutoClosable {
    private var gameObject:IGameObject;

    public function RemoteReadyToSpawnHandler(param1:IGameObject) {
      super();
      this.gameObject = param1;
    }

    public function handleReadyToSpawn() : void {
      var local1:ITankModel = ITankModel(this.gameObject.adapt(ITankModel));
      local1.removeTankFromBattle();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.gameObject = null;
    }
  }
}
