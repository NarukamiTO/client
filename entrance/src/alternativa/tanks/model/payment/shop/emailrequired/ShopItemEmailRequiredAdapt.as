package alternativa.tanks.model.payment.shop.emailrequired {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemEmailRequiredAdapt implements ShopItemEmailRequired {
    private var object:IGameObject;
    private var impl:ShopItemEmailRequired;

    public function ShopItemEmailRequiredAdapt(param1:IGameObject, param2:ShopItemEmailRequired) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isEmailRequired() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isEmailRequired());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
