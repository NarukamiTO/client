package projects.tanks.client.garage.models.item.discount {
  public class DiscountCC {
    private var _discount:Number;
    private var _timeLeftInSeconds:int;
    private var _timeToStartInSeconds:int;

    public function DiscountCC(param1:Number = 0, param2:int = 0, param3:int = 0) {
      super();
      this._discount = param1;
      this._timeLeftInSeconds = param2;
      this._timeToStartInSeconds = param3;
    }

    public function get discount() : Number {
      return this._discount;
    }

    public function set discount(param1:Number) : void {
      this._discount = param1;
    }

    public function get timeLeftInSeconds() : int {
      return this._timeLeftInSeconds;
    }

    public function set timeLeftInSeconds(param1:int) : void {
      this._timeLeftInSeconds = param1;
    }

    public function get timeToStartInSeconds() : int {
      return this._timeToStartInSeconds;
    }

    public function set timeToStartInSeconds(param1:int) : void {
      this._timeToStartInSeconds = param1;
    }

    public function toString() : String {
      var local1:String = "DiscountCC [";
      local1 += "discount = " + this.discount + " ";
      local1 += "timeLeftInSeconds = " + this.timeLeftInSeconds + " ";
      local1 += "timeToStartInSeconds = " + this.timeToStartInSeconds + " ";
      return local1 + "]";
    }
  }
}
