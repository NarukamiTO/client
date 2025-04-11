package alternativa.tanks.model.challenge.battlepass {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.customname.DetailsViewWithDescription;
  import alternativa.tanks.gui.shop.shopitems.item.customname.ShopButtonWithCustomName;
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemDetails;
  import alternativa.tanks.model.payment.shop.ShopItemDetailsView;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.challenges.battlepass.BattlePassPackageModelBase;
  import projects.tanks.client.panel.model.shop.challenges.battlepass.IBattlePassPackageModelBase;

  [ModelInfo]
  public class BattlePassPackageModel extends BattlePassPackageModelBase implements IBattlePassPackageModelBase, ShopItemView, ShopItemDetailsView {
    public function BattlePassPackageModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      return new ShopButtonWithCustomName(object,getInitParam().name);
    }

    public function getDetailsView() : ShopItemDetails {
      return new DetailsViewWithDescription(object,getInitParam().description);
    }

    public function isDetailedViewRequired() : Boolean {
      return true;
    }
  }
}
