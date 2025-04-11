package alternativa.tanks.model.item.delaymountcategory {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.garage.models.item.delaymount.DelayMountCategoryModelBase;
  import projects.tanks.client.garage.models.item.delaymount.IDelayMountCategoryModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.BattleInfoServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  [ModelInfo]
  public class DelayMountCategoryModel extends DelayMountCategoryModelBase implements IDelayMountCategoryModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var delayMountCategoryService:IDelayMountCategoryService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var logService:LogService;

    public function DelayMountCategoryModel() {
      super();
    }

    private static function onBattleRestart(param1:BattleInfoServiceEvent) : void {
      delayMountCategoryService.resetTimers();
    }

    private static function onBattleUnload(param1:BattleInfoServiceEvent) : void {
      delayMountCategoryService.resetTimers();
    }

    public function objectLoadedPost() : void {
      if(lobbyLayoutService.inBattle()) {
        delayMountCategoryService.createTimers(getInitParam());
        battleInfoService.addEventListener(BattleInfoServiceEvent.BATTLE_RESTART,onBattleRestart);
        battleInfoService.addEventListener(BattleInfoServiceEvent.BATTLE_UNLOAD,onBattleUnload);
      }
    }

    public function objectUnloaded() : void {
      battleInfoService.removeEventListener(BattleInfoServiceEvent.BATTLE_RESTART,onBattleRestart);
      battleInfoService.removeEventListener(BattleInfoServiceEvent.BATTLE_UNLOAD,onBattleUnload);
      if(lobbyLayoutService.inBattle()) {
        delayMountCategoryService.destroyTimers();
      }
    }
  }
}
