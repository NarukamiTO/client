package projects.tanks.client.panel.model.payment.modes.pricerange {
  public class PriceRangeCC {
    private var _enabled:Boolean;
    private var _minimum:Number;

    public function PriceRangeCC(param1:Boolean = false, param2:Number = 0) {
      super();
      this._enabled = param1;
      this._minimum = param2;
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
    }

    public function get minimum() : Number {
      return this._minimum;
    }

    public function set minimum(param1:Number) : void {
      this._minimum = param1;
    }

    public function toString() : String {
      var local1:String = "PriceRangeCC [";
      local1 += "enabled = " + this.enabled + " ";
      local1 += "minimum = " + this.minimum + " ";
      return local1 + "]";
    }
  }
}
