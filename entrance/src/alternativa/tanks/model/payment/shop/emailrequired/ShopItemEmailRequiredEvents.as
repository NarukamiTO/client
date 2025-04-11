package alternativa.tanks.model.payment.shop.emailrequired {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemEmailRequiredEvents implements ShopItemEmailRequired {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopItemEmailRequiredEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isEmailRequired() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ShopItemEmailRequired = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemEmailRequired(this.impl[i]);
          result = Boolean(m.isEmailRequired());
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
