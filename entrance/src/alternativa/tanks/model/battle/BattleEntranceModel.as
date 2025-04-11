package alternativa.tanks.model.battle {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.model.info.param.BattleParams;
  import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
  import alternativa.tanks.tracker.ITrackerService;
  import projects.tanks.client.battleselect.model.battle.entrance.BattleEntranceModelBase;
  import projects.tanks.client.battleselect.model.battle.entrance.IBattleEntranceModelBase;
  import projects.tanks.client.battleservice.BattleCreateParameters;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class BattleEntranceModel extends BattleEntranceModelBase implements IBattleEntranceModelBase, BattleEntrance {
    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var battleAlertService:IAlertService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    [Inject]
    public static var battleInfoFormService:IBattleInfoFormService;

    [Inject]
    public static var trackerService:ITrackerService;

    [Inject]
    public static var userBattleSelectActionsService:UserBattleSelectActionsService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    public function BattleEntranceModel() {
      super();
    }

    public function equipmentNotMatchConstraints() : void {
      modalLoaderService.hideForcibly();
      loaderWindowService.hideForcibly();
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_BATTLE_ENTER_ERROR_EQUIPMENT_NOT_MATCH_CONSTRAINTS),Vector.<String>([localeService.getText(TanksLocale.TEXT_CLOSE_LABEL)]));
    }

    public function enterToBattleFailed() : void {
      modalLoaderService.hideForcibly();
      loaderWindowService.hideForcibly();
    }

    public function fightFailedServerIsHalting() : void {
      modalLoaderService.hideForcibly();
      loaderWindowService.hideForcibly();
      battleAlertService.showAlert(localeService.getText(TanksLocale.TEXT_SERVER_IS_RESTARTING_CREATE_BATTLE_TEXT),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function fight(param1:BattleTeam = null) : void {
      trackerService.trackEvent("battleList",param1 != null ? "StartTeamBattle" : "StartDMBattle","");
      var local2:BattleCreateParameters = BattleParams(object.adapt(BattleParams)).getConstructor().params;
      userBattleSelectActionsService.enterToBattle(local2.battleMode,object.id);
      if(local2.parkourMode) {
        putData(BattleTeam,param1);
        this.showParkourAlert();
      } else {
        this.sendToServer(param1);
      }
    }

    public function enterAsSpectator() : void {
      server.joinAsSpectator();
    }

    private function sendToServer(param1:BattleTeam) : void {
      if(param1 == null) {
        param1 = BattleTeam.NONE;
      }
      server.fight(param1);
    }

    private function showParkourAlert() : void {
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,getFunctionWrapper(this.onParkourAlertButtonPressed));
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_BATTLE_ENTER_WARNING_PARKOUR),Vector.<String>([localeService.getText(TanksLocale.TEXT_BATTLE_ENTER_WARNING_PARKOUR_BUTTON_ENTER),localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_CANCEL)]));
    }

    private function onParkourAlertButtonPressed(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,getFunctionWrapper(this.onParkourAlertButtonPressed));
      if(param1.typeButton == localeService.getText(TanksLocale.TEXT_BATTLE_ENTER_WARNING_PARKOUR_BUTTON_ENTER)) {
        this.sendToServer(BattleTeam(getData(BattleTeam)));
      }
    }
  }
}
