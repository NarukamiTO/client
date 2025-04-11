package alternativa.tanks.model.payment.modes.paygarden {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.modes.paygarden.PayGardenProductType;

  public class PayGardenPaymentEvents implements PayGardenPayment {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayGardenPaymentEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getProductType() : PayGardenProductType {
      var result:PayGardenProductType = null;
      var i:int = 0;
      var m:PayGardenPayment = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayGardenPayment(this.impl[i]);
          result = m.getProductType();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
