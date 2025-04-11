package alternativa.tanks.models.tank.spawn.spawnhandlers.spawn {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import platform.client.fp10.core.type.IGameObject;

  public class LocalSpawnHandler implements SpawnHandler {
    [Inject]
    public static var battleService:BattleService;

    public function LocalSpawnHandler() {
      super();
    }

    public function spawn(param1:Tank, param2:IGameObject) : void {
      var local3:ITankModel = ITankModel(param1.user.adapt(ITankModel));
      local3.addTankToExclusionSet(param1);
      battleService.unlockFollowCamera();
      battleService.activateFollowCamera();
      battleService.getBattleRunner().setLocalBody(param1.getBody());
      local3.getTitle().show();
      local3.configureRemoteTankTitles();
    }
  }
}
