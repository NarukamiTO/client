package alternativa.tanks.models.tank.spawn.spawnhandlers.spawn {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.type.IGameObject;

  public class SpectatorSpawnHandler implements SpawnHandler {
    [Inject]
    public static var battleService:BattleService;

    public function SpectatorSpawnHandler() {
      super();
    }

    public function spawn(param1:Tank, param2:IGameObject) : void {
      battleService.unlockFollowCamera();
      battleService.activateFollowCamera();
    }
  }
}
