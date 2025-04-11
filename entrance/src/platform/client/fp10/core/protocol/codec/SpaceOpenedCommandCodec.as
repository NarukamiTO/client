package platform.client.fp10.core.protocol.codec {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import platform.client.fp10.core.network.command.SpaceOpenedCommand;

  public class SpaceOpenedCommandCodec implements ICodec {
    public function SpaceOpenedCommandCodec() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      var local3:SpaceOpenedCommand = SpaceOpenedCommand(param2);
      param1.writer.writeByte(3);
      param1.writer.writeBytes(local3.hash);
      param1.writer.writeInt(local3.spaceId.high);
      param1.writer.writeInt(local3.spaceId.low);
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return null;
    }
  }
}
