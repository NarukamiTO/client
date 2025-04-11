package alternativa.tanks.model.item.kit {
  import alternativa.tanks.model.item.discount.DiscountInfo;
  import alternativa.tanks.model.item.discount.ICollectDiscount;
  import alternativa.tanks.model.item.discount.IDiscount;
  import alternativa.tanks.model.item.discount.IDiscountCollector;
  import alternativa.tanks.service.item.ItemService;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.garage.models.item.kit.GarageKitModelBase;
  import projects.tanks.client.garage.models.item.kit.IGarageKitModelBase;
  import projects.tanks.client.garage.models.item.kit.KitItem;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class GarageKitModel extends GarageKitModelBase implements IGarageKitModelBase, GarageKit, ICollectDiscount {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var userPropertyService:IUserPropertiesService;

    public function GarageKitModel() {
      super();
    }

    public function getImage() : ImageResource {
      return getInitParam().image;
    }

    public function getPrice() : int {
      var local1:int = this.getPriceWithoutDiscount();
      var local2:IDiscount = IDiscount(object.adapt(IDiscount));
      return local2.applyDiscount(local1);
    }

    public function getPriceWithoutDiscount() : int {
      var local2:KitItem = null;
      var local1:int = 0;
      for each(local2 in this.getItems()) {
        local1 += itemService.getPriceWithoutDiscount(local2.item) * local2.count;
      }
      return local1;
    }

    public function getPriceAlreadyBought() : int {
      var local2:KitItem = null;
      var local1:int = 0;
      for each(local2 in this.getItems()) {
        if(Boolean(itemService.hasItem(local2.item)) && !itemService.isCountable(local2.item) && itemService.getCategory(local2.item) != ItemCategoryEnum.PLUGIN) {
          local1 += itemService.getPrice(local2.item) * local2.count;
        }
      }
      return local1;
    }

    public function getPriceYouSave() : int {
      return this.getPriceWithoutDiscount() - this.getPrice() - this.getPriceAlreadyBought();
    }

    public function canBuy() : Boolean {
      var local1:KitItem = null;
      for each(local1 in this.getItems()) {
        if(!itemService.hasItem(local1.item) && itemService.getMinRankIndex(local1.item) > userPropertyService.rank) {
          return true;
        }
      }
      return this.getPriceYouSave() > 0;
    }

    public function getItems() : Vector.<KitItem> {
      return getInitParam().kitItems;
    }

    public function collectDiscountsInfo(param1:IDiscountCollector) : void {
      param1.addDiscount(new DiscountInfo(getInitParam().discountInPercent,0));
    }
  }
}
