package projects.tanks.client.entrance.model.entrance.logging {
  public class RegistrationUXScreen {
    public static const MAIN:RegistrationUXScreen = new RegistrationUXScreen(0,"MAIN");
    public static const VK:RegistrationUXScreen = new RegistrationUXScreen(1,"VK");
    public static const FACEBOOK:RegistrationUXScreen = new RegistrationUXScreen(2,"FACEBOOK");
    public static const GOOGLE:RegistrationUXScreen = new RegistrationUXScreen(3,"GOOGLE");
    public static const PARTNER:RegistrationUXScreen = new RegistrationUXScreen(4,"PARTNER");
    public static const LOGIN:RegistrationUXScreen = new RegistrationUXScreen(5,"LOGIN");
    public static const SITE:RegistrationUXScreen = new RegistrationUXScreen(6,"SITE");
    public static const TUTORIAL:RegistrationUXScreen = new RegistrationUXScreen(7,"TUTORIAL");
    public static const STANDALONE:RegistrationUXScreen = new RegistrationUXScreen(8,"STANDALONE");

    private var _value:int;
    private var _name:String;

    public function RegistrationUXScreen(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<RegistrationUXScreen> {
      var local1:Vector.<RegistrationUXScreen> = new Vector.<RegistrationUXScreen>();
      local1.push(MAIN);
      local1.push(VK);
      local1.push(FACEBOOK);
      local1.push(GOOGLE);
      local1.push(PARTNER);
      local1.push(LOGIN);
      local1.push(SITE);
      local1.push(TUTORIAL);
      local1.push(STANDALONE);
      return local1;
    }

    public function toString() : String {
      return "RegistrationUXScreen [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
