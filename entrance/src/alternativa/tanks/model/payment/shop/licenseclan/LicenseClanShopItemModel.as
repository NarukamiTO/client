package alternativa.tanks.model.payment.shop.licenseclan {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.licenseclan.LicenseClanButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.garageitem.licenseclan.ILicenseClanShopItemModelBase;
  import projects.tanks.client.panel.model.shop.garageitem.licenseclan.LicenseClanShopItemModelBase;

  [ModelInfo]
  public class LicenseClanShopItemModel extends LicenseClanShopItemModelBase implements ILicenseClanShopItemModelBase, ShopItemView {
    public function LicenseClanShopItemModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      return new LicenseClanButton(object);
    }
  }
}
