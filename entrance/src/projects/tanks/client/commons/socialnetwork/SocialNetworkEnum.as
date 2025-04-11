package projects.tanks.client.commons.socialnetwork {
  public class SocialNetworkEnum {
    public static const VKONTAKTE_INTERNAL:SocialNetworkEnum = new SocialNetworkEnum(0,"VKONTAKTE_INTERNAL");
    public static const ODNOKLASSNIKI_INTERNAL:SocialNetworkEnum = new SocialNetworkEnum(1,"ODNOKLASSNIKI_INTERNAL");
    public static const MAIN:SocialNetworkEnum = new SocialNetworkEnum(2,"MAIN");

    private var _value:int;
    private var _name:String;

    public function SocialNetworkEnum(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<SocialNetworkEnum> {
      var local1:Vector.<SocialNetworkEnum> = new Vector.<SocialNetworkEnum>();
      local1.push(VKONTAKTE_INTERNAL);
      local1.push(ODNOKLASSNIKI_INTERNAL);
      local1.push(MAIN);
      return local1;
    }

    public function toString() : String {
      return "SocialNetworkEnum [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
