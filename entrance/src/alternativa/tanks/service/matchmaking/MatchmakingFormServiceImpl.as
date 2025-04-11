package alternativa.tanks.service.matchmaking {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.controllers.mainview.MatchmakingGroupEvent;
  import alternativa.tanks.controllers.mainview.SwitchToBattleSelectEvent;
  import alternativa.tanks.controllers.mathmacking.MatchmakingFormController;
  import alternativa.tanks.controllers.mathmacking.ShowGroupInviteWindowEvent;
  import alternativa.tanks.service.battlelist.MatchmakingEvent;
  import alternativa.tanks.view.mainview.HolidayParams;
  import alternativa.tanks.view.mainview.MatchmakingLayout;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MatchmakingUserData;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MountItemsUserData;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class MatchmakingFormServiceImpl extends EventDispatcher implements MatchmakingFormService, MatchmakingGroupFormService, MatchmakingGroupInviteService {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var matchmakingGroupService:MatchmakingGroupService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var storageService:IStorageService;

    private static var MM_GAME_MODE:String = "MM_GAME_MODE";

    private var matchmakingLayout:MatchmakingLayout;
    private var registrationFormController:MatchmakingFormController = new MatchmakingFormController();

    public function MatchmakingFormServiceImpl() {
      super();
    }

    private static function onShowBattleSelect(param1:SwitchToBattleSelectEvent) : void {
      lobbyLayoutService.showBattleSelect();
    }

    public function showMatchmakingLayout(param1:Dictionary, param2:HolidayParams, param3:int) : void {
      if(this.matchmakingLayout == null) {
        this.matchmakingLayout = new MatchmakingLayout(param1,param2,param3);
      }
      this.matchmakingLayout.addEventListener(SwitchToBattleSelectEvent.EVENT,onShowBattleSelect);
      this.matchmakingLayout.addEventListener(MatchmakingEvent.REGISTRATION,this.onRegistration);
      this.matchmakingLayout.addEventListener(MatchmakingEvent.ENTER_AS_SPECTATOR,this.onEnterAsSpectator);
      this.matchmakingLayout.addEventListener(MatchmakingGroupEvent.CREATE,this.onCreateGroup);
      this.matchmakingLayout.addEventListener(MatchmakingGroupEvent.LEAVE,this.onLeaveGroup);
      this.matchmakingLayout.show();
    }

    public function hideMatchmakingLayout() : void {
      if(this.matchmakingLayout == null) {
        return;
      }
      this.matchmakingLayout.removeEventListener(SwitchToBattleSelectEvent.EVENT,onShowBattleSelect);
      this.matchmakingLayout.removeEventListener(MatchmakingEvent.REGISTRATION,this.onRegistration);
      this.matchmakingLayout.removeEventListener(MatchmakingEvent.ENTER_AS_SPECTATOR,this.onEnterAsSpectator);
      this.matchmakingLayout.removeEventListener(MatchmakingGroupEvent.CREATE,this.onCreateGroup);
      this.matchmakingLayout.removeEventListener(MatchmakingGroupEvent.LEAVE,this.onLeaveGroup);
      this.matchmakingLayout.hide();
    }

    public function showGroupView(param1:Vector.<MatchmakingUserData>, param2:Boolean) : void {
      this.matchmakingLayout.showGroupView(param1,param2);
    }

    public function hideGroupView() : void {
      this.matchmakingLayout.hideGroupView();
    }

    public function addUserToGroup(param1:MatchmakingUserData) : void {
      matchmakingGroupService.addUser(param1.id);
      this.matchmakingLayout.addUserToGroup(param1);
    }

    public function updateMountedItem(param1:MountItemsUserData) : void {
      this.matchmakingLayout.updateMountedItem(param1);
    }

    public function removeUserFromGroup(param1:Long) : void {
      matchmakingGroupService.removeUser(param1);
      this.matchmakingLayout.removeUserFromGroup(param1);
    }

    public function showUserReady(param1:Long) : void {
      this.matchmakingLayout.showUserReady(param1);
    }

    public function showUserNotReady(param1:Long) : void {
      this.matchmakingLayout.showUserNotReady(param1);
    }

    public function showRegistrationWindow(param1:int, param2:MatchmakingMode) : void {
      this.setLastRegistrationMode(param2);
      this.registrationFormController.addEventListener(MatchmakingEvent.UNREGISTRATION,this.onCancelRegistration);
      this.registrationFormController.showForm(this.getModeName(param2),param1);
    }

    public function hideRegistrationWindow() : void {
      this.registrationFormController.removeEventListener(MatchmakingEvent.UNREGISTRATION,this.onCancelRegistration);
      this.registrationFormController.hideForm();
    }

    public function getLastRegistrationMode() : MatchmakingMode {
      var local3:MatchmakingMode = null;
      var local1:int = 0;
      var local2:Object = storageService.getStorage().data[MM_GAME_MODE];
      if(local2 != null) {
        local1 = int(local2);
      }
      for each(local3 in MatchmakingMode.values) {
        if(local3.value == local1) {
          return local3;
        }
      }
      return MatchmakingMode.TEAM_MODE;
    }

    private function onEnterAsSpectator(param1:MatchmakingEvent) : void {
      dispatchEvent(param1);
    }

    private function setLastRegistrationMode(param1:MatchmakingMode) : void {
      storageService.getStorage().data[MM_GAME_MODE] = param1.value;
      storageService.getStorage().flush();
    }

    private function onRegistration(param1:MatchmakingEvent) : void {
      this.setLastRegistrationMode(param1.getMode());
      dispatchEvent(param1);
    }

    private function onCancelRegistration(param1:MatchmakingEvent) : void {
      dispatchEvent(param1);
    }

    private function onCreateGroup(param1:MatchmakingGroupEvent) : void {
      dispatchEvent(param1);
    }

    private function onLeaveGroup(param1:MatchmakingGroupEvent) : void {
      dispatchEvent(param1);
    }

    public function openInviteWindow() : void {
      dispatchEvent(new ShowGroupInviteWindowEvent());
    }

    public function getModeName(param1:MatchmakingMode) : String {
      var local2:String = null;
      switch(param1) {
        case MatchmakingMode.TEAM_MODE:
          local2 = TanksLocale.TEXT_QUICK_PLAY_MODE_NAME;
          break;
        case MatchmakingMode.HOLIDAY:
          local2 = TanksLocale.TEXT_DM_MODE_NAME;
          break;
        default:
          local2 = TanksLocale.TEXT_DM_MODE_NAME.replace("DM_",param1.name.substr(0,param1.name.indexOf("_") + 1));
      }
      return localeService.getText(local2);
    }
  }
}
