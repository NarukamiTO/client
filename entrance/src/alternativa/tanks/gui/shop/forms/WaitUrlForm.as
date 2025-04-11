package alternativa.tanks.gui.shop.forms {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.payment.controls.ProceedButton;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import assets.icons.InputCheckIcon;
  import controls.labels.MouseDisabledLabel;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceed;

  public class WaitUrlForm extends PayModeForm {
    [Inject]
    public static var localeService:ILocaleService;

    private static const PROCEED_BUTTON_WIDTH:int = 100;
    private static const WIDTH:int = 270;
    private static const HEIGHT:int = 60;

    private var proceedButton:ProceedButton;
    private var waitIcon:InputCheckIcon;

    public function WaitUrlForm(param1:IGameObject) {
      super(param1);
      this.addStatusLabel();
      this.addWaitIcon();
      this.addProceedButton();
      this.render();
    }

    private function render() : void {
      this.waitIcon.x = WIDTH - this.waitIcon.width;
      this.proceedButton.x = WIDTH - PROCEED_BUTTON_WIDTH >> 1;
      this.proceedButton.y = HEIGHT - this.proceedButton.height;
    }

    private function addStatusLabel() : void {
      var local1:MouseDisabledLabel = new MouseDisabledLabel();
      local1.text = localeService.getText(TanksLocale.TEXT_LOADING_PAYMENT_PAGE);
      addChild(local1);
    }

    private function addWaitIcon() : void {
      this.waitIcon = new InputCheckIcon();
      addChild(this.waitIcon);
    }

    private function addProceedButton() : void {
      this.proceedButton = new ProceedButton();
      this.proceedButton.label = localeService.getText(TanksLocale.TEXT_PAYMENT_BUTTON_PROCEED_TEXT);
      this.proceedButton.enable = false;
      this.proceedButton.addEventListener(MouseEvent.CLICK,this.onProceedClick);
      this.proceedButton.width = PROCEED_BUTTON_WIDTH;
      addChild(this.proceedButton);
    }

    private function onProceedClick(param1:MouseEvent) : void {
      PayModeProceed(payMode.adapt(PayModeProceed)).proceedPayment();
      logProceedAction();
    }

    override public function activate() : void {
      this.proceedButton.enable = false;
      this.waitIcon.gotoAndStop(1);
      AsyncUrlPayMode(payMode.adapt(AsyncUrlPayMode)).requestAsyncUrl();
    }

    public function onPaymentUrlReceived() : void {
      this.proceedButton.enable = true;
      this.waitIcon.gotoAndStop(2);
    }

    public function onErrorUrlReceived() : void {
      this.waitIcon.gotoAndStop(3);
    }

    override public function destroy() : void {
      super.destroy();
      this.proceedButton.removeEventListener(MouseEvent.CLICK,this.onProceedClick);
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override public function get height() : Number {
      return HEIGHT;
    }
  }
}
