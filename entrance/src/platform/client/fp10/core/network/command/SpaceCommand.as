package platform.client.fp10.core.network.command {
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import flash.utils.ByteArray;

  public class SpaceCommand {
    public static const PRODUCE_HASH:int = 3;
    public static const SPACE_CONNECTED:int = 4;

    public var objectId:Long;
    public var methodId:Long;
    public var protocolBuffer:ProtocolBuffer;

    public function SpaceCommand(param1:Long, param2:Long, param3:ProtocolBuffer) {
      super();
      this.objectId = param1;
      this.methodId = param2;
      this.protocolBuffer = param3;
    }

    public function toString() : String {
      return "[objectId=" + this.objectId + ", methodId=" + this.methodId + ", protocolBuffer length=" + ByteArray(this.protocolBuffer.reader).length + ", protocolBuffer=" + this.protocolBuffer.reader + "]";
    }
  }
}
