package forms.registration.bubbles {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class NameIsIncorrectBubble extends BubbleHelper {
    [Inject]
    public static var localeService:ILocaleService;

    public function NameIsIncorrectBubble() {
      super();
      text = localeService.getText(TanksLocale.TEXT_HELP_NAME_IS_FORBIDDEN);
      arrowLehgth = 20;
      arrowAlign = HelperAlign.TOP_LEFT;
      _showLimit = 3;
    }
  }
}
