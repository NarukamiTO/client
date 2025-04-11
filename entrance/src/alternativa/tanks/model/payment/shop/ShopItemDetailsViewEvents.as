package alternativa.tanks.model.payment.shop {
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemDetails;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemDetailsViewEvents implements ShopItemDetailsView {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopItemDetailsViewEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDetailsView() : ShopItemDetails {
      var result:ShopItemDetails = null;
      var i:int = 0;
      var m:ShopItemDetailsView = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemDetailsView(this.impl[i]);
          result = m.getDetailsView();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isDetailedViewRequired() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ShopItemDetailsView = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemDetailsView(this.impl[i]);
          result = Boolean(m.isDetailedViewRequired());
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
