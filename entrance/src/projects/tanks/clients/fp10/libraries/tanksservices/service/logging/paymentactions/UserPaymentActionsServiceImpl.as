package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import projects.tanks.client.tanksservices.model.logging.payment.PaymentAction;

  public class UserPaymentActionsServiceImpl extends EventDispatcher implements UserPaymentActionsService {
    public function UserPaymentActionsServiceImpl() {
      super();
    }

    public function openPayment(param1:String) : void {
      var local2:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.OPEN_PAYMENT);
      local2.setLayoutName(param1);
      dispatchEvent(local2);
    }

    public function closePayment(param1:String) : void {
      var local2:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.CLOSE_PAYMENT);
      local2.setLayoutName(param1);
      dispatchEvent(local2);
    }

    public function selectCountry(param1:String) : void {
      var local2:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.COUNTRY_SELECT);
      local2.setCountryCode(param1);
      dispatchEvent(local2);
    }

    public function choosePaymode(param1:Long, param2:Long) : void {
      var local3:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.MODE_CHOOSE);
      local3.setPayModeId(param1.toString());
      local3.setShopItemId(param2.toString());
      dispatchEvent(local3);
    }

    public function chooseItem(param1:Long) : void {
      var local2:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.ITEM_CHOOSE);
      local2.setShopItemId(param1.toString());
      dispatchEvent(local2);
    }

    public function proceed(param1:Long, param2:Long) : void {
      var local3:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.PROCEED);
      local3.setPayModeId(param1.toString());
      local3.setShopItemId(param2.toString());
      dispatchEvent(local3);
    }
  }
}
