package alternativa.tanks.gui.friends.list.refferals.referalbuttons {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import flash.external.ExternalInterface;
  import forms.stat.ReferralWindowBigButton;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class OkReferralButton extends ReferralWindowBigButton {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private static const friendsOKImageClass:Class = OkReferralButton_friendsOKImageClass;
    private static const friendsOKBitmapData:BitmapData = new friendsOKImageClass().bitmapData;

    public function OkReferralButton() {
      super();
      icon = friendsOKBitmapData;
      label = localeService.getText(TanksLocale.TEXT_INVITE_FRIEND_BUTTON_LABEL);
      addEventListener(MouseEvent.CLICK,this.onInviteButtonLink,false,0,true);
    }

    private function onInviteButtonLink(param1:MouseEvent) : void {
      if(ExternalInterface.available) {
        ExternalInterface.call("showInviteBox");
      }
    }
  }
}
