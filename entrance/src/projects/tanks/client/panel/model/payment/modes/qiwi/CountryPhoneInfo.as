package projects.tanks.client.panel.model.payment.modes.qiwi {
  public class CountryPhoneInfo {
    private var _code:int;
    private var _name:String;
    private var _phoneLength:int;

    public function CountryPhoneInfo(param1:int = 0, param2:String = null, param3:int = 0) {
      super();
      this._code = param1;
      this._name = param2;
      this._phoneLength = param3;
    }

    public function get code() : int {
      return this._code;
    }

    public function set code(param1:int) : void {
      this._code = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get phoneLength() : int {
      return this._phoneLength;
    }

    public function set phoneLength(param1:int) : void {
      this._phoneLength = param1;
    }

    public function toString() : String {
      var local1:String = "CountryPhoneInfo [";
      local1 += "code = " + this.code + " ";
      local1 += "name = " + this.name + " ";
      local1 += "phoneLength = " + this.phoneLength + " ";
      return local1 + "]";
    }
  }
}
