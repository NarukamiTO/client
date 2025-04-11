package projects.tanks.client.battlefield.models.tankparts.weapon.railgun {
  public class RailgunCC {
    private var _chargingTimeMsec:int;
    private var _weakeningCoeff:Number;

    public function RailgunCC(param1:int = 0, param2:Number = 0) {
      super();
      this._chargingTimeMsec = param1;
      this._weakeningCoeff = param2;
    }

    public function get chargingTimeMsec() : int {
      return this._chargingTimeMsec;
    }

    public function set chargingTimeMsec(param1:int) : void {
      this._chargingTimeMsec = param1;
    }

    public function get weakeningCoeff() : Number {
      return this._weakeningCoeff;
    }

    public function set weakeningCoeff(param1:Number) : void {
      this._weakeningCoeff = param1;
    }

    public function toString() : String {
      var local1:String = "RailgunCC [";
      local1 += "chargingTimeMsec = " + this.chargingTimeMsec + " ";
      local1 += "weakeningCoeff = " + this.weakeningCoeff + " ";
      return local1 + "]";
    }
  }
}
