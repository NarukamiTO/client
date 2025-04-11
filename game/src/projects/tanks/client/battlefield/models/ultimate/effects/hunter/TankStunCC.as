package projects.tanks.client.battlefield.models.ultimate.effects.hunter {
  public class TankStunCC {
    private var _stunned:Boolean;

    public function TankStunCC(param1:Boolean = false) {
      super();
      this._stunned = param1;
    }

    public function get stunned() : Boolean {
      return this._stunned;
    }

    public function set stunned(param1:Boolean) : void {
      this._stunned = param1;
    }

    public function toString() : String {
      var local1:String = "TankStunCC [";
      local1 += "stunned = " + this.stunned + " ";
      return local1 + "]";
    }
  }
}
