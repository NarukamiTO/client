package alternativa.tanks.model.item.discount.proabonement {
  import alternativa.tanks.model.item.discount.DiscountInfo;
  import alternativa.tanks.model.item.discount.ICollectDiscount;
  import alternativa.tanks.model.item.discount.IDiscountCollector;
  import projects.tanks.client.garage.models.item.discount.proabonement.IProAbonementRankDiscountModelBase;
  import projects.tanks.client.garage.models.item.discount.proabonement.ProAbonementRankDiscountModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class ProAbonementRankDiscountModel extends ProAbonementRankDiscountModelBase implements IProAbonementRankDiscountModelBase, ICollectDiscount, ProAbonementRankDiscount {
    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private static const MAX_RANK_INDEX:int = 31;

    public function ProAbonementRankDiscountModel() {
      super();
    }

    public function collectDiscountsInfo(param1:IDiscountCollector) : void {
      param1.addDiscount(new DiscountInfo(this.getRankDiscount()));
    }

    public function getRankDiscount() : int {
      return getInitParam().percentDiscountPerRank * (MAX_RANK_INDEX - userPropertiesService.rank);
    }
  }
}
