package forms.registration.bubbles {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class PasswordsDoNotMatchBubble extends BubbleHelper {
    [Inject]
    public static var localeService:ILocaleService;

    public function PasswordsDoNotMatchBubble() {
      super();
      text = localeService.getText(TanksLocale.TEXT_HELP_PASSWORDS_DO_NOT_MATCH);
      arrowLehgth = 20;
      arrowAlign = HelperAlign.TOP_LEFT;
      _showLimit = 3;
    }
  }
}
