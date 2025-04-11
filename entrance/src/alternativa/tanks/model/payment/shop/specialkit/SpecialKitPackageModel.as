package alternativa.tanks.model.payment.shop.specialkit {
  import projects.tanks.client.panel.model.shop.specialkit.ISpecialKitPackageModelBase;
  import projects.tanks.client.panel.model.shop.specialkit.SpecialKitPackageCC;
  import projects.tanks.client.panel.model.shop.specialkit.SpecialKitPackageModelBase;

  [ModelInfo]
  public class SpecialKitPackageModel extends SpecialKitPackageModelBase implements ISpecialKitPackageModelBase, SpecialKitPackage {
    public function SpecialKitPackageModel() {
      super();
    }

    public function getCrystalsAmount() : int {
      return getInitParam().crystalsAmount;
    }

    public function getPremiumDurationInDays() : int {
      return getInitParam().premiumDurationInDays;
    }

    public function getEverySupplyAmount() : int {
      return getInitParam().everySupplyAmount;
    }

    public function getGoldAmount() : int {
      return getInitParam().goldAmount;
    }

    public function hasAdditionalItem() : Boolean {
      return getInitParam().withAdditionalItem;
    }

    public function getItemsCount() : int {
      return getInitParam().itemsCount;
    }

    public function getPackageData() : SpecialKitPackageCC {
      return getInitParam();
    }
  }
}
