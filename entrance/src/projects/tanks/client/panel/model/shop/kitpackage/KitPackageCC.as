package projects.tanks.client.panel.model.shop.kitpackage {
  public class KitPackageCC {
    private var _itemInfos:Vector.<KitPackageItemInfo>;
    private var _name:String;
    private var _showDetails:Boolean;

    public function KitPackageCC(param1:Vector.<KitPackageItemInfo> = null, param2:String = null, param3:Boolean = false) {
      super();
      this._itemInfos = param1;
      this._name = param2;
      this._showDetails = param3;
    }

    public function get itemInfos() : Vector.<KitPackageItemInfo> {
      return this._itemInfos;
    }

    public function set itemInfos(param1:Vector.<KitPackageItemInfo>) : void {
      this._itemInfos = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get showDetails() : Boolean {
      return this._showDetails;
    }

    public function set showDetails(param1:Boolean) : void {
      this._showDetails = param1;
    }

    public function toString() : String {
      var local1:String = "KitPackageCC [";
      local1 += "itemInfos = " + this.itemInfos + " ";
      local1 += "name = " + this.name + " ";
      local1 += "showDetails = " + this.showDetails + " ";
      return local1 + "]";
    }
  }
}
