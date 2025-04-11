package alternativa.tanks.model.payment.shop.specialkit.view {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.kits.singleitem.SingleKitButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.specialkit.view.singleitem.ISingleItemKitViewModelBase;
  import projects.tanks.client.panel.model.shop.specialkit.view.singleitem.SingleItemKitViewModelBase;

  [ModelInfo]
  public class SingleItemKitViewModel extends SingleItemKitViewModelBase implements ISingleItemKitViewModelBase, ShopItemView {
    public function SingleItemKitViewModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      return new SingleKitButton(object,getInitParam());
    }
  }
}
