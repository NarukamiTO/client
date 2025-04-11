package alternativa.tanks.help.achievements {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class BattleFightButtonHelper extends BubbleHelper {
    public function BattleFightButtonHelper() {
      super();
      var local1:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
      text = local1.getText(TanksLocale.TEXT_HELP_PANEL_ACHIEVEMENTS_FIRST_BATTLE_BUTTON_TEXT);
      arrowLehgth = int(local1.getText(TanksLocale.TEXT_HELP_PANEL_ACHIEVEMENTS_FIRST_BATTLE_BUTTON_ARROW_LENGTH));
      arrowAlign = HelperAlign.TOP_RIGHT;
      _showLimit = 3;
    }
  }
}
