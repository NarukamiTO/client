package alternativa.tanks.model.payment.shop.kit.view {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.kits.KitPackageButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.kitpackage.view.IKitPackageViewModelBase;
  import projects.tanks.client.panel.model.shop.kitpackage.view.KitPackageViewModelBase;

  [ModelInfo]
  public class KitPackageViewModel extends KitPackageViewModelBase implements IKitPackageViewModelBase, ShopItemView {
    public function KitPackageViewModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      return new KitPackageButton(object);
    }
  }
}
