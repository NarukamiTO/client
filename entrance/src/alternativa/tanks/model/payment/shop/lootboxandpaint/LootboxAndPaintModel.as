package alternativa.tanks.model.payment.shop.lootboxandpaint {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.lootboxandpaintkit.ILootboxAndPaintModelBase;
  import projects.tanks.client.panel.model.shop.lootboxandpaintkit.LootboxAndPaintModelBase;

  [ModelInfo]
  public class LootboxAndPaintModel extends LootboxAndPaintModelBase implements ILootboxAndPaintModelBase, ShopItemView {
    public function LootboxAndPaintModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      return new LootboxAndPaintButton(object,getInitParam());
    }
  }
}
