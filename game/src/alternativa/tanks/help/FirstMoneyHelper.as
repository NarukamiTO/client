package alternativa.tanks.help {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class FirstMoneyHelper extends BubbleHelper {
    [Inject]
    public static var localeService:ILocaleService;

    public function FirstMoneyHelper() {
      super();
      text = localeService.getText(TanksLocale.TEXT_HELP_PANEL_MONEY_FIRST_HELPER_TEXT);
      arrowLehgth = int(localeService.getText(TanksLocale.TEXT_HELP_PANEL_MONEY_HELPER_ARROW_LENGTH));
      arrowAlign = HelperAlign.TOP_RIGHT;
      _showLimit = 3;
    }
  }
}
