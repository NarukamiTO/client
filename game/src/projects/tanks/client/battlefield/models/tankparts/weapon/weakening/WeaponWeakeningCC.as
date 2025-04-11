package projects.tanks.client.battlefield.models.tankparts.weapon.weakening {
  public class WeaponWeakeningCC {
    private var _maximumDamageRadius:Number;
    private var _minimumDamagePercent:Number;
    private var _minimumDamageRadius:Number;

    public function WeaponWeakeningCC(param1:Number = 0, param2:Number = 0, param3:Number = 0) {
      super();
      this._maximumDamageRadius = param1;
      this._minimumDamagePercent = param2;
      this._minimumDamageRadius = param3;
    }

    public function get maximumDamageRadius() : Number {
      return this._maximumDamageRadius;
    }

    public function set maximumDamageRadius(param1:Number) : void {
      this._maximumDamageRadius = param1;
    }

    public function get minimumDamagePercent() : Number {
      return this._minimumDamagePercent;
    }

    public function set minimumDamagePercent(param1:Number) : void {
      this._minimumDamagePercent = param1;
    }

    public function get minimumDamageRadius() : Number {
      return this._minimumDamageRadius;
    }

    public function set minimumDamageRadius(param1:Number) : void {
      this._minimumDamageRadius = param1;
    }

    public function toString() : String {
      var local1:String = "WeaponWeakeningCC [";
      local1 += "maximumDamageRadius = " + this.maximumDamageRadius + " ";
      local1 += "minimumDamagePercent = " + this.minimumDamagePercent + " ";
      local1 += "minimumDamageRadius = " + this.minimumDamageRadius + " ";
      return local1 + "]";
    }
  }
}
