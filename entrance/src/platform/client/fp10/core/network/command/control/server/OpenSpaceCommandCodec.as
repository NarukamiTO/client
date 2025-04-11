package platform.client.fp10.core.network.command.control.server {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;

  public class OpenSpaceCommandCodec implements ICodec {
    private var idCodec:ICodec;

    public function OpenSpaceCommandCodec(param1:IProtocol) {
      super();
      this.init(param1);
    }

    public function init(param1:IProtocol) : void {
      this.idCodec = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:Long = Long(this.idCodec.decode(param1));
      return new OpenSpaceCommand(local2);
    }
  }
}
