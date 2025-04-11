package alternativa.tanks.model.payment.shop.featuring {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemFeaturingAdapt implements ShopItemFeaturing {
    private var object:IGameObject;
    private var impl:ShopItemFeaturing;

    public function ShopItemFeaturingAdapt(param1:IGameObject, param2:ShopItemFeaturing) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isLocatedInFeaturingCategory() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isLocatedInFeaturingCategory());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isHiddenInOriginalCategory() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isHiddenInOriginalCategory());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPosition() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getPosition());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
