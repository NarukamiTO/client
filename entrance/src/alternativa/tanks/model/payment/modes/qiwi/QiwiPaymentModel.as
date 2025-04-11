package alternativa.tanks.model.payment.modes.qiwi {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.payment.forms.qiwi.QiwiForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.PayUrl;
  import alternativa.tanks.model.payment.modes.errors.ErrorDescription;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.panel.model.payment.modes.qiwi.CountryPhoneInfo;
  import projects.tanks.client.panel.model.payment.modes.qiwi.IQiwiPaymentModelBase;
  import projects.tanks.client.panel.model.payment.modes.qiwi.QiwiPaymentModelBase;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceed;

  [ModelInfo]
  public class QiwiPaymentModel extends QiwiPaymentModelBase implements IQiwiPaymentModelBase, QiwiPayment, PayModeView, PayModeProceed, ObjectLoadListener {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    private var paymentUrl:PaymentRequestUrl;

    public function QiwiPaymentModel() {
      super();
    }

    private static function get errorDescription() : ErrorDescription {
      return ErrorDescription(object.adapt(ErrorDescription));
    }

    public function objectLoaded() : void {
      putData(PayModeForm,new QiwiForm(object));
    }

    public function getView() : PayModeForm {
      return PayModeForm(this.view);
    }

    public function getPaymentUrlAsync(param1:String) : void {
      server.getPaymentUrl(paymentWindowService.getChosenItem().id,"+" + param1);
    }

    public function receiveUrl(param1:PaymentRequestUrl) : void {
      this.paymentUrl = param1;
      this.view.showUrlReceived();
    }

    public function error() : void {
      this.view.activate();
    }

    public function proceedPayment() : void {
      PayUrl(object.adapt(PayUrl)).forceGoToUrl(this.paymentUrl);
    }

    public function getCountryPhoneInfo() : Vector.<CountryPhoneInfo> {
      return getInitParam().countryPhoneCodes;
    }

    private function get view() : QiwiForm {
      return QiwiForm(getData(PayModeForm));
    }
  }
}
