package alternativa.tanks.model.payment.shop.description {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemAdditionalDescriptionAdapt implements ShopItemAdditionalDescription {
    private var object:IGameObject;
    private var impl:ShopItemAdditionalDescription;

    public function ShopItemAdditionalDescriptionAdapt(param1:IGameObject, param2:ShopItemAdditionalDescription) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getAdditionalDescription() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getAdditionalDescription();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
