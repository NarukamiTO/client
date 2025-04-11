package alternativa.tanks.model.payment.shop.kitviewresource {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.kitview.IKitViewButtonWithPriceModelBase;
  import projects.tanks.client.panel.model.shop.kitview.KitViewButtonWithPriceModelBase;

  [ModelInfo]
  public class KitViewButtonWithPriceModel extends KitViewButtonWithPriceModelBase implements IKitViewButtonWithPriceModelBase, ShopItemView {
    public function KitViewButtonWithPriceModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      var local1:KitViewResource = KitViewResource(object.adapt(KitViewResource));
      return new BundleButtonWithPrice(object,local1.getButtonKitImage(),local1.getButtonKitOverImage());
    }
  }
}
