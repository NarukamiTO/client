package alternativa.tanks.model.item.premium {
  import projects.tanks.client.garage.models.item.premium.IPremiumItemModelBase;
  import projects.tanks.client.garage.models.item.premium.PremiumItemModelBase;

  [ModelInfo]
  public class PremiumItemModel extends PremiumItemModelBase implements IPremiumItemModelBase, PremiumItem {
    public function PremiumItemModel() {
      super();
    }

    public function isPremiumItem() : Boolean {
      return getInitParam().premiumItem;
    }
  }
}
