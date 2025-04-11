package projects.tanks.client.panel.model.payment {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class PaymentCC {
    private var _currentCategoryType:ShopCategoryEnum;
    private var _hideLinks:Boolean;
    private var _manualDescription:String;
    private var _payModes:Vector.<IGameObject>;
    private var _shopCategories:Vector.<IGameObject>;
    private var _shopItems:Vector.<IGameObject>;

    public function PaymentCC(param1:ShopCategoryEnum = null, param2:Boolean = false, param3:String = null, param4:Vector.<IGameObject> = null, param5:Vector.<IGameObject> = null, param6:Vector.<IGameObject> = null) {
      super();
      this._currentCategoryType = param1;
      this._hideLinks = param2;
      this._manualDescription = param3;
      this._payModes = param4;
      this._shopCategories = param5;
      this._shopItems = param6;
    }

    public function get currentCategoryType() : ShopCategoryEnum {
      return this._currentCategoryType;
    }

    public function set currentCategoryType(param1:ShopCategoryEnum) : void {
      this._currentCategoryType = param1;
    }

    public function get hideLinks() : Boolean {
      return this._hideLinks;
    }

    public function set hideLinks(param1:Boolean) : void {
      this._hideLinks = param1;
    }

    public function get manualDescription() : String {
      return this._manualDescription;
    }

    public function set manualDescription(param1:String) : void {
      this._manualDescription = param1;
    }

    public function get payModes() : Vector.<IGameObject> {
      return this._payModes;
    }

    public function set payModes(param1:Vector.<IGameObject>) : void {
      this._payModes = param1;
    }

    public function get shopCategories() : Vector.<IGameObject> {
      return this._shopCategories;
    }

    public function set shopCategories(param1:Vector.<IGameObject>) : void {
      this._shopCategories = param1;
    }

    public function get shopItems() : Vector.<IGameObject> {
      return this._shopItems;
    }

    public function set shopItems(param1:Vector.<IGameObject>) : void {
      this._shopItems = param1;
    }

    public function toString() : String {
      var local1:String = "PaymentCC [";
      local1 += "currentCategoryType = " + this.currentCategoryType + " ";
      local1 += "hideLinks = " + this.hideLinks + " ";
      local1 += "manualDescription = " + this.manualDescription + " ";
      local1 += "payModes = " + this.payModes + " ";
      local1 += "shopCategories = " + this.shopCategories + " ";
      local1 += "shopItems = " + this.shopItems + " ";
      return local1 + "]";
    }
  }
}
