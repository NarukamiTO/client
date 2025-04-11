package projects.tanks.client.panel.model.shop.price {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class ShopItemCC {
    private var _currencyName:String;
    private var _preview:ImageResource;
    private var _price:Number;
    private var _roundingPrecision:int;

    public function ShopItemCC(param1:String = null, param2:ImageResource = null, param3:Number = 0, param4:int = 0) {
      super();
      this._currencyName = param1;
      this._preview = param2;
      this._price = param3;
      this._roundingPrecision = param4;
    }

    public function get currencyName() : String {
      return this._currencyName;
    }

    public function set currencyName(param1:String) : void {
      this._currencyName = param1;
    }

    public function get preview() : ImageResource {
      return this._preview;
    }

    public function set preview(param1:ImageResource) : void {
      this._preview = param1;
    }

    public function get price() : Number {
      return this._price;
    }

    public function set price(param1:Number) : void {
      this._price = param1;
    }

    public function get roundingPrecision() : int {
      return this._roundingPrecision;
    }

    public function set roundingPrecision(param1:int) : void {
      this._roundingPrecision = param1;
    }

    public function toString() : String {
      var local1:String = "ShopItemCC [";
      local1 += "currencyName = " + this.currencyName + " ";
      local1 += "preview = " + this.preview + " ";
      local1 += "price = " + this.price + " ";
      local1 += "roundingPrecision = " + this.roundingPrecision + " ";
      return local1 + "]";
    }
  }
}
