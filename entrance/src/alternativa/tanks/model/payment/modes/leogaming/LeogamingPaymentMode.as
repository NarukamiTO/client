package alternativa.tanks.model.payment.modes.leogaming {
  [ModelInterface]
  public interface LeogamingPaymentMode {
    function sendPhone(param1:String) : void;
    function sendCode(param1:String) : void;
  }
}
