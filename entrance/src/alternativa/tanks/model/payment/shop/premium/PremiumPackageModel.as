package alternativa.tanks.model.payment.shop.premium {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.premiumitem.PremiumPackageButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.premiumpackage.IPremiumPackageModelBase;
  import projects.tanks.client.panel.model.shop.premiumpackage.PremiumPackageModelBase;

  [ModelInfo]
  public class PremiumPackageModel extends PremiumPackageModelBase implements IPremiumPackageModelBase, PremiumPackage, ShopItemView {
    public function PremiumPackageModel() {
      super();
    }

    public function getDurationInDays() : int {
      return getInitParam().durationInDays;
    }

    public function getButtonView() : ShopButton {
      return new PremiumPackageButton(object);
    }
  }
}
