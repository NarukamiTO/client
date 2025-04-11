package projects.tanks.client.panel.model.shop.androidspecialoffer.offers {
  public class AndroidSpecialOfferModelCC {
    private var _oldPrice:Number;
    private var _price:Number;
    private var _saleInPercent:int;
    private var _timeLeftInSec:int;
    private var _timeLimited:Boolean;

    public function AndroidSpecialOfferModelCC(param1:Number = 0, param2:Number = 0, param3:int = 0, param4:int = 0, param5:Boolean = false) {
      super();
      this._oldPrice = param1;
      this._price = param2;
      this._saleInPercent = param3;
      this._timeLeftInSec = param4;
      this._timeLimited = param5;
    }

    public function get oldPrice() : Number {
      return this._oldPrice;
    }

    public function set oldPrice(param1:Number) : void {
      this._oldPrice = param1;
    }

    public function get price() : Number {
      return this._price;
    }

    public function set price(param1:Number) : void {
      this._price = param1;
    }

    public function get saleInPercent() : int {
      return this._saleInPercent;
    }

    public function set saleInPercent(param1:int) : void {
      this._saleInPercent = param1;
    }

    public function get timeLeftInSec() : int {
      return this._timeLeftInSec;
    }

    public function set timeLeftInSec(param1:int) : void {
      this._timeLeftInSec = param1;
    }

    public function get timeLimited() : Boolean {
      return this._timeLimited;
    }

    public function set timeLimited(param1:Boolean) : void {
      this._timeLimited = param1;
    }

    public function toString() : String {
      var local1:String = "AndroidSpecialOfferModelCC [";
      local1 += "oldPrice = " + this.oldPrice + " ";
      local1 += "price = " + this.price + " ";
      local1 += "saleInPercent = " + this.saleInPercent + " ";
      local1 += "timeLeftInSec = " + this.timeLeftInSec + " ";
      local1 += "timeLimited = " + this.timeLimited + " ";
      return local1 + "]";
    }
  }
}
