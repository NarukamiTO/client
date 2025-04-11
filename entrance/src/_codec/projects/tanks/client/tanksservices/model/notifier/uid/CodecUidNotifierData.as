package _codec.projects.tanks.client.tanksservices.model.notifier.uid {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.tanksservices.model.notifier.uid.UidNotifierData;

  public class CodecUidNotifierData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_uid:ICodec;
    private var codec_userId:ICodec;

    public function CodecUidNotifierData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_uid = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_userId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UidNotifierData = new UidNotifierData();
      local2.uid = this.codec_uid.decode(param1) as String;
      local2.userId = this.codec_userId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UidNotifierData = UidNotifierData(param2);
      this.codec_uid.encode(param1,local3.uid);
      this.codec_userId.encode(param1,local3.userId);
    }
  }
}
