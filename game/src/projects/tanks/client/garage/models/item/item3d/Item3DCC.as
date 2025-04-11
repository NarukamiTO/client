package projects.tanks.client.garage.models.item.item3d {
  public class Item3DCC {
    private var _mounted:Boolean;

    public function Item3DCC(param1:Boolean = false) {
      super();
      this._mounted = param1;
    }

    public function get mounted() : Boolean {
      return this._mounted;
    }

    public function set mounted(param1:Boolean) : void {
      this._mounted = param1;
    }

    public function toString() : String {
      var local1:String = "Item3DCC [";
      local1 += "mounted = " + this.mounted + " ";
      return local1 + "]";
    }
  }
}
