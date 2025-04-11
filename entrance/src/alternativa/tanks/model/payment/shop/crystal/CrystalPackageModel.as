package alternativa.tanks.model.payment.shop.crystal {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.crystalitem.CrystalPackageButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import alternativa.tanks.model.payment.shop.cashpackage.CashPackage;
  import projects.tanks.client.panel.model.shop.crystalpackage.CrystalPackageModelBase;
  import projects.tanks.client.panel.model.shop.crystalpackage.ICrystalPackageModelBase;

  [ModelInfo]
  public class CrystalPackageModel extends CrystalPackageModelBase implements ICrystalPackageModelBase, CrystalPackage, CashPackage, ShopItemView {
    public function CrystalPackageModel() {
      super();
    }

    public function getAmount() : int {
      return getInitParam().crystals;
    }

    public function getBonusAmount() : int {
      return getInitParam().bonusCrystals;
    }

    public function getPremiumDurationInDays() : int {
      return getInitParam().premiumDurationInDays;
    }

    public function getButtonView() : ShopButton {
      return new CrystalPackageButton(object);
    }
  }
}
