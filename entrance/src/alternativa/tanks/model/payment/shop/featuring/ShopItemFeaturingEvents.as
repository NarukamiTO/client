package alternativa.tanks.model.payment.shop.featuring {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemFeaturingEvents implements ShopItemFeaturing {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopItemFeaturingEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isLocatedInFeaturingCategory() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ShopItemFeaturing = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemFeaturing(this.impl[i]);
          result = Boolean(m.isLocatedInFeaturingCategory());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isHiddenInOriginalCategory() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ShopItemFeaturing = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemFeaturing(this.impl[i]);
          result = Boolean(m.isHiddenInOriginalCategory());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPosition() : int {
      var result:int = 0;
      var i:int = 0;
      var m:ShopItemFeaturing = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemFeaturing(this.impl[i]);
          result = int(m.getPosition());
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
