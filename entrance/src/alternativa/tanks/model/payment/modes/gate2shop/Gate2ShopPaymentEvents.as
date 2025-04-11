package alternativa.tanks.model.payment.modes.gate2shop {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class Gate2ShopPaymentEvents implements Gate2ShopPayment {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function Gate2ShopPaymentEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function emailInputRequired() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:Gate2ShopPayment = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = Gate2ShopPayment(this.impl[i]);
          result = Boolean(m.emailInputRequired());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function registerEmailAndGetPaymentUrl(param1:String) : void {
      var i:int = 0;
      var m:Gate2ShopPayment = null;
      var email:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = Gate2ShopPayment(this.impl[i]);
          m.registerEmailAndGetPaymentUrl(email);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
