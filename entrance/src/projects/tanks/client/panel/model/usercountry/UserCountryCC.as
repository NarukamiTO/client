package projects.tanks.client.panel.model.usercountry {
  public class UserCountryCC {
    private var _countries:Vector.<CountryInfo>;
    private var _defaultCountryCode:String;
    private var _locationCheckEnabled:Boolean;

    public function UserCountryCC(param1:Vector.<CountryInfo> = null, param2:String = null, param3:Boolean = false) {
      super();
      this._countries = param1;
      this._defaultCountryCode = param2;
      this._locationCheckEnabled = param3;
    }

    public function get countries() : Vector.<CountryInfo> {
      return this._countries;
    }

    public function set countries(param1:Vector.<CountryInfo>) : void {
      this._countries = param1;
    }

    public function get defaultCountryCode() : String {
      return this._defaultCountryCode;
    }

    public function set defaultCountryCode(param1:String) : void {
      this._defaultCountryCode = param1;
    }

    public function get locationCheckEnabled() : Boolean {
      return this._locationCheckEnabled;
    }

    public function set locationCheckEnabled(param1:Boolean) : void {
      this._locationCheckEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "UserCountryCC [";
      local1 += "countries = " + this.countries + " ";
      local1 += "defaultCountryCode = " + this.defaultCountryCode + " ";
      local1 += "locationCheckEnabled = " + this.locationCheckEnabled + " ";
      return local1 + "]";
    }
  }
}
