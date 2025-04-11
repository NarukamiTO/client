package _codec.projects.tanks.client.tanksservices.model.uidcheck {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.uidcheck.UidCheckCC;

  public class CodecUidCheckCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_length:ICodec;

    public function CodecUidCheckCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_length = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UidCheckCC = new UidCheckCC();
      local2.length = this.codec_length.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UidCheckCC = UidCheckCC(param2);
      this.codec_length.encode(param1,local3.length);
    }
  }
}
