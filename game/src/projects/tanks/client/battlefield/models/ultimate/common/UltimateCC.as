package projects.tanks.client.battlefield.models.ultimate.common {
  public class UltimateCC {
    private var _chargePercentPerSecond:Number;
    private var _charged:Boolean;
    private var _enabled:Boolean;

    public function UltimateCC(param1:Number = 0, param2:Boolean = false, param3:Boolean = false) {
      super();
      this._chargePercentPerSecond = param1;
      this._charged = param2;
      this._enabled = param3;
    }

    public function get chargePercentPerSecond() : Number {
      return this._chargePercentPerSecond;
    }

    public function set chargePercentPerSecond(param1:Number) : void {
      this._chargePercentPerSecond = param1;
    }

    public function get charged() : Boolean {
      return this._charged;
    }

    public function set charged(param1:Boolean) : void {
      this._charged = param1;
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
    }

    public function toString() : String {
      var local1:String = "UltimateCC [";
      local1 += "chargePercentPerSecond = " + this.chargePercentPerSecond + " ";
      local1 += "charged = " + this.charged + " ";
      local1 += "enabled = " + this.enabled + " ";
      return local1 + "]";
    }
  }
}
