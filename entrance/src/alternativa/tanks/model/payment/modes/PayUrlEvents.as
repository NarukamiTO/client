package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class PayUrlEvents implements PayUrl {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayUrlEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function forceGoToUrl(param1:PaymentRequestUrl) : void {
      var i:int = 0;
      var m:PayUrl = null;
      var url:PaymentRequestUrl = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayUrl(this.impl[i]);
          m.forceGoToUrl(url);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function forceGoToOrderedUrl(param1:PaymentRequestUrl) : void {
      var i:int = 0;
      var m:PayUrl = null;
      var url:PaymentRequestUrl = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayUrl(this.impl[i]);
          m.forceGoToOrderedUrl(url);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
