package projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.aiming {
  public class ShotGunAimingCC {
    private var _coneHorizontalAngle:Number;
    private var _coneVerticalAngle:Number;
    private var _pelletCount:int;

    public function ShotGunAimingCC(param1:Number = 0, param2:Number = 0, param3:int = 0) {
      super();
      this._coneHorizontalAngle = param1;
      this._coneVerticalAngle = param2;
      this._pelletCount = param3;
    }

    public function get coneHorizontalAngle() : Number {
      return this._coneHorizontalAngle;
    }

    public function set coneHorizontalAngle(param1:Number) : void {
      this._coneHorizontalAngle = param1;
    }

    public function get coneVerticalAngle() : Number {
      return this._coneVerticalAngle;
    }

    public function set coneVerticalAngle(param1:Number) : void {
      this._coneVerticalAngle = param1;
    }

    public function get pelletCount() : int {
      return this._pelletCount;
    }

    public function set pelletCount(param1:int) : void {
      this._pelletCount = param1;
    }

    public function toString() : String {
      var local1:String = "ShotGunAimingCC [";
      local1 += "coneHorizontalAngle = " + this.coneHorizontalAngle + " ";
      local1 += "coneVerticalAngle = " + this.coneVerticalAngle + " ";
      local1 += "pelletCount = " + this.pelletCount + " ";
      return local1 + "]";
    }
  }
}
