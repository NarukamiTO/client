package projects.tanks.client.panel.model.usercountry {
  public class CountryInfo {
    private var _countryCode:String;
    private var _countryName:String;

    public function CountryInfo(param1:String = null, param2:String = null) {
      super();
      this._countryCode = param1;
      this._countryName = param2;
    }

    public function get countryCode() : String {
      return this._countryCode;
    }

    public function set countryCode(param1:String) : void {
      this._countryCode = param1;
    }

    public function get countryName() : String {
      return this._countryName;
    }

    public function set countryName(param1:String) : void {
      this._countryName = param1;
    }

    public function toString() : String {
      var local1:String = "CountryInfo [";
      local1 += "countryCode = " + this.countryCode + " ";
      local1 += "countryName = " + this.countryName + " ";
      return local1 + "]";
    }
  }
}
