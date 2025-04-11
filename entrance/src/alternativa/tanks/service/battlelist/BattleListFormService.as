package alternativa.tanks.service.battlelist {
  import alternativa.tanks.controllers.battlelist.BattleByURLNotFoundEvent;
  import alternativa.tanks.controllers.battlelist.BattleListController;
  import alternativa.tanks.controllers.battlelist.BattleSelectedEvent;
  import alternativa.tanks.controllers.battlelist.CreateBattleClickEvent;
  import alternativa.tanks.service.battlecreate.IBattleCreateFormService;
  import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;

  public class BattleListFormService extends EventDispatcher implements IBattleListFormService {
    [Inject]
    public static var battleCreateFormService:IBattleCreateFormService;

    [Inject]
    public static var battleInfoFormService:IBattleInfoFormService;

    private var battleListController:BattleListController;

    public function BattleListFormService() {
      super();
    }

    public function createAndShow() : void {
      this.battleListController = new BattleListController();
      this.battleListController.showForm();
      this.battleListController.addEventListener(CreateBattleClickEvent.CREATE_BATTLE_CLICK,this.onCreateBattleClick);
      this.battleListController.addEventListener(BattleSelectedEvent.BATTLE_SELECTED,this.onBattleSelected);
      this.battleListController.addEventListener(BattleByURLNotFoundEvent.BATTLE_BY_URL_NOT_FOUND,this.onBattleByURLNotFound);
    }

    public function hideAndDestroy() : void {
      this.battleListController.removeEventListener(CreateBattleClickEvent.CREATE_BATTLE_CLICK,this.onCreateBattleClick);
      this.battleListController.removeEventListener(BattleSelectedEvent.BATTLE_SELECTED,this.onBattleSelected);
      this.battleListController.removeEventListener(BattleByURLNotFoundEvent.BATTLE_BY_URL_NOT_FOUND,this.onBattleByURLNotFound);
      this.battleListController.hideForm();
      this.battleListController.destroy();
      this.battleListController = null;
    }

    public function battleItemRecord(param1:BattleInfoBaseParams) : void {
      this.battleListController.battleItemRecord(param1);
    }

    public function selectBattleItemFromServer(param1:IGameObject) : void {
      this.battleListController.selectBattleItemFromServer(param1);
    }

    public function updateSuspicious(param1:Long, param2:BattleSuspicionLevel) : void {
      this.battleListController.updateSuspicious(param1,param2);
    }

    public function removeBattleItem(param1:Long) : void {
      this.battleListController.removeBattle(param1);
    }

    public function updateUsersCount(param1:Long) : void {
      this.battleListController.updateUsersCount(param1);
    }

    public function updateBattleName(param1:Long) : void {
      this.battleListController.updateBattleName(param1);
    }

    private function onBattleSelected(param1:BattleSelectedEvent) : void {
      dispatchEvent(new BattleListFormServiceEvent(BattleListFormServiceEvent.BATTLE_SELECTED,param1.selectedItem));
      battleCreateFormService.hideForm();
    }

    private function onBattleByURLNotFound(param1:BattleByURLNotFoundEvent) : void {
      dispatchEvent(new BattleByURLNotFoundEvent(BattleByURLNotFoundEvent.BATTLE_BY_URL_NOT_FOUND,param1.battleId));
    }

    public function swapTeams(param1:Long) : void {
      this.battleListController.swapTeams(param1);
    }

    public function battleItemsPacketJoinSuccess() : void {
      this.battleListController.battleItemsPacketJoinSuccess();
    }

    private function onCreateBattleClick(param1:CreateBattleClickEvent) : void {
      battleCreateFormService.showForm();
      battleInfoFormService.removeFormFromStage();
    }

    public function checkBattleButton() : void {
      this.battleListController.resetBattleButtonState();
    }
  }
}
