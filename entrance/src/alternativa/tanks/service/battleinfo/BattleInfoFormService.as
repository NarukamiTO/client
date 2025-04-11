package alternativa.tanks.service.battleinfo {
  import alternativa.tanks.controllers.battleinfo.BattleInfoDMController;
  import alternativa.tanks.controllers.battleinfo.BattleInfoTeamController;
  import alternativa.tanks.controllers.battleinfo.EmptyBattleInfoController;
  import alternativa.tanks.controllers.battleinfo.IBattleInfoController;
  import alternativa.tanks.model.battle.BattleEntrance;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.view.battleinfo.BattleInfoViewEvent;
  import alternativa.tanks.view.battleinfo.dm.BattleInfoDmParams;
  import alternativa.tanks.view.battleinfo.team.BattleInfoTeamParams;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class BattleInfoFormService extends EventDispatcher implements IBattleInfoFormService {
    [Inject]
    public static var trackerService:ITrackerService;

    private static const GA_CATEGORY:String = "lobby";
    private static const EMPTY_CONTROLLER:EmptyBattleInfoController = new EmptyBattleInfoController();

    private var dmController:BattleInfoDMController;
    private var teamController:BattleInfoTeamController;
    private var formState:BattleInfoState = BattleInfoState.NONE;

    public function BattleInfoFormService() {
      super();
    }

    public function showLastShowedForm() : void {
      this.getCurrentBattleInfoController().addFormToStage();
    }

    public function removeFormFromStage() : void {
      this.getCurrentBattleInfoController().removeFormFromStage();
    }

    public function showDmForm(param1:BattleInfoDmParams) : void {
      if(this.dmController == null) {
        this.dmController = new BattleInfoDMController();
        this.addEventListeners(this.dmController);
      }
      this.hideForms();
      this.dmController.showForm(param1);
      this.formState = BattleInfoState.DM_FORM;
    }

    private function addEventListeners(param1:IBattleInfoController) : void {
      param1.addEventListener(BattleInfoViewEvent.ENTER_BATTLE,this.onEnterBattle);
      param1.addEventListener(BattleInfoViewEvent.ENTER_SPECTATOR,this.onEnterSpectator);
      param1.addEventListener(BattleInfoViewEvent.BUY_PRO_ABONEMENT,this.onBuyAbonement);
    }

    private function onEnterBattle(param1:BattleInfoViewEvent) : void {
      BattleEntrance(this.getSelectedBattle().adapt(BattleEntrance)).fight(param1.team);
      trackerService.trackEvent(GA_CATEGORY,"enterBattle",param1.team != null ? "Team" : "DM");
    }

    public function showTeamForm(param1:BattleInfoTeamParams) : void {
      if(this.teamController == null) {
        this.teamController = new BattleInfoTeamController();
        this.addEventListeners(this.teamController);
      }
      this.teamController.showForm(param1);
      this.formState = BattleInfoState.TEAM_FORM;
    }

    private function onBuyAbonement(param1:BattleInfoViewEvent) : void {
      dispatchEvent(param1.clone());
    }

    private function onEnterSpectator(param1:BattleInfoViewEvent) : void {
      BattleEntrance(this.getSelectedBattle().adapt(BattleEntrance)).enterAsSpectator();
      trackerService.trackEvent(GA_CATEGORY,"enterBattle","Spectator");
    }

    public function hideForms() : void {
      this.getCurrentBattleInfoController().hideForm();
      this.formState = BattleInfoState.NONE;
    }

    public function hideBattleForms() : void {
      this.getCurrentBattleInfoController().hideForm();
      this.formState = BattleInfoState.NONE;
    }

    public function destroy() : void {
      if(this.dmController != null) {
        this.removeEventListeners(this.dmController);
        this.dmController.destroy();
        this.dmController = null;
      }
      if(this.teamController != null) {
        this.removeEventListeners(this.teamController);
        this.teamController.destroy();
        this.teamController = null;
      }
      this.formState = BattleInfoState.NONE;
    }

    private function removeEventListeners(param1:IBattleInfoController) : void {
      param1.removeEventListener(BattleInfoViewEvent.ENTER_BATTLE,this.onEnterBattle);
      param1.removeEventListener(BattleInfoViewEvent.ENTER_SPECTATOR,this.onEnterSpectator);
      param1.removeEventListener(BattleInfoViewEvent.BUY_PRO_ABONEMENT,this.onBuyAbonement);
    }

    public function updateTeamScore(param1:BattleTeam, param2:int) : void {
      if(this.isCurrentBattleNotSelected()) {
        return;
      }
      if(this.formState == BattleInfoState.TEAM_FORM) {
        this.teamController.updateTeamScore(param1,param2);
      }
    }

    public function updateBattleName() : void {
      this.getCurrentBattleInfoController().updateBattleName();
    }

    public function removeUser(param1:Long) : void {
      if(this.isCurrentBattleNotSelected()) {
        return;
      }
      this.getCurrentBattleInfoController().removeUser(param1);
    }

    public function updateUserScore(param1:Long, param2:int) : void {
      if(this.isCurrentBattleNotSelected()) {
        return;
      }
      this.getCurrentBattleInfoController().updateUserScore(param1,param2);
    }

    public function updateUserSuspiciousState(param1:Long, param2:Boolean) : void {
      if(this.isCurrentBattleNotSelected()) {
        return;
      }
      this.getCurrentBattleInfoController().updateUserSuspiciousState(param1,param2);
    }

    public function swapTeams() : void {
      if(this.isCurrentBattleNotSelected()) {
        return;
      }
      this.teamController.swapTeams();
    }

    public function roundStart(param1:int) : void {
      if(this.isCurrentBattleNotSelected()) {
        return;
      }
      this.getCurrentBattleInfoController().roundStart(param1);
    }

    public function roundFinish() : void {
      if(this.isCurrentBattleNotSelected()) {
        return;
      }
      this.getCurrentBattleInfoController().roundFinish();
    }

    public function battleStop() : void {
      if(this.isCurrentBattleNotSelected()) {
        return;
      }
      this.getCurrentBattleInfoController().battleStop();
    }

    public function getSelectedBattle() : IGameObject {
      return this.getCurrentBattleInfoController().getSelectedBattle();
    }

    private function getCurrentBattleInfoController() : IBattleInfoController {
      switch(this.formState) {
        case BattleInfoState.DM_FORM:
          return this.dmController;
        case BattleInfoState.TEAM_FORM:
          return this.teamController;
        default:
          return EMPTY_CONTROLLER;
      }
    }

    public function addUser(param1:BattleInfoUser, param2:BattleTeam = null) : void {
      if(this.isCurrentBattleNotSelected()) {
        return;
      }
      if(param2 == null) {
        this.dmController.addUser(param1);
      } else {
        this.teamController.addUserToTeam(param1,param2);
      }
    }

    private function isCurrentBattleNotSelected() : Boolean {
      return Model.object != this.getSelectedBattle();
    }
  }
}
