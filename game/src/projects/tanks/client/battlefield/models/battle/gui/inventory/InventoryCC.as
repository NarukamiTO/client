package projects.tanks.client.battlefield.models.battle.gui.inventory {
  public class InventoryCC {
    private var _ultimateEnabled:Boolean;

    public function InventoryCC(param1:Boolean = false) {
      super();
      this._ultimateEnabled = param1;
    }

    public function get ultimateEnabled() : Boolean {
      return this._ultimateEnabled;
    }

    public function set ultimateEnabled(param1:Boolean) : void {
      this._ultimateEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "InventoryCC [";
      local1 += "ultimateEnabled = " + this.ultimateEnabled + " ";
      return local1 + "]";
    }
  }
}
