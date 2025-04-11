package alternativa.tanks.view.matchmaking.group.invite {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.types.Long;
  import controls.base.LabelBase;
  import forms.ColorConstants;
  import forms.userlabel.UserLabel;
  import projects.tanks.clients.flash.commons.services.notification.Notification;

  public class ResponseGroupInviteNotification extends Notification {
    [Inject]
    public static var localeService:ILocaleService;

    private var messageLabel:LabelBase;
    private var userLabel:UserLabel;

    public function ResponseGroupInviteNotification(param1:Long, param2:String) {
      super(param1,localeService.getText(param2));
    }

    override protected function init() : void {
      super.init();
      this.userLabel = new UserLabel(userId);
      addChild(this.userLabel);
      this.messageLabel = new LabelBase();
      this.messageLabel.mouseEnabled = false;
      addChild(this.messageLabel);
      this.messageLabel.color = ColorConstants.GREEN_LABEL;
      this.messageLabel.text = message;
    }

    override protected function resize() : void {
      this.userLabel.x = GAP + 7;
      this.userLabel.y = GAP + 5;
      this.messageLabel.x = GAP + 9;
      this.messageLabel.y = this.userLabel.y + this.userLabel.height - 1;
      _innerHeight = this.messageLabel.y + this.messageLabel.height - 3;
      var local1:int = this.messageLabel.x + this.messageLabel.width + GAP * 2;
      if(local1 > _width) {
        _width = local1;
      }
      _height = _innerHeight + GAP * 2 + 1;
      super.resize();
    }
  }
}
