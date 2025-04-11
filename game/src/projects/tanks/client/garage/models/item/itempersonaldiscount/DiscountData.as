package projects.tanks.client.garage.models.item.itempersonaldiscount {
  public class DiscountData {
    private var _discountForPercent:Number;
    private var _duration:int;

    public function DiscountData(param1:Number = 0, param2:int = 0) {
      super();
      this._discountForPercent = param1;
      this._duration = param2;
    }

    public function get discountForPercent() : Number {
      return this._discountForPercent;
    }

    public function set discountForPercent(param1:Number) : void {
      this._discountForPercent = param1;
    }

    public function get duration() : int {
      return this._duration;
    }

    public function set duration(param1:int) : void {
      this._duration = param1;
    }

    public function toString() : String {
      var local1:String = "DiscountData [";
      local1 += "discountForPercent = " + this.discountForPercent + " ";
      local1 += "duration = " + this.duration + " ";
      return local1 + "]";
    }
  }
}
