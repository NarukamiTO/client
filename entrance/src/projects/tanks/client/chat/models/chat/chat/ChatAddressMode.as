package projects.tanks.client.chat.models.chat.chat {
  public class ChatAddressMode {
    public static const PUBLIC_TO_ALL:ChatAddressMode = new ChatAddressMode(0,"PUBLIC_TO_ALL");
    public static const PUBLIC_ADDRESSED:ChatAddressMode = new ChatAddressMode(1,"PUBLIC_ADDRESSED");
    public static const PRIVATE:ChatAddressMode = new ChatAddressMode(2,"PRIVATE");

    private var _value:int;
    private var _name:String;

    public function ChatAddressMode(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ChatAddressMode> {
      var local1:Vector.<ChatAddressMode> = new Vector.<ChatAddressMode>();
      local1.push(PUBLIC_TO_ALL);
      local1.push(PUBLIC_ADDRESSED);
      local1.push(PRIVATE);
      return local1;
    }

    public function toString() : String {
      return "ChatAddressMode [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
