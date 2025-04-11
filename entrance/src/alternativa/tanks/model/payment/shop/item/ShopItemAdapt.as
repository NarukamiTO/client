package alternativa.tanks.model.payment.shop.item {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemAdapt implements ShopItem {
    private var object:IGameObject;
    private var impl:ShopItem;

    public function ShopItemAdapt(param1:IGameObject, param2:ShopItem) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPrice() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getPrice());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPriceWithDiscount() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getPriceWithDiscount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCurrencyName() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getCurrencyName();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCurrencyRoundingPrecision() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getCurrencyRoundingPrecision());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPreview() : ImageResource {
      var result:ImageResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getPreview();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
