package alternativa.tanks.model.quest.challenge.rewarding {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.quest.challenge.ChallengesViewService;
  import projects.tanks.client.panel.model.challenge.rewarding.ChallengesRewardingUserModelBase;
  import projects.tanks.client.panel.model.challenge.rewarding.IChallengesRewardingUserModelBase;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  [ModelInfo]
  public class ChallengesRewardingUserModel extends ChallengesRewardingUserModelBase implements IChallengesRewardingUserModelBase {
    [Inject]
    public static var notificationService:INotificationService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var challengeViewService:ChallengesViewService;

    public function ChallengesRewardingUserModel() {
      super();
    }

    public function rewardNotify(param1:int) : void {
      var local2:String = localeService.getText(TanksLocale.TEXT_CHALLENGE_REWARD_NOTIFICATION).replace("%number%",challengeViewService.getTierNumber(param1));
      notificationService.addNotification(new ChallengesRewardingNotification(local2));
    }
  }
}
