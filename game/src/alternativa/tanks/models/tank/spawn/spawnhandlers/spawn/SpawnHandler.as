package alternativa.tanks.models.tank.spawn.spawnhandlers.spawn {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.type.IGameObject;

  public interface SpawnHandler {
    function spawn(param1:Tank, param2:IGameObject) : void;
  }
}
