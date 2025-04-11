package alternativa.tanks.model.payment.shop.description {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemAdditionalDescriptionEvents implements ShopItemAdditionalDescription {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopItemAdditionalDescriptionEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getAdditionalDescription() : String {
      var result:String = null;
      var i:int = 0;
      var m:ShopItemAdditionalDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemAdditionalDescription(this.impl[i]);
          result = m.getAdditionalDescription();
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
