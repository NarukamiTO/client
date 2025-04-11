package projects.tanks.client.garage.models.item.drone {
  public class HasBatteriesNotifyCC {
    private var _hasBatteries:Boolean;

    public function HasBatteriesNotifyCC(param1:Boolean = false) {
      super();
      this._hasBatteries = param1;
    }

    public function get hasBatteries() : Boolean {
      return this._hasBatteries;
    }

    public function set hasBatteries(param1:Boolean) : void {
      this._hasBatteries = param1;
    }

    public function toString() : String {
      var local1:String = "HasBatteriesNotifyCC [";
      local1 += "hasBatteries = " + this.hasBatteries + " ";
      return local1 + "]";
    }
  }
}
