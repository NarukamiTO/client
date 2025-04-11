package projects.tanks.clients.flash.commons.models.battlelinkactivator {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.commons.models.linkactivator.ILinkActivatorModelBase;
  import projects.tanks.client.commons.models.linkactivator.LinkActivatorModelBase;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.BattleLinkActivatorServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.BattleLinkAliveEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class BattleLinkActivatorModel extends LinkActivatorModelBase implements ILinkActivatorModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var battleLinkActivatorService:IBattleLinkActivatorService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var userPropertyService:IUserPropertiesService;

    public function BattleLinkActivatorModel() {
      super();
    }

    public function objectLoaded() : void {
      battleLinkActivatorService.addEventListener(BattleLinkActivatorServiceEvent.ACTIVATE_LINK,getFunctionWrapper(this.onActivateLink));
      battleLinkActivatorService.addEventListener(BattleLinkAliveEvent.IS_ALIVE,getFunctionWrapper(this.onIsAlive));
    }

    private function onActivateLink(param1:BattleLinkActivatorServiceEvent) : void {
      if(!lobbyLayoutService.isSwitchInProgress()) {
        server.activateBattle(param1.battleId);
      }
    }

    private function onIsAlive(param1:BattleLinkAliveEvent) : void {
      server.isAlive(param1.battleId);
    }

    public function objectUnloaded() : void {
      battleLinkActivatorService.removeEventListener(BattleLinkActivatorServiceEvent.ACTIVATE_LINK,getFunctionWrapper(this.onActivateLink));
      battleLinkActivatorService.removeEventListener(BattleLinkAliveEvent.IS_ALIVE,getFunctionWrapper(this.onIsAlive));
    }

    public function battleNotFound() : void {
      var local1:String = userPropertyService.userName;
      if(storageService.getStorage().data.showAlertDeadBattle == local1 + "_true") {
        alertService.showAlert(localeService.getText(TanksLocale.TEXT_BATTLE_CANNOT_BE_FOUND_ALERT),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
        storageService.getStorage().data.showAlertDeadBattle = local1 + "_false";
      }
    }

    public function alive(param1:Long) : void {
      battleLinkActivatorService.alive(param1);
    }

    public function dead(param1:Long) : void {
      battleLinkActivatorService.dead(param1);
    }
  }
}
