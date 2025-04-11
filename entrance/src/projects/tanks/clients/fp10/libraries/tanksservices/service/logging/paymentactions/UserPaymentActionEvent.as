package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions {
  import flash.events.Event;
  import projects.tanks.client.tanksservices.model.logging.payment.PaymentAction;

  public class UserPaymentActionEvent extends Event {
    public static const TYPE:String = "UserPaymentActionEvent";

    private var paymentAction:PaymentAction;
    private var countryCode:String;
    private var payModeId:String;
    private var shopItemId:String;
    private var layoutName:String;

    public function UserPaymentActionEvent(param1:PaymentAction) {
      this.paymentAction = param1;
      super(TYPE);
    }

    public function getPaymentAction() : PaymentAction {
      return this.paymentAction;
    }

    public function getCountryCode() : String {
      return this.countryCode;
    }

    public function setCountryCode(param1:String) : void {
      this.countryCode = param1;
    }

    public function getPayModeId() : String {
      return this.payModeId;
    }

    public function setPayModeId(param1:String) : void {
      this.payModeId = param1;
    }

    public function getShopItemId() : String {
      return this.shopItemId;
    }

    public function setShopItemId(param1:String) : void {
      this.shopItemId = param1;
    }

    public function getLayoutName() : String {
      return this.layoutName;
    }

    public function setLayoutName(param1:String) : void {
      this.layoutName = param1;
    }
  }
}
