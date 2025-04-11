package alternativa.tanks.model.payment.shop.specialkit.view {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.kits.newbie.NewbieKitPackageButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.specialkit.view.INewbieKitViewModelBase;
  import projects.tanks.client.panel.model.shop.specialkit.view.NewbieKitViewModelBase;

  [ModelInfo]
  public class NewbieKitViewModel extends NewbieKitViewModelBase implements INewbieKitViewModelBase, ShopItemView {
    public function NewbieKitViewModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      return new NewbieKitPackageButton(object);
    }
  }
}
