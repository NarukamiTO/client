package projects.tanks.client.entrance.model.users.pushnotification {
  public class NotificationClientPlatform {
    public static const ANDROID:NotificationClientPlatform = new NotificationClientPlatform(0,"ANDROID");
    public static const WEB:NotificationClientPlatform = new NotificationClientPlatform(1,"WEB");

    private var _value:int;
    private var _name:String;

    public function NotificationClientPlatform(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<NotificationClientPlatform> {
      var local1:Vector.<NotificationClientPlatform> = new Vector.<NotificationClientPlatform>();
      local1.push(ANDROID);
      local1.push(WEB);
      return local1;
    }

    public function toString() : String {
      return "NotificationClientPlatform [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
