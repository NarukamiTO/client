package projects.tanks.client.battlefield.models.tankparts.armor.simple {
  public class SimpleArmorCC {
    private var _maxHealth:int;

    public function SimpleArmorCC(param1:int = 0) {
      super();
      this._maxHealth = param1;
    }

    public function get maxHealth() : int {
      return this._maxHealth;
    }

    public function set maxHealth(param1:int) : void {
      this._maxHealth = param1;
    }

    public function toString() : String {
      var local1:String = "SimpleArmorCC [";
      local1 += "maxHealth = " + this.maxHealth + " ";
      return local1 + "]";
    }
  }
}
