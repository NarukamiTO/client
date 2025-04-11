package projects.tanks.client.chat.types {
  public class MessageType {
    public static const USER:MessageType = new MessageType(0,"USER");
    public static const SYSTEM:MessageType = new MessageType(1,"SYSTEM");
    public static const WARNING:MessageType = new MessageType(2,"WARNING");

    private var _value:int;
    private var _name:String;

    public function MessageType(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<MessageType> {
      var local1:Vector.<MessageType> = new Vector.<MessageType>();
      local1.push(USER);
      local1.push(SYSTEM);
      local1.push(WARNING);
      return local1;
    }

    public function toString() : String {
      return "MessageType [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
