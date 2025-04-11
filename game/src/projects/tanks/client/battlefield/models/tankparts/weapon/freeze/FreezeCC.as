package projects.tanks.client.battlefield.models.tankparts.weapon.freeze {
  public class FreezeCC {
    private var _damageAreaConeAngle:Number;
    private var _damageAreaRange:Number;

    public function FreezeCC(param1:Number = 0, param2:Number = 0) {
      super();
      this._damageAreaConeAngle = param1;
      this._damageAreaRange = param2;
    }

    public function get damageAreaConeAngle() : Number {
      return this._damageAreaConeAngle;
    }

    public function set damageAreaConeAngle(param1:Number) : void {
      this._damageAreaConeAngle = param1;
    }

    public function get damageAreaRange() : Number {
      return this._damageAreaRange;
    }

    public function set damageAreaRange(param1:Number) : void {
      this._damageAreaRange = param1;
    }

    public function toString() : String {
      var local1:String = "FreezeCC [";
      local1 += "damageAreaConeAngle = " + this.damageAreaConeAngle + " ";
      local1 += "damageAreaRange = " + this.damageAreaRange + " ";
      return local1 + "]";
    }
  }
}
