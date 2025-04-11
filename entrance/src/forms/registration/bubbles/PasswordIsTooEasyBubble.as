package forms.registration.bubbles {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class PasswordIsTooEasyBubble extends BubbleHelper {
    [Inject]
    public static var localeService:ILocaleService;

    public function PasswordIsTooEasyBubble() {
      super();
      text = localeService.getText(TanksLocale.TEXT_HELP_PASSWORD_IS_TOO_SIMPLE);
      arrowLehgth = 20;
      arrowAlign = HelperAlign.TOP_LEFT;
      _showLimit = 3;
    }
  }
}
