package alternativa.tanks.model.item.discount {
  public class DiscountCollector implements IDiscountCollector {
    private var discounts:Vector.<DiscountInfo> = new Vector.<DiscountInfo>();

    public function DiscountCollector() {
      super();
    }

    public function addDiscount(param1:DiscountInfo) : void {
      if(param1.hasDiscount()) {
        this.discounts.push(param1);
      }
    }

    public function getDiscountInfoes() : Vector.<DiscountInfo> {
      return this.discounts;
    }
  }
}
