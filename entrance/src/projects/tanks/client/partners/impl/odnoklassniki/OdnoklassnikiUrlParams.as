package projects.tanks.client.partners.impl.odnoklassniki {
  public class OdnoklassnikiUrlParams {
    public static const API_SERVER:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(0,"API_SERVER");
    public static const APICONNECTION:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(1,"APICONNECTION");
    public static const APPLICATION_KEY:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(2,"APPLICATION_KEY");
    public static const AUTH_SIG:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(3,"AUTH_SIG");
    public static const AUTHORIZED:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(4,"AUTHORIZED");
    public static const CONTAINER:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(5,"CONTAINER");
    public static const CUSTOM_ARGS:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(6,"CUSTOM_ARGS");
    public static const FIRST_START:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(7,"FIRST_START");
    public static const HEADER_WIDGET:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(8,"HEADER_WIDGET");
    public static const LOGGED_USER_ID:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(9,"LOGGED_USER_ID");
    public static const REFERER:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(10,"REFERER");
    public static const REFPLACE:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(11,"REFPLACE");
    public static const SESSION_KEY:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(12,"SESSION_KEY");
    public static const SESSION_SECRET_KEY:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(13,"SESSION_SECRET_KEY");
    public static const SIG:OdnoklassnikiUrlParams = new OdnoklassnikiUrlParams(14,"SIG");

    private var _value:int;
    private var _name:String;

    public function OdnoklassnikiUrlParams(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<OdnoklassnikiUrlParams> {
      var local1:Vector.<OdnoklassnikiUrlParams> = new Vector.<OdnoklassnikiUrlParams>();
      local1.push(API_SERVER);
      local1.push(APICONNECTION);
      local1.push(APPLICATION_KEY);
      local1.push(AUTH_SIG);
      local1.push(AUTHORIZED);
      local1.push(CONTAINER);
      local1.push(CUSTOM_ARGS);
      local1.push(FIRST_START);
      local1.push(HEADER_WIDGET);
      local1.push(LOGGED_USER_ID);
      local1.push(REFERER);
      local1.push(REFPLACE);
      local1.push(SESSION_KEY);
      local1.push(SESSION_SECRET_KEY);
      local1.push(SIG);
      return local1;
    }

    public function toString() : String {
      return "OdnoklassnikiUrlParams [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
