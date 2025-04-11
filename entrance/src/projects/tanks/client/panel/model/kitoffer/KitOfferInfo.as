package projects.tanks.client.panel.model.kitoffer {
  import platform.client.fp10.core.resource.types.LocalizedImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class KitOfferInfo {
    private var _currencyName:String;
    private var _currencyRoundPrecision:int;
    private var _image:LocalizedImageResource;
    private var _price:Number;
    private var _shopItem:IGameObject;

    public function KitOfferInfo(param1:String = null, param2:int = 0, param3:LocalizedImageResource = null, param4:Number = 0, param5:IGameObject = null) {
      super();
      this._currencyName = param1;
      this._currencyRoundPrecision = param2;
      this._image = param3;
      this._price = param4;
      this._shopItem = param5;
    }

    public function get currencyName() : String {
      return this._currencyName;
    }

    public function set currencyName(param1:String) : void {
      this._currencyName = param1;
    }

    public function get currencyRoundPrecision() : int {
      return this._currencyRoundPrecision;
    }

    public function set currencyRoundPrecision(param1:int) : void {
      this._currencyRoundPrecision = param1;
    }

    public function get image() : LocalizedImageResource {
      return this._image;
    }

    public function set image(param1:LocalizedImageResource) : void {
      this._image = param1;
    }

    public function get price() : Number {
      return this._price;
    }

    public function set price(param1:Number) : void {
      this._price = param1;
    }

    public function get shopItem() : IGameObject {
      return this._shopItem;
    }

    public function set shopItem(param1:IGameObject) : void {
      this._shopItem = param1;
    }

    public function toString() : String {
      var local1:String = "KitOfferInfo [";
      local1 += "currencyName = " + this.currencyName + " ";
      local1 += "currencyRoundPrecision = " + this.currencyRoundPrecision + " ";
      local1 += "image = " + this.image + " ";
      local1 += "price = " + this.price + " ";
      local1 += "shopItem = " + this.shopItem + " ";
      return local1 + "]";
    }
  }
}
