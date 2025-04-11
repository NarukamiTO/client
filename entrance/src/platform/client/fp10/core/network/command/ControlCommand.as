package platform.client.fp10.core.network.command {
  public class ControlCommand {
    public static const SV_HASH_RESPONSE:int = 2;
    public static const SV_OPEN_SPACE:int = 32;
    public static const SV_MESSAGE:int = 35;
    public static const SV_COMMAND_REQUEST:int = 9;
    public static const CL_HASH_REQUEST:int = 1;
    public static const CL_LOG:int = 32;
    public static const CL_COMMAND_RESPONSE:int = 10;

    public var id:int;
    public var name:String;

    public function ControlCommand(param1:int, param2:String) {
      super();
      this.id = param1;
      this.name = param2;
    }

    public function toString() : String {
      return "[ControlCommand id=" + this.id + ", name=" + this.name + "]";
    }
  }
}
