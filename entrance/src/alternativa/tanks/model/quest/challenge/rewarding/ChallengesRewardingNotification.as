package alternativa.tanks.model.quest.challenge.rewarding {
  import controls.base.LabelBase;
  import forms.ColorConstants;
  import projects.tanks.clients.flash.commons.services.notification.Notification;

  public class ChallengesRewardingNotification extends Notification {
    private static const X_MARGIN:int = 9;
    private static const Y_MARGIN:int = 7;

    private var _messageLabel:LabelBase;

    public function ChallengesRewardingNotification(param1:String) {
      super(null,param1,true);
    }

    override protected function init() : void {
      super.init();
      this._messageLabel = new LabelBase();
      this._messageLabel.color = ColorConstants.GREEN_LABEL;
      this._messageLabel.mouseEnabled = false;
      addChild(this._messageLabel);
      this._messageLabel.htmlText = message;
    }

    override protected function resize() : void {
      this._messageLabel.x = GAP + X_MARGIN;
      this._messageLabel.y = GAP + Y_MARGIN;
      _innerHeight = this._messageLabel.y + this._messageLabel.height - 3;
      _height = _innerHeight + 2 * Y_MARGIN + GAP - 2;
      _width = GAP * 2 + X_MARGIN * 2 + this._messageLabel.width;
      super.resize();
    }
  }
}
