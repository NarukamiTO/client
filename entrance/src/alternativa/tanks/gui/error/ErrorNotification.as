package alternativa.tanks.gui.error {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import platform.client.fp10.core.service.address.AddressService;
  import projects.tanks.clients.flash.commons.services.notification.Notification;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ErrorNotification extends Notification {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var addressService:AddressService;

    private static const DEFAULT_BUTTON_WIDTH:int = 96;

    private var messageLabel:LabelBase;
    private var okButton:DefaultButtonBase;
    private var reenterButton:DefaultButtonBase;

    public function ErrorNotification() {
      super(null,TanksLocale.TEXT_ERROR_FATAL);
      this.messageLabel = new LabelBase();
      this.messageLabel.text = localeService.getText(TanksLocale.TEXT_ERROR_FATAL);
      this.messageLabel.color = ColorConstants.GREEN_LABEL;
      this.messageLabel.mouseEnabled = false;
      addChild(this.messageLabel);
      this.reenterButton = new DefaultButtonBase();
      this.reenterButton.width = DEFAULT_BUTTON_WIDTH + 15;
      this.reenterButton.label = localeService.getText(TanksLocale.TEXT_REENTER_TO_GAME);
      addChild(this.reenterButton);
      this.okButton = new DefaultButtonBase();
      this.okButton.width = DEFAULT_BUTTON_WIDTH;
      this.okButton.label = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK);
      addChild(this.okButton);
      this.reenterButton.addEventListener(MouseEvent.CLICK,this.onReenterClick,false,0,true);
      this.okButton.addEventListener(MouseEvent.CLICK,this.onCancelClick,false,0,true);
    }

    private function onCancelClick(param1:MouseEvent) : void {
      hide();
    }

    private function onReenterClick(param1:MouseEvent) : void {
      if(addressService != null) {
        addressService.reload();
      }
    }

    override protected function resize() : void {
      this.messageLabel.x = GAP + 9;
      this.messageLabel.y = GAP + 11;
      _innerHeight = this.messageLabel.y + this.messageLabel.height - 3;
      var local1:int = this.messageLabel.x + this.messageLabel.width + GAP * 2;
      if(local1 > _width) {
        _width = local1;
      }
      var local2:int = _innerHeight + 16;
      this.okButton.x = GAP;
      this.okButton.y = local2;
      this.reenterButton.x = _width - this.reenterButton.width - GAP;
      this.reenterButton.y = local2;
      _height = this.reenterButton.y + this.reenterButton.height + GAP + 1;
      super.resize();
    }
  }
}
