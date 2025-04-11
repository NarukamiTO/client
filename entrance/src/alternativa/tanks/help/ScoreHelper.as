package alternativa.tanks.help {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class ScoreHelper extends BubbleHelper {
    public function ScoreHelper() {
      super();
      var local1:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
      text = local1.getText(TanksLocale.TEXT_HELP_PANEL_SCORE_HELPER_TEXT);
      arrowLehgth = int(local1.getText(TanksLocale.TEXT_HELP_PANEL_SCORE_HELPER_ARROW_LENGTH));
      arrowAlign = HelperAlign.TOP_LEFT;
      _showLimit = 3;
      _targetPoint.x = 79;
      _targetPoint.y = 25;
    }
  }
}
