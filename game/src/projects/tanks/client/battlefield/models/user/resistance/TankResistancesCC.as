package projects.tanks.client.battlefield.models.user.resistance {
  public class TankResistancesCC {
    private var _resistances:Vector.<TankResistance>;

    public function TankResistancesCC(param1:Vector.<TankResistance> = null) {
      super();
      this._resistances = param1;
    }

    public function get resistances() : Vector.<TankResistance> {
      return this._resistances;
    }

    public function set resistances(param1:Vector.<TankResistance>) : void {
      this._resistances = param1;
    }

    public function toString() : String {
      var local1:String = "TankResistancesCC [";
      local1 += "resistances = " + this.resistances + " ";
      return local1 + "]";
    }
  }
}
