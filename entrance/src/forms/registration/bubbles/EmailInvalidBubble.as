package forms.registration.bubbles {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.geom.Point;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class EmailInvalidBubble extends BubbleHelper {
    [Inject]
    public static var localeService:ILocaleService;

    private var margin:int = 12;

    public function EmailInvalidBubble() {
      super();
      text = localeService.getText(TanksLocale.TEXT_ERROR_EMAIL_INVALID);
      arrowLehgth = 20;
      arrowAlign = HelperAlign.TOP_LEFT;
      _showLimit = 3;
    }

    public function setEmailInvalidText() : void {
      text = localeService.getText(TanksLocale.TEXT_ERROR_EMAIL_INVALID);
    }

    public function setEmailForbiddenText() : void {
      text = localeService.getText(TanksLocale.TEXT_ERROR_EMAIL_DOMAIN_IS_FORBIDDEN);
    }

    public function setEmailIsNotUniqueText() : void {
      text = localeService.getText(TanksLocale.TEXT_ERROR_EMAIL_NOT_UNIQUE);
    }

    public function redraw() : void {
      var local1:Point = new Point();
      local1.x = Math.round(descriptionLabel.textWidth + this.margin * 2);
      local1.y = Math.round(descriptionLabel.textHeight + this.margin * 2) - 3;
      draw(local1);
    }
  }
}
