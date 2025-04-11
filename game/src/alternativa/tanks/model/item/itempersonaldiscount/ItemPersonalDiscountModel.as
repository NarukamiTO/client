package alternativa.tanks.model.item.itempersonaldiscount {
  import alternativa.tanks.model.item.discount.DiscountInfo;
  import alternativa.tanks.model.item.discount.ICollectDiscount;
  import alternativa.tanks.model.item.discount.IDiscountCollector;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.garage.models.item.itempersonaldiscount.DiscountData;
  import projects.tanks.client.garage.models.item.itempersonaldiscount.IItemPersonalDiscountModelBase;
  import projects.tanks.client.garage.models.item.itempersonaldiscount.ItemPersonalDiscountModelBase;

  [ModelInfo]
  public class ItemPersonalDiscountModel extends ItemPersonalDiscountModelBase implements IItemPersonalDiscountModelBase, ICollectDiscount, ObjectLoadListener {
    private static const DELAY_IN_SECONDS:int = 5;

    public function ItemPersonalDiscountModel() {
      super();
    }

    public function objectLoaded() : void {
      var local4:DiscountData = null;
      var local5:uint = 0;
      var local1:Vector.<DiscountInfo> = new Vector.<DiscountInfo>();
      var local2:Vector.<DiscountData> = getInitParam().discounts;
      var local3:int = 0;
      while(local3 < local2.length) {
        local4 = local2[local3];
        local5 = uint(getTimer() + (local4.duration - DELAY_IN_SECONDS) * 1000);
        local1[local3] = new DiscountInfo(local4.discountForPercent,0,local5);
        local3++;
      }
      putData(DiscountInfo,local1);
    }

    public function collectDiscountsInfo(param1:IDiscountCollector) : void {
      var local2:DiscountInfo = null;
      for each(local2 in Vector.<DiscountInfo>(getData(DiscountInfo))) {
        param1.addDiscount(local2);
      }
    }
  }
}
