package alternativa.tanks.model.battleselect.create {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.controllers.battlecreate.CheckBattleNameEvent;
  import alternativa.tanks.controllers.battlecreate.CreateBattleEvent;
  import alternativa.tanks.controllers.battlecreate.CreateBattleFormController;
  import alternativa.tanks.model.map.mapinfo.MapInfoModel;
  import alternativa.tanks.service.battlecreate.BattleCreateFormServiceEvent;
  import alternativa.tanks.service.battlecreate.IBattleCreateFormService;
  import alternativa.tanks.tracker.ITrackerService;
  import flash.events.Event;
  import platform.client.fp10.core.model.IObjectLoadListener;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battleselect.model.battleselect.create.BattleCreateModelBase;
  import projects.tanks.client.battleselect.model.battleselect.create.IBattleCreateModelBase;
  import projects.tanks.client.battleservice.BattleCreateParameters;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class BattleCreateModel extends BattleCreateModelBase implements IBattleCreateModelBase, IObjectLoadListener {
    [Inject]
    public static var modelRegistry:ModelRegistry;

    [Inject]
    public static var trackerService:ITrackerService;

    [Inject]
    public static var battleCreateFormService:IBattleCreateFormService;

    [Inject]
    public static var battleAlertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userBattleSelectActionsService:UserBattleSelectActionsService;

    public function BattleCreateModel() {
      super();
    }

    public function createFailedYouAreBanned() : void {
      battleAlertService.showAlert(localeService.getText(TanksLocale.TEXT_CREATE_FAILED_YOU_ARE_BANNED),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function createFailedServerIsHalting() : void {
      battleAlertService.showAlert(localeService.getText(TanksLocale.TEXT_SERVER_IS_RESTARTING_CREATE_BATTLE_TEXT),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function createFailedTooManyBattlesFromYou() : void {
      battleAlertService.showAlert(localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_FLOOD_ALERT_TEXT),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function createFailedBattleCreateDisabled() : void {
    }

    public function objectLoaded() : void {
      battleCreateFormService.battleCreationDisabled = getInitParam().battleCreationDisabled;
    }

    public function objectLoadedPost() : void {
      var local1:CreateBattleFormController = new CreateBattleFormController(getInitParam(),MapInfoModel.getMaps());
      putData(CreateBattleFormController,local1);
      battleCreateFormService.addEventListener(BattleCreateFormServiceEvent.SHOW_FORM,getFunctionWrapper(this.onShowForm));
      battleCreateFormService.addEventListener(BattleCreateFormServiceEvent.HIDE_FORM,getFunctionWrapper(this.onHideForm));
    }

    public function objectUnloaded() : void {
      battleCreateFormService.hideForm();
      battleCreateFormService.removeEventListener(BattleCreateFormServiceEvent.SHOW_FORM,getFunctionWrapper(this.onShowForm));
      battleCreateFormService.removeEventListener(BattleCreateFormServiceEvent.HIDE_FORM,getFunctionWrapper(this.onHideForm));
      this.removeControllersListeners();
      this.getCreateBattleFormController().destroy();
      clearData(CreateBattleFormController);
    }

    public function objectUnloadedPost() : void {
    }

    private function onShowForm(param1:Event) : void {
      var local2:CreateBattleFormController = this.getCreateBattleFormController();
      local2.showForm();
      local2.addEventListener(CreateBattleEvent.CREATE_BATTLE,getFunctionWrapper(this.onCreateBattle));
      local2.addEventListener(CheckBattleNameEvent.CHECK_NAME,getFunctionWrapper(this.onCheckName));
    }

    private function onHideForm(param1:Event) : void {
      this.removeControllersListeners();
      this.getCreateBattleFormController().hideForm();
    }

    private function removeControllersListeners() : void {
      var local1:CreateBattleFormController = this.getCreateBattleFormController();
      local1.removeEventListener(CreateBattleEvent.CREATE_BATTLE,getFunctionWrapper(this.onCreateBattle));
      local1.removeEventListener(CheckBattleNameEvent.CHECK_NAME,getFunctionWrapper(this.onCheckName));
    }

    private function onCreateBattle(param1:CreateBattleEvent) : void {
      var local2:BattleCreateParameters = param1.battleCreateParams;
      userBattleSelectActionsService.createBattle(param1.battleCreateParams.battleMode);
      trackerService.trackEvent("battleList","createBattle",local2.mapId.toString());
      server.createBattle(local2);
    }

    private function getCreateBattleFormController() : CreateBattleFormController {
      return CreateBattleFormController(getData(CreateBattleFormController));
    }

    private function onCheckName(param1:CheckBattleNameEvent) : void {
      server.checkBattleNameForForbiddenWords(param1.battleName);
    }

    public function setFilteredBattleName(param1:String) : void {
      this.getCreateBattleFormController().checkedBattleNameResult(param1);
    }
  }
}
