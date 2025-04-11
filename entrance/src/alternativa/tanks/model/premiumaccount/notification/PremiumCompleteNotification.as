package alternativa.tanks.model.premiumaccount.notification {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.clients.flash.commons.services.notification.Notification;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class PremiumCompleteNotification extends Notification {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    private var _baseMessageLabel:LabelBase;
    private var _rejectButton:DefaultButtonBase;
    private var _acceptButton:DefaultButtonBase;

    public function PremiumCompleteNotification(param1:String) {
      super(null,param1,false);
    }

    override protected function init() : void {
      super.init();
      this._baseMessageLabel = new LabelBase();
      this._baseMessageLabel.color = ColorConstants.GREEN_LABEL;
      this._baseMessageLabel.mouseEnabled = false;
      this._baseMessageLabel.htmlText = message;
      addChild(this._baseMessageLabel);
      this._acceptButton = new DefaultButtonBase();
      this._acceptButton.label = localeService.getText(TanksLocale.TEXT_PREMIUM_BUTTON_EXTEND);
      addChild(this._acceptButton);
      this._rejectButton = new DefaultButtonBase();
      this._rejectButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      addChild(this._rejectButton);
    }

    override protected function setEvents() : void {
      super.setEvents();
      this._acceptButton.addEventListener(MouseEvent.CLICK,this.onAcceptClick);
      this._rejectButton.addEventListener(MouseEvent.CLICK,this.onRejectClick);
    }

    override protected function removeEvents() : void {
      super.removeEvents();
      this._acceptButton.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
      this._rejectButton.removeEventListener(MouseEvent.CLICK,this.onRejectClick);
    }

    private function onAcceptClick(param1:MouseEvent = null) : void {
      hide();
      if(!paymentDisplayService.isPaymentDisplayed()) {
        paymentDisplayService.openPaymentAt(ShopCategoryEnum.PREMIUM);
      }
    }

    private function onRejectClick(param1:MouseEvent) : void {
      this.closeNotification();
    }

    override protected function closeNotification() : void {
      hide();
    }

    override protected function resize() : void {
      this._baseMessageLabel.x = GAP + 9;
      this._baseMessageLabel.y = GAP + 5;
      _innerHeight = this._baseMessageLabel.y + this._baseMessageLabel.height - 3;
      var local1:int = this._baseMessageLabel.x + this._baseMessageLabel.width + GAP * 2;
      if(local1 > _width) {
        _width = local1;
      }
      var local2:int = _innerHeight + 16;
      this._acceptButton.x = GAP;
      this._acceptButton.y = local2;
      this._rejectButton.x = _width - this._rejectButton.width - GAP;
      this._rejectButton.y = local2;
      _height = this._acceptButton.y + this._acceptButton.height + GAP + 1;
      super.resize();
    }
  }
}
