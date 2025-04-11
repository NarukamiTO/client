package alternativa.tanks.model.payment.modes.gate2shop {
  [ModelInterface]
  public interface Gate2ShopPayment {
    function emailInputRequired() : Boolean;
    function registerEmailAndGetPaymentUrl(param1:String) : void;
  }
}
