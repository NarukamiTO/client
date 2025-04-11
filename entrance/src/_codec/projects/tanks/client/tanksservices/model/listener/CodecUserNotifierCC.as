package _codec.projects.tanks.client.tanksservices.model.listener {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.tanksservices.model.listener.UserNotifierCC;

  public class CodecUserNotifierCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_currentUserId:ICodec;

    public function CodecUserNotifierCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_currentUserId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserNotifierCC = new UserNotifierCC();
      local2.currentUserId = this.codec_currentUserId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserNotifierCC = UserNotifierCC(param2);
      this.codec_currentUserId.encode(param1,local3.currentUserId);
    }
  }
}
