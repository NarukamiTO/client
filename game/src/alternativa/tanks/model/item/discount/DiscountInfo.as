package alternativa.tanks.model.item.discount {
  import flash.utils.getTimer;

  public class DiscountInfo {
    public static const NO_DISCOUNT:DiscountInfo = new DiscountInfo(0,0,0);
    public static const FULL_DISCOUNT:DiscountInfo = new DiscountInfo(100);

    private var discountInPercent:int;
    private var beginTime:uint;
    private var endTime:uint;

    public function DiscountInfo(param1:int, param2:uint = 0, param3:uint = 4294967295) {
      super();
      if(getTimer() > param3) {
        param1 = 0;
        param2 = 0;
        param3 = 0;
        return;
      }
      this.discountInPercent = param1;
      this.beginTime = param2;
      this.endTime = param3;
    }

    public function getDiscountInPercent() : int {
      return this.discountInPercent;
    }

    public function getBeginTime() : uint {
      return this.beginTime;
    }

    public function getEndTime() : uint {
      return this.endTime;
    }

    public function isDiscountTime(param1:uint) : Boolean {
      return this.beginTime <= param1 && param1 < this.endTime;
    }

    public function hasDiscount() : Boolean {
      return this.discountInPercent > 0;
    }
  }
}
