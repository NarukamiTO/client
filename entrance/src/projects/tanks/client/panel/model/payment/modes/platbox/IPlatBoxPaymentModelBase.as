package projects.tanks.client.panel.model.payment.modes.platbox {
  public interface IPlatBoxPaymentModelBase {
    function paymentError() : void;
    function paymentInited() : void;
    function phoneIsInvalid(param1:String) : void;
    function phoneIsValid(param1:String) : void;
  }
}
