package alternativa.tanks.model.payment {
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.service.payment.IPaymentPackagesService;
  import alternativa.tanks.service.payment.IPaymentService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.panel.model.payment.CrystalsPaymentCC;
  import projects.tanks.client.panel.model.payment.CrystalsPaymentModelBase;
  import projects.tanks.client.panel.model.payment.ICrystalsPaymentModelBase;

  [ModelInfo]
  public class CrystalsPaymentModel extends CrystalsPaymentModelBase implements ICrystalsPaymentModelBase, ObjectLoadListener {
    [Inject]
    public static var paymentService:IPaymentService;

    [Inject]
    public static var paymentPackagesService:IPaymentPackagesService;

    [Inject]
    public static var paymentWindow:PaymentWindowService;

    public function CrystalsPaymentModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:CrystalsPaymentCC = getInitParam();
      paymentPackagesService.init(local1);
      paymentService.init(local1);
    }
  }
}
