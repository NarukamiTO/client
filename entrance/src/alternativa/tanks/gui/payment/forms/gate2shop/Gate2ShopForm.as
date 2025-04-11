package alternativa.tanks.gui.payment.forms.gate2shop {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.EmailBlock;
  import alternativa.tanks.gui.EmailBlockValidationEvent;
  import alternativa.tanks.gui.payment.controls.ProceedButton;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.modes.gate2shop.Gate2ShopPayment;
  import controls.Label;
  import controls.labels.MouseDisabledLabel;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class Gate2ShopForm extends PayModeForm {
    [Inject]
    public static var localeService:ILocaleService;

    private static const PROCEED_BUTTON_WIDTH:int = 100;
    private static const WIDTH:int = 290;
    private static const GAP_BETWEEN_ELEMENTS:int = 16;

    private var descriptionLabel:Label;
    private var proceedButton:ProceedButton;
    private var emailBlock:EmailBlock;

    public function Gate2ShopForm(param1:IGameObject) {
      super(param1);
      this.addDescriptionLabel();
      this.addEmailBlock();
      this.addProceedButton();
    }

    override public function activate() : void {
      if(!this.gate2ShopPayment.emailInputRequired()) {
        AsyncUrlPayMode(payMode.adapt(AsyncUrlPayMode)).requestAsyncUrl();
        logProceedAction();
      }
    }

    private function addDescriptionLabel() : void {
      this.descriptionLabel = new MouseDisabledLabel();
      this.descriptionLabel.text = localeService.getText(TanksLocale.TEXT_GATE_2_SHOP_EMAIL_INPUT_DESCRIPTION);
      this.descriptionLabel.multiline = true;
      this.descriptionLabel.wordWrap = true;
      this.descriptionLabel.width = WIDTH;
      this.descriptionLabel.size = 12;
      addChild(this.descriptionLabel);
    }

    private function addEmailBlock() : void {
      this.emailBlock = new EmailBlock(280,0);
      this.emailBlock.y = this.descriptionLabel.y + this.descriptionLabel.textHeight + GAP_BETWEEN_ELEMENTS;
      this.emailBlock.x = this.descriptionLabel.x;
      this.emailBlock.addEventListener(EmailBlockValidationEvent.EMAIL_VALIDATED_EVENT,this.onEmailValidationEvent);
      addChild(this.emailBlock);
    }

    private function addProceedButton() : void {
      this.proceedButton = new ProceedButton();
      this.proceedButton.label = localeService.getText(TanksLocale.TEXT_PAYMENT_BUTTON_PROCEED_TEXT);
      this.proceedButton.enable = false;
      this.proceedButton.width = PROCEED_BUTTON_WIDTH;
      this.proceedButton.x = WIDTH - PROCEED_BUTTON_WIDTH >> 1;
      this.proceedButton.y = this.emailBlock.y + this.emailBlock.height + GAP_BETWEEN_ELEMENTS;
      this.proceedButton.addEventListener(MouseEvent.CLICK,this.onProceedClick);
      addChild(this.proceedButton);
    }

    private function onProceedClick(param1:MouseEvent) : void {
      this.gate2ShopPayment.registerEmailAndGetPaymentUrl(this.emailBlock.email);
      logProceedAction();
    }

    override public function destroy() : void {
      this.proceedButton.removeEventListener(MouseEvent.CLICK,this.onProceedClick);
      this.proceedButton = null;
      this.emailBlock.removeEventListener(EmailBlockValidationEvent.EMAIL_VALIDATED_EVENT,this.onEmailValidationEvent);
      this.emailBlock.destroy();
      this.emailBlock = null;
      super.destroy();
    }

    private function onEmailValidationEvent(param1:EmailBlockValidationEvent) : void {
      this.proceedButton.enable = param1.isValid;
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override public function get height() : Number {
      return this.proceedButton.y + this.proceedButton.height;
    }

    public function showEmailIsBusy(param1:String) : void {
      this.emailBlock.showEmailIsBusy(param1);
    }

    public function showEmailIsForbidden(param1:String) : void {
      this.emailBlock.showEmailIsForbidden(param1);
    }

    public function showEmailIsFree(param1:String) : void {
      this.emailBlock.showEmailIsFree(param1);
    }

    private function get gate2ShopPayment() : Gate2ShopPayment {
      return Gate2ShopPayment(payMode.adapt(Gate2ShopPayment));
    }

    override public function shouldBeOmitted() : Boolean {
      return !this.gate2ShopPayment.emailInputRequired();
    }
  }
}
