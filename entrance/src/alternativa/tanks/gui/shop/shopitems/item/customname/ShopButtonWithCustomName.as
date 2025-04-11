package alternativa.tanks.gui.shop.shopitems.item.customname {
  import alternativa.tanks.gui.shop.shopitems.item.AbstractGarageItemShopItemButton;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopButtonWithCustomName extends AbstractGarageItemShopItemButton {
    private var shopItemName:String;

    public function ShopButtonWithCustomName(param1:IGameObject, param2:String) {
      this.shopItemName = param2;
      super(param1);
    }

    override protected function getNameLabelValue(param1:IGameObject) : String {
      return this.shopItemName;
    }
  }
}
