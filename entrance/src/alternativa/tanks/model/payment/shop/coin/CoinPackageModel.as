package alternativa.tanks.model.payment.shop.coin {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.cashpackage.CashPackageButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import alternativa.tanks.model.payment.shop.cashpackage.CashPackage;
  import projects.tanks.client.panel.model.shop.coinpackage.CoinPackageModelBase;
  import projects.tanks.client.panel.model.shop.coinpackage.ICoinPackageModelBase;

  [ModelInfo]
  public class CoinPackageModel extends CoinPackageModelBase implements ICoinPackageModelBase, CashPackage, ShopItemView {
    public function CoinPackageModel() {
      super();
    }

    public function getAmount() : int {
      return getInitParam().amount;
    }

    public function getBonusAmount() : int {
      return getInitParam().bonusAmount;
    }

    public function getButtonView() : ShopButton {
      return new CashPackageButton(object);
    }
  }
}
