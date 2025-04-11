package projects.tanks.clients.fp10.libraries.tanksservices.model.logging {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.tanksservices.model.logging.IUserActionsLoggerModelBase;
  import projects.tanks.client.tanksservices.model.logging.UserActionsLoggerModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangedGameScreenEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedService;

  [ModelInfo]
  public class UserActionsLoggerModel extends UserActionsLoggerModelBase implements IUserActionsLoggerModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var paymentActionService:UserPaymentActionsService;

    [Inject]
    public static var garageActionService:UserGarageActionsService;

    [Inject]
    public static var battleSelectActionService:UserBattleSelectActionsService;

    [Inject]
    public static var changeScreenService:UserChangeGameScreenService;

    [Inject]
    public static var settingsChangedService:UserSettingsChangedService;

    public function UserActionsLoggerModel() {
      super();
    }

    public function objectLoaded() : void {
      paymentActionService.addEventListener(UserPaymentActionEvent.TYPE,getFunctionWrapper(this.onPaymentAction));
      if(getInitParam().loggingEnabled) {
        garageActionService.addEventListener(UserGarageActionEvent.TYPE,getFunctionWrapper(this.onGarageAction));
        battleSelectActionService.addEventListener(UserBattleSelectActionEvent.TYPE,getFunctionWrapper(this.onBattleSelectAction));
        changeScreenService.addEventListener(UserChangedGameScreenEvent.TYPE,getFunctionWrapper(this.onScreenChanged));
        settingsChangedService.addEventListener(UserSettingsChangedEvent.TYPE,getFunctionWrapper(this.onSettingsChanged));
      }
    }

    private function onPaymentAction(param1:UserPaymentActionEvent) : void {
      server.paymentAction(param1.getPaymentAction(),param1.getLayoutName(),param1.getCountryCode(),param1.getPayModeId(),param1.getShopItemId());
    }

    private function onGarageAction(param1:UserGarageActionEvent) : void {
      server.garageAction(param1.getAction(),param1.getItem());
    }

    private function onBattleSelectAction(param1:UserBattleSelectActionEvent) : void {
      server.battleSelectAction(param1.getAction(),param1.getMode(),param1.getAdditionalInfo());
    }

    private function onScreenChanged(param1:UserChangedGameScreenEvent) : void {
      server.changeScreenAction(param1.getPreviousScreen(),param1.getNewScreen());
    }

    private function onSettingsChanged(param1:UserSettingsChangedEvent) : void {
      server.settingsAction(param1.getSettings());
    }

    public function objectUnloaded() : void {
      paymentActionService.removeEventListener(UserPaymentActionEvent.TYPE,getFunctionWrapper(this.onPaymentAction));
      if(getInitParam().loggingEnabled) {
        garageActionService.removeEventListener(UserGarageActionEvent.TYPE,getFunctionWrapper(this.onGarageAction));
        battleSelectActionService.removeEventListener(UserBattleSelectActionEvent.TYPE,getFunctionWrapper(this.onBattleSelectAction));
        changeScreenService.removeEventListener(UserChangedGameScreenEvent.TYPE,getFunctionWrapper(this.onScreenChanged));
        settingsChangedService.removeEventListener(UserSettingsChangedEvent.TYPE,getFunctionWrapper(this.onSettingsChanged));
      }
    }
  }
}
