package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class PayUrlAdapt implements PayUrl {
    private var object:IGameObject;
    private var impl:PayUrl;

    public function PayUrlAdapt(param1:IGameObject, param2:PayUrl) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function forceGoToUrl(param1:PaymentRequestUrl) : void {
      var url:PaymentRequestUrl = param1;
      try {
        Model.object = this.object;
        this.impl.forceGoToUrl(url);
      }
      finally {
        Model.popObject();
      }
    }

    public function forceGoToOrderedUrl(param1:PaymentRequestUrl) : void {
      var url:PaymentRequestUrl = param1;
      try {
        Model.object = this.object;
        this.impl.forceGoToOrderedUrl(url);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
