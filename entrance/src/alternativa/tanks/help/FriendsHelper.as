package alternativa.tanks.help {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class FriendsHelper extends PanelBubbleHelper {
    public function FriendsHelper(param1:Number, param2:Number, param3:Number) {
      super(param1,param2,param3);
      var local4:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
      text = local4.getText(TanksLocale.TEXT_FRIENDS_MENU);
      arrowLehgth = int(local4.getText(TanksLocale.TEXT_FRIENDS_MENU_ARROW_LENGTH));
      arrowAlign = HelperAlign.TOP_CENTER;
    }
  }
}
