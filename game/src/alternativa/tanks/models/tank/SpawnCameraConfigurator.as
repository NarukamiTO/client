package alternativa.tanks.models.tank {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.services.battlereadiness.BattleReadinessService;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class SpawnCameraConfigurator {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleReadinessService:BattleReadinessService;

    private var firstSpawn:Boolean = true;

    public function SpawnCameraConfigurator(param1:Boolean) {
      super();
      this.firstSpawn = param1;
    }

    public function setupCamera(param1:Vector3d, param2:Vector3d) : void {
      var local3:Vector3 = new Vector3(param1.x,param1.y,param1.z);
      var local4:Vector3 = new Vector3(-Math.sin(param2.z),Math.cos(param2.z),0);
      if(this.firstSpawn) {
        this.firstSpawn = false;
        battleService.activateFollowCamera();
        battleService.setFollowCameraState(local3,local4);
        battleService.lockFollowCamera();
        battleReadinessService.unlockUser();
      } else {
        battleService.activateFlyCamera(local3,local4);
      }
    }
  }
}
