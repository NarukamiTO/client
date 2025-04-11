package platform.client.fp10.core.protocol.codec {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.network.command.SpaceOpenedCommand;

  public class SpaceRootCodec implements ICodec {
    private var spaceOpenedCommandCodec:ICodec;
    private var longCodec:ICodec;

    public function SpaceRootCodec() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.spaceOpenedCommandCodec = param1.getCodec(new TypeCodecInfo(SpaceOpenedCommand,false));
      this.longCodec = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      var local3:SpaceCommand = null;
      var local4:ByteArray = null;
      var local5:int = 0;
      var local6:int = 0;
      if(param2 is SpaceOpenedCommand) {
        this.spaceOpenedCommandCodec.encode(param1,param2);
      } else {
        if(!(param2 is SpaceCommand)) {
          throw new Error("Unknown space command");
        }
        local3 = SpaceCommand(param2);
        this.longCodec.encode(param1,local3.objectId);
        this.longCodec.encode(param1,local3.methodId);
        local4 = ByteArray(local3.protocolBuffer.reader);
        local4.position = 0;
        while(Boolean(local4.bytesAvailable)) {
          local6 = local4.readByte();
          param1.writer.writeByte(local6);
        }
        local3.protocolBuffer.optionalMap.reset();
        local5 = 0;
        while(local5 < local3.protocolBuffer.optionalMap.getSize()) {
          param1.optionalMap.addBit(local3.protocolBuffer.optionalMap.get());
          local5++;
        }
      }
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return param1;
    }
  }
}
