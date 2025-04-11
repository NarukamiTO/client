package alternativa.tanks.model.item.discount {
  import alternativa.tanks.model.item.discount.proabonement.ProAbonementRankDiscount;
  import flash.utils.getTimer;
  import projects.tanks.client.garage.models.item.discount.DiscountCollectorModelBase;
  import projects.tanks.client.garage.models.item.discount.IDiscountCollectorModelBase;

  [ModelInfo]
  public class DiscountCollectorModel extends DiscountCollectorModelBase implements IDiscountCollectorModelBase, IDiscount {
    public function DiscountCollectorModel() {
      super();
    }

    public function getDiscountInPercent() : int {
      var local2:Number = NaN;
      var local1:Number = this.getDiscount();
      if(object.hasModel(ProAbonementRankDiscount)) {
        local2 = ProAbonementRankDiscount(object.adapt(ProAbonementRankDiscount)).getRankDiscount() * 0.01;
        local1 = (local1 - local2) / (1 - local2);
      }
      return local1 * 100 + 0.0001;
    }

    public function applyDiscount(param1:int) : int {
      var local5:DiscountInfo = null;
      var local6:int = 0;
      var local2:int = getTimer();
      var local3:Vector.<int> = new Vector.<int>();
      var local4:DiscountCollector = new DiscountCollector();
      ICollectDiscount(object.event(ICollectDiscount)).collectDiscountsInfo(local4);
      for each(local5 in local4.getDiscountInfoes()) {
        if(local5.hasDiscount() && local5.isDiscountTime(local2)) {
          local3.push(local5.getDiscountInPercent());
        }
      }
      local3.sort(Array.NUMERIC);
      for each(local6 in local3) {
        param1 = int(param1 * (100 - local6) / 100 + 0.001);
      }
      return param1;
    }

    private function getDiscount() : Number {
      var local4:DiscountInfo = null;
      var local1:Number = 0;
      var local2:int = getTimer();
      var local3:DiscountCollector = new DiscountCollector();
      ICollectDiscount(object.event(ICollectDiscount)).collectDiscountsInfo(local3);
      for each(local4 in local3.getDiscountInfoes()) {
        if(local4.isDiscountTime(local2)) {
          local1 = 1 - (1 - local1) * (1 - local4.getDiscountInPercent() * 0.01);
        }
      }
      return local1;
    }
  }
}
