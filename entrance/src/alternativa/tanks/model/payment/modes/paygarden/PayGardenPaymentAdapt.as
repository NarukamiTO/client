package alternativa.tanks.model.payment.modes.paygarden {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.modes.paygarden.PayGardenProductType;

  public class PayGardenPaymentAdapt implements PayGardenPayment {
    private var object:IGameObject;
    private var impl:PayGardenPayment;

    public function PayGardenPaymentAdapt(param1:IGameObject, param2:PayGardenPayment) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getProductType() : PayGardenProductType {
      var result:PayGardenProductType = null;
      try {
        Model.object = this.object;
        result = this.impl.getProductType();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
