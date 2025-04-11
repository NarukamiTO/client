package alternativa.tanks.gui.shop.shopitems.item.kits.singleitem {
  import alternativa.tanks.gui.shop.shopitems.item.base.ButtonItemSkin;
  import projects.tanks.client.panel.model.shop.specialkit.view.singleitem.SingleItemKitViewCC;

  public class SingleShopItemSkin extends ButtonItemSkin {
    public function SingleShopItemSkin(param1:SingleItemKitViewCC) {
      super();
      normalState = param1.button.data;
      overState = param1.buttonOver.data;
    }
  }
}
