package alternativa.tanks.help {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class TanksPartHelper extends BubbleHelper {
    [Inject]
    public static var localeService:ILocaleService;

    public function TanksPartHelper() {
      super();
      text = localeService.getText(TanksLocale.TEXT_GARAGE_HELPER_TANK_PARTS);
      arrowLehgth = 48;
      arrowAlign = HelperAlign.MIDDLE_RIGHT;
      _showLimit = 3;
    }
  }
}
