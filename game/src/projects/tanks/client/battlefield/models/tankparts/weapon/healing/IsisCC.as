package projects.tanks.client.battlefield.models.tankparts.weapon.healing {
  public class IsisCC {
    private var _capacity:Number;
    private var _chargeRate:Number;
    private var _checkPeriodMsec:int;
    private var _coneAngle:Number;
    private var _dischargeDamageRate:Number;
    private var _dischargeHealingRate:Number;
    private var _dischargeIdleRate:Number;
    private var _radius:Number;

    public function IsisCC(param1:Number = 0, param2:Number = 0, param3:int = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0) {
      super();
      this._capacity = param1;
      this._chargeRate = param2;
      this._checkPeriodMsec = param3;
      this._coneAngle = param4;
      this._dischargeDamageRate = param5;
      this._dischargeHealingRate = param6;
      this._dischargeIdleRate = param7;
      this._radius = param8;
    }

    public function get capacity() : Number {
      return this._capacity;
    }

    public function set capacity(param1:Number) : void {
      this._capacity = param1;
    }

    public function get chargeRate() : Number {
      return this._chargeRate;
    }

    public function set chargeRate(param1:Number) : void {
      this._chargeRate = param1;
    }

    public function get checkPeriodMsec() : int {
      return this._checkPeriodMsec;
    }

    public function set checkPeriodMsec(param1:int) : void {
      this._checkPeriodMsec = param1;
    }

    public function get coneAngle() : Number {
      return this._coneAngle;
    }

    public function set coneAngle(param1:Number) : void {
      this._coneAngle = param1;
    }

    public function get dischargeDamageRate() : Number {
      return this._dischargeDamageRate;
    }

    public function set dischargeDamageRate(param1:Number) : void {
      this._dischargeDamageRate = param1;
    }

    public function get dischargeHealingRate() : Number {
      return this._dischargeHealingRate;
    }

    public function set dischargeHealingRate(param1:Number) : void {
      this._dischargeHealingRate = param1;
    }

    public function get dischargeIdleRate() : Number {
      return this._dischargeIdleRate;
    }

    public function set dischargeIdleRate(param1:Number) : void {
      this._dischargeIdleRate = param1;
    }

    public function get radius() : Number {
      return this._radius;
    }

    public function set radius(param1:Number) : void {
      this._radius = param1;
    }

    public function toString() : String {
      var local1:String = "IsisCC [";
      local1 += "capacity = " + this.capacity + " ";
      local1 += "chargeRate = " + this.chargeRate + " ";
      local1 += "checkPeriodMsec = " + this.checkPeriodMsec + " ";
      local1 += "coneAngle = " + this.coneAngle + " ";
      local1 += "dischargeDamageRate = " + this.dischargeDamageRate + " ";
      local1 += "dischargeHealingRate = " + this.dischargeHealingRate + " ";
      local1 += "dischargeIdleRate = " + this.dischargeIdleRate + " ";
      local1 += "radius = " + this.radius + " ";
      return local1 + "]";
    }
  }
}
