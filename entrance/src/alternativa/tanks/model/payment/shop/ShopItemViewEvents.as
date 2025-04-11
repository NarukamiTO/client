package alternativa.tanks.model.payment.shop {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemViewEvents implements ShopItemView {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopItemViewEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getButtonView() : ShopButton {
      var result:ShopButton = null;
      var i:int = 0;
      var m:ShopItemView = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemView(this.impl[i]);
          result = m.getButtonView();
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
