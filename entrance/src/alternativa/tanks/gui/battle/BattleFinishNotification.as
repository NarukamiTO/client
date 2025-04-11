package alternativa.tanks.gui.battle {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.panel.StarsIcon;
  import assets.Diamond;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.events.MouseEvent;
  import flash.text.TextLineMetrics;
  import forms.ColorConstants;
  import projects.tanks.clients.flash.commons.services.notification.Notification;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class BattleFinishNotification extends Notification {
    [Inject]
    public static var localeService:ILocaleService;

    private static const DEFAULT_BUTTON_WIDTH:int = 96;

    private var _messageLabel:LabelBase;
    private var _rejectButton:DefaultButtonBase;
    private var _diamond:Diamond;
    private var _stars:Bitmap;

    protected var _showStars:Boolean;

    public function BattleFinishNotification() {
      super();
    }

    override protected function init() : void {
      super.init();
      this._messageLabel = new LabelBase();
      this._messageLabel.color = ColorConstants.GREEN_LABEL;
      this._messageLabel.mouseEnabled = false;
      addChild(this._messageLabel);
      this._messageLabel.htmlText = message;
      this._diamond = new Diamond();
      addChild(this._diamond);
      this._stars = new StarsIcon.icon_class();
      if(this._showStars) {
        addChild(this._stars);
      }
      this._rejectButton = new DefaultButtonBase();
      this._rejectButton.width = DEFAULT_BUTTON_WIDTH;
      this._rejectButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      addChild(this._rejectButton);
      autoClosable = false;
    }

    override protected function setEvents() : void {
      super.setEvents();
      this._rejectButton.addEventListener(MouseEvent.CLICK,this.onRejectClick);
    }

    override protected function removeEvents() : void {
      super.removeEvents();
      this._rejectButton.removeEventListener(MouseEvent.CLICK,this.onRejectClick);
    }

    private function onRejectClick(param1:MouseEvent) : void {
      this.closeNotification();
    }

    override protected function closeNotification() : void {
      hide();
    }

    override protected function resize() : void {
      var local4:TextLineMetrics = null;
      this._messageLabel.x = GAP + 9;
      this._messageLabel.y = GAP + 7;
      var local1:int = this._messageLabel.numLines - (this._showStars ? 2 : 1);
      var local2:TextLineMetrics = this._messageLabel.getLineMetrics(local1);
      this._diamond.x = int(this._messageLabel.x + local2.width + 6);
      this._diamond.y = int(this._messageLabel.y + local2.height * local1 + local2.descent * (local1 - 1));
      if(this._showStars) {
        local4 = this._messageLabel.getLineMetrics(this._messageLabel.numLines - 1);
        this._stars.x = int(this._messageLabel.x + local4.width + 6);
        this._stars.y = int(this._messageLabel.y + this._messageLabel.height - 14);
      }
      _innerHeight = this._messageLabel.y + this._messageLabel.height - 3;
      var local3:int = this._messageLabel.x + this._messageLabel.width + GAP * 2;
      if(local3 > _width) {
        _width = local3;
      }
      this._rejectButton.x = _width - this._rejectButton.width - GAP;
      this._rejectButton.y = _innerHeight + 16;
      _height = this._rejectButton.y + this._rejectButton.height + GAP + 1;
      super.resize();
    }

    protected function getStarsRewardText(param1:int) : String {
      return "<font color=\"#f3c800\">" + String(param1) + "</font>";
    }
  }
}
