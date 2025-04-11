package alternativa.tanks.model.matchmaking.notify {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.LabelBase;
  import forms.ColorConstants;
  import projects.tanks.clients.flash.commons.services.notification.Notification;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class MatchmakingTimeoutNotification extends Notification {
    [Inject]
    public static var localeService:ILocaleService;

    private var _messageLabel:LabelBase;

    public function MatchmakingTimeoutNotification() {
      super(null,TanksLocale.TEXT_MATCHMAKING_TIMEOUT_MESSAGE);
    }

    override protected function init() : void {
      super.init();
      this._messageLabel = new LabelBase();
      this._messageLabel.mouseEnabled = false;
      addChild(this._messageLabel);
      this._messageLabel.color = ColorConstants.GREEN_LABEL;
      this._messageLabel.text = localeService.getText(TanksLocale.TEXT_MATCHMAKING_TIMEOUT_MESSAGE);
    }

    override protected function resize() : void {
      this._messageLabel.x = GAP + 7;
      this._messageLabel.y = GAP + 5;
      _innerHeight = this._messageLabel.y + this._messageLabel.height - 3;
      var local1:int = this._messageLabel.x + this._messageLabel.width + GAP * 2;
      if(local1 > _width) {
        _width = local1;
      }
      _height = _innerHeight + GAP * 2 + 1;
      super.resize();
    }
  }
}
