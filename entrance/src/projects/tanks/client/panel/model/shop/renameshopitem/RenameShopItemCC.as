package projects.tanks.client.panel.model.shop.renameshopitem {
  public class RenameShopItemCC {
    private var _name:String;

    public function RenameShopItemCC(param1:String = null) {
      super();
      this._name = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function toString() : String {
      var local1:String = "RenameShopItemCC [";
      local1 += "name = " + this.name + " ";
      return local1 + "]";
    }
  }
}
