package alternativa.tanks.model.payment.shop {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemViewAdapt implements ShopItemView {
    private var object:IGameObject;
    private var impl:ShopItemView;

    public function ShopItemViewAdapt(param1:IGameObject, param2:ShopItemView) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getButtonView() : ShopButton {
      var result:ShopButton = null;
      try {
        Model.object = this.object;
        result = this.impl.getButtonView();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
