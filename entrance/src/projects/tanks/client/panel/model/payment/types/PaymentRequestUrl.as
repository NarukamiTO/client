package projects.tanks.client.panel.model.payment.types {
  import projects.tanks.client.panel.model.payment.modes.PaymentRequestVariable;

  public class PaymentRequestUrl {
    private var _encodeParameters:Boolean;
    private var _getRequest:Boolean;
    private var _host:String;
    private var _parameters:Vector.<PaymentRequestVariable>;

    public function PaymentRequestUrl(param1:Boolean = false, param2:Boolean = false, param3:String = null, param4:Vector.<PaymentRequestVariable> = null) {
      super();
      this._encodeParameters = param1;
      this._getRequest = param2;
      this._host = param3;
      this._parameters = param4;
    }

    public function get encodeParameters() : Boolean {
      return this._encodeParameters;
    }

    public function set encodeParameters(param1:Boolean) : void {
      this._encodeParameters = param1;
    }

    public function get getRequest() : Boolean {
      return this._getRequest;
    }

    public function set getRequest(param1:Boolean) : void {
      this._getRequest = param1;
    }

    public function get host() : String {
      return this._host;
    }

    public function set host(param1:String) : void {
      this._host = param1;
    }

    public function get parameters() : Vector.<PaymentRequestVariable> {
      return this._parameters;
    }

    public function set parameters(param1:Vector.<PaymentRequestVariable>) : void {
      this._parameters = param1;
    }

    public function toString() : String {
      var local1:String = "PaymentRequestUrl [";
      local1 += "encodeParameters = " + this.encodeParameters + " ";
      local1 += "getRequest = " + this.getRequest + " ";
      local1 += "host = " + this.host + " ";
      local1 += "parameters = " + this.parameters + " ";
      return local1 + "]";
    }
  }
}
