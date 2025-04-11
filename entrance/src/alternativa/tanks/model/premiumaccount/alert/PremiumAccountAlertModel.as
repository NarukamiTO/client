package alternativa.tanks.model.premiumaccount.alert {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.premiumaccount.PremiumAccountWelcomeAlert;
  import alternativa.tanks.model.premiumaccount.notification.PremiumCompleteNotification;
  import flash.events.Event;
  import flash.utils.clearInterval;
  import flash.utils.setInterval;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.premiumaccount.alert.IPremiumAccountAlertModelBase;
  import projects.tanks.client.panel.model.premiumaccount.alert.PremiumAccountAlertCC;
  import projects.tanks.client.panel.model.premiumaccount.alert.PremiumAccountAlertModelBase;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;

  [ModelInfo]
  public class PremiumAccountAlertModel extends PremiumAccountAlertModelBase implements IPremiumAccountAlertModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var notificationService:INotificationService;

    [Inject]
    public static var premiumService:PremiumService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const UPDATE_INTERVAL:int = 60000;

    private var _showReminderIntervalId:uint = 0;
    private var _wasShowReminderCompletionPremium:Boolean;
    private var _reminderCompletionPremiumTime:int;

    public function PremiumAccountAlertModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:PremiumAccountAlertCC = getInitParam();
      if(local1.localRuntimeUser) {
        if(local1.needShowWelcomeAlert) {
          this.showWelcomeAlert(local1.wasShowAlertForFirstPurchasePremium);
        }
        if(local1.needShowNotificationCompletionPremium) {
          this.showNotificationCompletionPremium();
        }
        this._wasShowReminderCompletionPremium = local1.wasShowReminderCompletionPremium;
        this._reminderCompletionPremiumTime = local1.reminderCompletionPremiumTime;
        this.checkNeedShowReminderCompletionPremium();
        premiumService.addEventListener(Event.CHANGE,getFunctionWrapper(this.onSelfPremiumChange));
      }
    }

    private function checkNeedShowReminderCompletionPremium() : void {
      var local1:int = 0;
      this.destroyReminderInterval();
      if(premiumService.hasPremium()) {
        local1 = premiumService.getTimeLeft() - this._reminderCompletionPremiumTime;
        if(local1 > 0) {
          this._wasShowReminderCompletionPremium = false;
          this._showReminderIntervalId = setInterval(getFunctionWrapper(this.checkNeedShowReminderCompletionPremium),UPDATE_INTERVAL);
        } else if(!this._wasShowReminderCompletionPremium) {
          this.showReminderCompletionPremium();
        }
      }
    }

    public function objectUnloaded() : void {
      if(getInitParam().localRuntimeUser) {
        premiumService.removeEventListener(Event.CHANGE,getFunctionWrapper(this.onSelfPremiumChange));
        this.destroyReminderInterval();
      }
    }

    private function destroyReminderInterval() : void {
      if(this._showReminderIntervalId != 0) {
        clearInterval(this._showReminderIntervalId);
        this._showReminderIntervalId = 0;
      }
    }

    public function showWelcomeAlert(param1:Boolean) : void {
      var local2:String = null;
      if(param1) {
        local2 = localeService.getText(TanksLocale.TEXT_PREMIUM_ALERT_RETURN);
      } else {
        local2 = localeService.getText(TanksLocale.TEXT_PREMIUM_ALERT_WELCOM);
      }
      var local3:PremiumAccountWelcomeAlert = new PremiumAccountWelcomeAlert(local2);
      local3.enqueueDialog();
      server.confirmShowWelcomeAlert();
    }

    private function onSelfPremiumChange(param1:Event) : void {
      if(premiumService.hasPremium()) {
        this.checkNeedShowReminderCompletionPremium();
      } else {
        this.showNotificationCompletionPremium();
      }
    }

    private function showNotificationCompletionPremium() : void {
      notificationService.addNotification(new PremiumCompleteNotification(localeService.getText(TanksLocale.TEXT_PREMIUM_NOTIFICATION_COMPLETE)));
      server.confirmShowNotificationCompletionPremium();
    }

    private function showReminderCompletionPremium() : void {
      this._wasShowReminderCompletionPremium = true;
      notificationService.addNotification(new PremiumCompleteNotification(localeService.getText(TanksLocale.TEXT_PREMIUM_NOTIFICATION_SOON_COMPLETE)));
      server.confirmShowReminderCompletionPremium();
    }
  }
}
