package alternativa.tanks.model.payment.shop.lootbox {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.lootbox.ILootBoxPackageModelBase;
  import projects.tanks.client.panel.model.shop.lootbox.LootBoxPackageModelBase;

  [ModelInfo]
  public class LootBoxPackageModel extends LootBoxPackageModelBase implements ILootBoxPackageModelBase, ShopItemView, LootBoxPackage {
    public function LootBoxPackageModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      return new LootBoxPackageButton(object);
    }

    public function getCount() : int {
      return getInitParam().count;
    }
  }
}
