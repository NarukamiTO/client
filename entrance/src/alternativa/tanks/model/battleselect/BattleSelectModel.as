package alternativa.tanks.model.battleselect {
  import alternativa.tanks.controllers.battlelist.BattleByURLNotFoundEvent;
  import alternativa.tanks.model.info.ShowInfo;
  import alternativa.tanks.service.battle.BattleFriendNotifier;
  import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
  import alternativa.tanks.service.battlelist.BattleListFormServiceEvent;
  import alternativa.tanks.service.battlelist.IBattleListFormService;
  import alternativa.tanks.tracker.ITrackerService;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.battleselect.BattleSelectModelBase;
  import projects.tanks.client.battleselect.model.battleselect.IBattleSelectModelBase;

  [ModelInfo]
  public class BattleSelectModel extends BattleSelectModelBase implements IBattleSelectModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var battleListFormService:IBattleListFormService;

    [Inject]
    public static var battleInfoFormService:IBattleInfoFormService;

    [Inject]
    public static var trackerService:ITrackerService;

    private var battleFriendNotifier:BattleFriendNotifier;
    private var selectTimeoutId:int = -1;

    public function BattleSelectModel() {
      super();
    }

    public function select(param1:IGameObject) : void {
      battleListFormService.selectBattleItemFromServer(param1);
      ShowInfo(param1.adapt(ShowInfo)).showInfo();
      this.clearSelectTimeout();
    }

    public function objectLoadedPost() : void {
      this.battleFriendNotifier = new BattleFriendNotifier();
      battleListFormService.createAndShow();
      battleListFormService.addEventListener(BattleListFormServiceEvent.BATTLE_SELECTED,getFunctionWrapper(this.onBattleSelected));
      battleListFormService.addEventListener(BattleByURLNotFoundEvent.BATTLE_BY_URL_NOT_FOUND,getFunctionWrapper(this.onBattleByURLNotFound));
      trackerService.trackEvent("battleList","init","");
    }

    public function objectUnloaded() : void {
      this.battleFriendNotifier.destroy();
      this.battleFriendNotifier = null;
      battleInfoFormService.destroy();
      battleListFormService.removeEventListener(BattleListFormServiceEvent.BATTLE_SELECTED,getFunctionWrapper(this.onBattleSelected));
      battleListFormService.removeEventListener(BattleByURLNotFoundEvent.BATTLE_BY_URL_NOT_FOUND,getFunctionWrapper(this.onBattleByURLNotFound));
      battleListFormService.hideAndDestroy();
      this.clearSelectTimeout();
    }

    private function onBattleSelected(param1:BattleListFormServiceEvent) : void {
      var event:BattleListFormServiceEvent = param1;
      this.clearSelectTimeout();
      this.selectTimeoutId = setTimeout(getFunctionWrapper(function():void {
        server.onSelect(event.selectedItem);
      }),1000);
      ShowInfo(event.selectedItem.adapt(ShowInfo)).showInfo();
    }

    private function onBattleByURLNotFound(param1:BattleByURLNotFoundEvent) : void {
      server.search(param1.battleId);
    }

    public function battleItemsPacketJoinSuccess() : void {
      battleListFormService.battleItemsPacketJoinSuccess();
    }

    private function clearSelectTimeout() : void {
      if(this.selectTimeoutId != -1) {
        clearTimeout(this.selectTimeoutId);
      }
      this.selectTimeoutId = -1;
    }
  }
}
