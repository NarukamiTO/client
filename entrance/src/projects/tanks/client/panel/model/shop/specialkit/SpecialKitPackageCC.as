package projects.tanks.client.panel.model.shop.specialkit {
  public class SpecialKitPackageCC {
    private var _crystalsAmount:int;
    private var _everySupplyAmount:int;
    private var _goldAmount:int;
    private var _itemsCount:int;
    private var _premiumDurationInDays:int;
    private var _showPremiumIcon:Boolean;
    private var _texts:Vector.<ShopKitText>;
    private var _withAdditionalItem:Boolean;

    public function SpecialKitPackageCC(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:Boolean = false, param7:Vector.<ShopKitText> = null, param8:Boolean = false) {
      super();
      this._crystalsAmount = param1;
      this._everySupplyAmount = param2;
      this._goldAmount = param3;
      this._itemsCount = param4;
      this._premiumDurationInDays = param5;
      this._showPremiumIcon = param6;
      this._texts = param7;
      this._withAdditionalItem = param8;
    }

    public function get crystalsAmount() : int {
      return this._crystalsAmount;
    }

    public function set crystalsAmount(param1:int) : void {
      this._crystalsAmount = param1;
    }

    public function get everySupplyAmount() : int {
      return this._everySupplyAmount;
    }

    public function set everySupplyAmount(param1:int) : void {
      this._everySupplyAmount = param1;
    }

    public function get goldAmount() : int {
      return this._goldAmount;
    }

    public function set goldAmount(param1:int) : void {
      this._goldAmount = param1;
    }

    public function get itemsCount() : int {
      return this._itemsCount;
    }

    public function set itemsCount(param1:int) : void {
      this._itemsCount = param1;
    }

    public function get premiumDurationInDays() : int {
      return this._premiumDurationInDays;
    }

    public function set premiumDurationInDays(param1:int) : void {
      this._premiumDurationInDays = param1;
    }

    public function get showPremiumIcon() : Boolean {
      return this._showPremiumIcon;
    }

    public function set showPremiumIcon(param1:Boolean) : void {
      this._showPremiumIcon = param1;
    }

    public function get texts() : Vector.<ShopKitText> {
      return this._texts;
    }

    public function set texts(param1:Vector.<ShopKitText>) : void {
      this._texts = param1;
    }

    public function get withAdditionalItem() : Boolean {
      return this._withAdditionalItem;
    }

    public function set withAdditionalItem(param1:Boolean) : void {
      this._withAdditionalItem = param1;
    }

    public function toString() : String {
      var local1:String = "SpecialKitPackageCC [";
      local1 += "crystalsAmount = " + this.crystalsAmount + " ";
      local1 += "everySupplyAmount = " + this.everySupplyAmount + " ";
      local1 += "goldAmount = " + this.goldAmount + " ";
      local1 += "itemsCount = " + this.itemsCount + " ";
      local1 += "premiumDurationInDays = " + this.premiumDurationInDays + " ";
      local1 += "showPremiumIcon = " + this.showPremiumIcon + " ";
      local1 += "texts = " + this.texts + " ";
      local1 += "withAdditionalItem = " + this.withAdditionalItem + " ";
      return local1 + "]";
    }
  }
}
