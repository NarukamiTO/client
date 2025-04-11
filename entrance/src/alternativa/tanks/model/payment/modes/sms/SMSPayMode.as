package alternativa.tanks.model.payment.modes.sms {
  import projects.tanks.client.panel.model.payment.modes.sms.types.Country;

  [ModelInterface]
  public interface SMSPayMode {
    function getCountries() : Vector.<Country>;
  }
}
