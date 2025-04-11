package projects.tanks.client.battleservice {
  public class BattleRoundParameters {
    private var _reArmorEnabled:Boolean;

    public function BattleRoundParameters(param1:Boolean = false) {
      super();
      this._reArmorEnabled = param1;
    }

    public function get reArmorEnabled() : Boolean {
      return this._reArmorEnabled;
    }

    public function set reArmorEnabled(param1:Boolean) : void {
      this._reArmorEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "BattleRoundParameters [";
      local1 += "reArmorEnabled = " + this.reArmorEnabled + " ";
      return local1 + "]";
    }
  }
}
