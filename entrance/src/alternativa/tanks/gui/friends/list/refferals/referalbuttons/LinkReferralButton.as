package alternativa.tanks.gui.friends.list.refferals.referalbuttons {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.referrals.ReferralsService;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import flash.system.System;
  import forms.stat.ReferralWindowBigButton;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class LinkReferralButton extends ReferralWindowBigButton {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var referralService:ReferralsService;

    private static const bitmapIconLink:Class = LinkReferralButton_bitmapIconLink;
    private static const iconLinkBd:BitmapData = new bitmapIconLink().bitmapData;

    public function LinkReferralButton() {
      super();
      icon = iconLinkBd;
      label = localeService.getText(TanksLocale.TEXT_COPY_LINK_BUTTON_LABEL);
      addEventListener(MouseEvent.CLICK,this.onLinkClick);
    }

    private function onLinkClick(param1:MouseEvent) : void {
      System.setClipboard(referralService.getInviteLink());
      label = localeService.getText(TanksLocale.TEXT_LINK_IS_COPIED_BUTTON_LABEL);
    }
  }
}
