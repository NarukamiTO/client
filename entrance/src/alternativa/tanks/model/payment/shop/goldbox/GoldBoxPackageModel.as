package alternativa.tanks.model.payment.shop.goldbox {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.garageitem.GoldBoxPackageButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.goldboxpackage.GoldBoxPackageModelBase;
  import projects.tanks.client.panel.model.shop.goldboxpackage.IGoldBoxPackageModelBase;

  [ModelInfo]
  public class GoldBoxPackageModel extends GoldBoxPackageModelBase implements IGoldBoxPackageModelBase, GoldBoxPackage, ShopItemView {
    public function GoldBoxPackageModel() {
      super();
    }

    public function getCount() : int {
      return getInitParam().count;
    }

    public function getButtonView() : ShopButton {
      return new GoldBoxPackageButton(object);
    }
  }
}
