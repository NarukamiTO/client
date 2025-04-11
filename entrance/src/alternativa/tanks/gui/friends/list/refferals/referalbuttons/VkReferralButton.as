package alternativa.tanks.gui.friends.list.refferals.referalbuttons {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.referrals.ReferralsService;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import flash.external.ExternalInterface;
  import forms.stat.ReferralWindowBigButton;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class VkReferralButton extends ReferralWindowBigButton {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var referralService:ReferralsService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private static const friendsVKImageClass:Class = VkReferralButton_friendsVKImageClass;
    private static const friendsVKBitmapData:BitmapData = new friendsVKImageClass().bitmapData;

    public function VkReferralButton() {
      super();
      icon = friendsVKBitmapData;
      label = localeService.getText(TanksLocale.TEXT_INVITE_FRIEND_BUTTON_LABEL);
      addEventListener(MouseEvent.CLICK,this.onInviteButtonLink,false,0,true);
    }

    private function onInviteButtonLink(param1:MouseEvent) : void {
      if(ExternalInterface.available) {
        ExternalInterface.call("showInviteBox",userPropertiesService.userId);
      }
    }
  }
}
