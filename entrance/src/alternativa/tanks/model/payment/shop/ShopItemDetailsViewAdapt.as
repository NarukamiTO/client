package alternativa.tanks.model.payment.shop {
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemDetails;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemDetailsViewAdapt implements ShopItemDetailsView {
    private var object:IGameObject;
    private var impl:ShopItemDetailsView;

    public function ShopItemDetailsViewAdapt(param1:IGameObject, param2:ShopItemDetailsView) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDetailsView() : ShopItemDetails {
      var result:ShopItemDetails = null;
      try {
        Model.object = this.object;
        result = this.impl.getDetailsView();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isDetailedViewRequired() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isDetailedViewRequired());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
