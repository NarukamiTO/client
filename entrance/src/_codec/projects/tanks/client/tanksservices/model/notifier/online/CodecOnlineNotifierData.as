package _codec.projects.tanks.client.tanksservices.model.notifier.online {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.tanksservices.model.notifier.online.OnlineNotifierData;

  public class CodecOnlineNotifierData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_online:ICodec;
    private var codec_serverNumber:ICodec;
    private var codec_timeSinceLastVisitInSec:ICodec;
    private var codec_userId:ICodec;

    public function CodecOnlineNotifierData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_online = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_serverNumber = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_timeSinceLastVisitInSec = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_userId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:OnlineNotifierData = new OnlineNotifierData();
      local2.online = this.codec_online.decode(param1) as Boolean;
      local2.serverNumber = this.codec_serverNumber.decode(param1) as int;
      local2.timeSinceLastVisitInSec = this.codec_timeSinceLastVisitInSec.decode(param1) as Long;
      local2.userId = this.codec_userId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:OnlineNotifierData = OnlineNotifierData(param2);
      this.codec_online.encode(param1,local3.online);
      this.codec_serverNumber.encode(param1,local3.serverNumber);
      this.codec_timeSinceLastVisitInSec.encode(param1,local3.timeSinceLastVisitInSec);
      this.codec_userId.encode(param1,local3.userId);
    }
  }
}
