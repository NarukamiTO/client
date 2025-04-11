package forms {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.text.TextFormatAlign;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ServerRedirectAlert extends ServerStopAlert {
    [Inject]
    public static var localeService:ILocaleService;

    public function ServerRedirectAlert(param1:int) {
      super(param1);
    }

    override protected function init() : void {
      timeLimitLabel.align = TextFormatAlign.CENTER;
      str = localeService.getText(TanksLocale.TEXT_REDIRECT_ALERT_TEXT);
      timeLimitLabel.text = getText(str,"88");
      addChild(bg);
      addChild(timeLimitLabel);
      timeLimitLabel.x = PADDING;
      timeLimitLabel.y = PADDING;
      bg.width = timeLimitLabel.width + PADDING * 2;
      bg.height = timeLimitLabel.height + PADDING * 2;
      showCountDown();
    }
  }
}
