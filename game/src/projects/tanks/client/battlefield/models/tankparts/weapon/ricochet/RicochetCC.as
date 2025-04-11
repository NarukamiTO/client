package projects.tanks.client.battlefield.models.tankparts.weapon.ricochet {
  public class RicochetCC {
    private var _energyCapacity:Number;
    private var _energyPerShot:Number;
    private var _energyRechargeSpeed:Number;
    private var _maxRicochetCount:int;
    private var _shellRadius:Number;
    private var _shellSpeed:Number;
    private var _shotDistance:Number;

    public function RicochetCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:int = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0) {
      super();
      this._energyCapacity = param1;
      this._energyPerShot = param2;
      this._energyRechargeSpeed = param3;
      this._maxRicochetCount = param4;
      this._shellRadius = param5;
      this._shellSpeed = param6;
      this._shotDistance = param7;
    }

    public function get energyCapacity() : Number {
      return this._energyCapacity;
    }

    public function set energyCapacity(param1:Number) : void {
      this._energyCapacity = param1;
    }

    public function get energyPerShot() : Number {
      return this._energyPerShot;
    }

    public function set energyPerShot(param1:Number) : void {
      this._energyPerShot = param1;
    }

    public function get energyRechargeSpeed() : Number {
      return this._energyRechargeSpeed;
    }

    public function set energyRechargeSpeed(param1:Number) : void {
      this._energyRechargeSpeed = param1;
    }

    public function get maxRicochetCount() : int {
      return this._maxRicochetCount;
    }

    public function set maxRicochetCount(param1:int) : void {
      this._maxRicochetCount = param1;
    }

    public function get shellRadius() : Number {
      return this._shellRadius;
    }

    public function set shellRadius(param1:Number) : void {
      this._shellRadius = param1;
    }

    public function get shellSpeed() : Number {
      return this._shellSpeed;
    }

    public function set shellSpeed(param1:Number) : void {
      this._shellSpeed = param1;
    }

    public function get shotDistance() : Number {
      return this._shotDistance;
    }

    public function set shotDistance(param1:Number) : void {
      this._shotDistance = param1;
    }

    public function toString() : String {
      var local1:String = "RicochetCC [";
      local1 += "energyCapacity = " + this.energyCapacity + " ";
      local1 += "energyPerShot = " + this.energyPerShot + " ";
      local1 += "energyRechargeSpeed = " + this.energyRechargeSpeed + " ";
      local1 += "maxRicochetCount = " + this.maxRicochetCount + " ";
      local1 += "shellRadius = " + this.shellRadius + " ";
      local1 += "shellSpeed = " + this.shellSpeed + " ";
      local1 += "shotDistance = " + this.shotDistance + " ";
      return local1 + "]";
    }
  }
}
