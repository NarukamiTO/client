package projects.tanks.client.battlefield.models.tankparts.weapons.artillery {
  public class ArtilleryCC {
    private var _chargingTime:Number;
    private var _initialTurretAngle:Number;
    private var _maxShellSpeed:Number;
    private var _minShellSpeed:Number;
    private var _shellGravityCoef:Number;
    private var _shellRadius:Number;
    private var _speedsCount:int;

    public function ArtilleryCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:int = 0) {
      super();
      this._chargingTime = param1;
      this._initialTurretAngle = param2;
      this._maxShellSpeed = param3;
      this._minShellSpeed = param4;
      this._shellGravityCoef = param5;
      this._shellRadius = param6;
      this._speedsCount = param7;
    }

    public function get chargingTime() : Number {
      return this._chargingTime;
    }

    public function set chargingTime(param1:Number) : void {
      this._chargingTime = param1;
    }

    public function get initialTurretAngle() : Number {
      return this._initialTurretAngle;
    }

    public function set initialTurretAngle(param1:Number) : void {
      this._initialTurretAngle = param1;
    }

    public function get maxShellSpeed() : Number {
      return this._maxShellSpeed;
    }

    public function set maxShellSpeed(param1:Number) : void {
      this._maxShellSpeed = param1;
    }

    public function get minShellSpeed() : Number {
      return this._minShellSpeed;
    }

    public function set minShellSpeed(param1:Number) : void {
      this._minShellSpeed = param1;
    }

    public function get shellGravityCoef() : Number {
      return this._shellGravityCoef;
    }

    public function set shellGravityCoef(param1:Number) : void {
      this._shellGravityCoef = param1;
    }

    public function get shellRadius() : Number {
      return this._shellRadius;
    }

    public function set shellRadius(param1:Number) : void {
      this._shellRadius = param1;
    }

    public function get speedsCount() : int {
      return this._speedsCount;
    }

    public function set speedsCount(param1:int) : void {
      this._speedsCount = param1;
    }

    public function toString() : String {
      var local1:String = "ArtilleryCC [";
      local1 += "chargingTime = " + this.chargingTime + " ";
      local1 += "initialTurretAngle = " + this.initialTurretAngle + " ";
      local1 += "maxShellSpeed = " + this.maxShellSpeed + " ";
      local1 += "minShellSpeed = " + this.minShellSpeed + " ";
      local1 += "shellGravityCoef = " + this.shellGravityCoef + " ";
      local1 += "shellRadius = " + this.shellRadius + " ";
      local1 += "speedsCount = " + this.speedsCount + " ";
      return local1 + "]";
    }
  }
}
