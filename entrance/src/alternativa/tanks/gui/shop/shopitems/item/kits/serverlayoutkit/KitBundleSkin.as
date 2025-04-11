package alternativa.tanks.gui.shop.shopitems.item.kits.serverlayoutkit {
  import alternativa.tanks.gui.shop.shopitems.item.base.ButtonItemSkin;
  import projects.tanks.client.panel.model.shop.clientlayoutkit.KitBundleViewCC;

  public class KitBundleSkin extends ButtonItemSkin {
    public function KitBundleSkin(param1:KitBundleViewCC) {
      super();
      normalState = param1.button.data;
      overState = param1.buttonOver.data;
    }
  }
}
