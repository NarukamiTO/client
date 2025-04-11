package alternativa.tanks.model.payment.shop.item {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemEvents implements ShopItem {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopItemEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPrice() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:ShopItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItem(this.impl[i]);
          result = Number(m.getPrice());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPriceWithDiscount() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:ShopItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItem(this.impl[i]);
          result = Number(m.getPriceWithDiscount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCurrencyName() : String {
      var result:String = null;
      var i:int = 0;
      var m:ShopItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItem(this.impl[i]);
          result = m.getCurrencyName();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCurrencyRoundingPrecision() : int {
      var result:int = 0;
      var i:int = 0;
      var m:ShopItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItem(this.impl[i]);
          result = int(m.getCurrencyRoundingPrecision());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPreview() : ImageResource {
      var result:ImageResource = null;
      var i:int = 0;
      var m:ShopItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItem(this.impl[i]);
          result = m.getPreview();
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
