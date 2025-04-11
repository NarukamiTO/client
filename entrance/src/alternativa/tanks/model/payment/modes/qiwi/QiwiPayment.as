package alternativa.tanks.model.payment.modes.qiwi {
  import projects.tanks.client.panel.model.payment.modes.qiwi.CountryPhoneInfo;

  [ModelInterface]
  public interface QiwiPayment {
    function getPaymentUrlAsync(param1:String) : void;
    function getCountryPhoneInfo() : Vector.<CountryPhoneInfo>;
  }
}
