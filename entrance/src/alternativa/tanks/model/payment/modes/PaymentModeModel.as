package alternativa.tanks.model.payment.modes {
  import alternativa.tanks.model.payment.PaymentUtils;
  import alternativa.tanks.model.payment.category.PayFullDescription;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.service.payment.IPaymentService;
  import flash.net.navigateToURL;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.panel.model.payment.modes.IPaymentModeModelBase;
  import projects.tanks.client.panel.model.payment.modes.PaymentModeModelBase;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  [ModelInfo]
  public class PaymentModeModel extends PaymentModeModelBase implements IPaymentModeModelBase, PayMode, PayFullDescription, PayUrl {
    [Inject]
    public static var paymentService:IPaymentService;

    [Inject]
    public static var partnersService:IPartnerService;

    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function PaymentModeModel() {
      super();
    }

    public function setDiscount(param1:Boolean) : void {
      putData(Boolean,param1);
    }

    public function isDiscount() : Boolean {
      return getData(Boolean);
    }

    public function getDescription() : String {
      return getInitParam().description + "\n";
    }

    public function hasCustomManualDescription() : Boolean {
      return this.getCustomManualDescription() != null;
    }

    public function getCustomManualDescription() : String {
      return getInitParam().customManualDescription;
    }

    public function getImage() : ImageResource {
      return getInitParam().image;
    }

    public function getName() : String {
      return getInitParam().name;
    }

    public function getOrderIndex() : int {
      return getInitParam().order;
    }

    public function getFullDescription() : String {
      var local3:String = null;
      var local1:String = this.getDescription();
      var local2:String = this.getManualDescription();
      local1 = local1 + "\n" + local2 + "\n";
      if(object.hasModel(PayModeDescription)) {
        local3 = PayModeDescription(object.adapt(PayModeDescription)).getDescription();
        if(local3 != null && local3 != "") {
          if(PayModeDescription(object.adapt(PayModeDescription)).rewriteCategoryDescription()) {
            local1 = local3 + "\n" + local2;
          } else {
            local1 += "\n" + local3;
          }
        }
      }
      return local1;
    }

    private function getManualDescription() : String {
      if(partnersService.isRunningInsidePartnerEnvironment()) {
        return "";
      }
      if(this.hasCustomManualDescription()) {
        return this.getCustomManualDescription();
      }
      return paymentService.getManualDescription();
    }

    public function objectLoaded() : void {
      putData(Boolean,false);
    }

    public function forceGoToUrl(param1:PaymentRequestUrl) : void {
      navigateToURL(PaymentUtils.createUrlRequest(param1),"_blank");
      paymentWindowService.switchToBeginning();
    }

    public function forceGoToOrderedUrl(param1:PaymentRequestUrl) : void {
      navigateToURL(PaymentUtils.createOrderedUrlRequest(param1),"_blank");
      paymentWindowService.switchToBeginning();
    }
  }
}
