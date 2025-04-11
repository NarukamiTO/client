package _codec.projects.tanks.client.entrance.model.entrance.entrance {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.entrance.model.entrance.entrance.EntranceModelCC;

  public class CodecEntranceModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_antiAddictionEnabled:ICodec;

    public function CodecEntranceModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_antiAddictionEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:EntranceModelCC = new EntranceModelCC();
      local2.antiAddictionEnabled = this.codec_antiAddictionEnabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:EntranceModelCC = EntranceModelCC(param2);
      this.codec_antiAddictionEnabled.encode(param1,local3.antiAddictionEnabled);
    }
  }
}
