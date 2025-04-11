package alternativa.tanks.gui.shop.shopitems.item.details {
  import alternativa.tanks.gui.shop.components.item.GridItemBase;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemDetails extends GridItemBase {
    protected var shopItemObject:IGameObject;

    public function ShopItemDetails(param1:IGameObject) {
      super();
      this.shopItemObject = param1;
      mouseEnabled = false;
    }
  }
}
