package alternativa.tanks.model.payment.modes.paygarden {
  import projects.tanks.client.panel.model.payment.modes.paygarden.PayGardenProductType;

  [ModelInterface]
  public interface PayGardenPayment {
    function getProductType() : PayGardenProductType;
  }
}
