package alternativa.tanks.model.payment.shop.serverlayoutkit {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.kits.serverlayoutkit.KitBundleButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.clientlayoutkit.IKitBundleViewModelBase;
  import projects.tanks.client.panel.model.shop.clientlayoutkit.KitBundleViewModelBase;

  [ModelInfo]
  public class KitBundleViewModel extends KitBundleViewModelBase implements IKitBundleViewModelBase, ShopItemView {
    public function KitBundleViewModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      return new KitBundleButton(object,getInitParam());
    }
  }
}
