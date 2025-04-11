package alternativa.tanks.gui.payment.forms.qiwi {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.payment.forms.mobile.PhoneNumberEvent;
  import alternativa.tanks.model.payment.modes.qiwi.QiwiPayment;
  import flash.events.MouseEvent;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceed;

  public class QiwiForm extends PayModeForm {
    internal static const WIDTH:int = 250;
    internal static const HEIGHT:int = 110;

    private static const DEFERRED_RENDERER_DELAY:int = 50;

    private var phoneForm:QiwiPhoneNumberForm;

    public function QiwiForm(param1:IGameObject) {
      super(param1);
      this.phoneForm = new QiwiPhoneNumberForm(this.qiwiPayment.getCountryPhoneInfo());
      addChild(this.phoneForm);
      this.phoneForm.phoneInput.addEventListener(PhoneNumberEvent.CHANGED,this.onNumberChanged);
      this.phoneForm.proceedButton.addEventListener(MouseEvent.CLICK,this.onProceedClick);
    }

    public function showUrlReceived() : void {
      if(this.phoneForm.phoneInput.isPhoneNonEmpty()) {
        this.phoneForm.phoneInput.onValidNumber();
        this.phoneForm.proceedButton.visible = true;
      }
    }

    private function onNumberChanged(param1:PhoneNumberEvent) : void {
      this.phoneForm.proceedButton.visible = false;
      if(param1.isCorrectLength()) {
        this.qiwiPayment.getPaymentUrlAsync(param1.getPhoneNumber());
      } else if(this.phoneForm.phoneInput.isPhoneNonEmpty()) {
        this.phoneForm.phoneInput.onInvalidNumber();
      }
    }

    private function onProceedClick(param1:MouseEvent) : void {
      PayModeProceed(payMode.adapt(PayModeProceed)).proceedPayment();
      logProceedAction();
    }

    override public function activate() : void {
      this.phoneForm.reset();
      this.setupDeferredRender();
    }

    private function setupDeferredRender() : void {
      setTimeout(function():void {
        paymentWindowService.render();
      },DEFERRED_RENDERER_DELAY);
    }

    private function get qiwiPayment() : QiwiPayment {
      return QiwiPayment(payMode.adapt(QiwiPayment));
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override public function get height() : Number {
      return HEIGHT;
    }
  }
}
