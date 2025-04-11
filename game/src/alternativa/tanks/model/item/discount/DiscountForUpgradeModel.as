package alternativa.tanks.model.item.discount {
  import alternativa.tanks.service.item.ItemService;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.upgradeable.discount.DiscountForUpgradeModelBase;
  import projects.tanks.client.garage.models.item.upgradeable.discount.IDiscountForUpgradeModelBase;

  [ModelInfo]
  public class DiscountForUpgradeModel extends DiscountForUpgradeModelBase implements IDiscountForUpgradeModelBase, ICollectDiscount {
    [Inject]
    public static var itemService:ItemService;

    public function DiscountForUpgradeModel() {
      super();
    }

    public function collectDiscountsInfo(param1:IDiscountCollector) : void {
      var local2:IGameObject = itemService.getPreviousModification(object);
      if(local2 != null && Boolean(itemService.getUpgradableItemParams(local2).isFullUpgraded())) {
        param1.addDiscount(DiscountInfo.FULL_DISCOUNT);
      }
    }
  }
}
