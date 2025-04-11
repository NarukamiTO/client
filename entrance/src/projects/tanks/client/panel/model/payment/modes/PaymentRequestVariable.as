package projects.tanks.client.panel.model.payment.modes {
  public class PaymentRequestVariable {
    private var _value:String;
    private var _variable:String;

    public function PaymentRequestVariable(param1:String = null, param2:String = null) {
      super();
      this._value = param1;
      this._variable = param2;
    }

    public function get value() : String {
      return this._value;
    }

    public function set value(param1:String) : void {
      this._value = param1;
    }

    public function get variable() : String {
      return this._variable;
    }

    public function set variable(param1:String) : void {
      this._variable = param1;
    }

    public function toString() : String {
      var local1:String = "PaymentRequestVariable [";
      local1 += "value = " + this.value + " ";
      local1 += "variable = " + this.variable + " ";
      return local1 + "]";
    }
  }
}
