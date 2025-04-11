package _codec.projects.tanks.client.tanksservices.model.logging {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.logging.UserActionsLoggerCC;

  public class CodecUserActionsLoggerCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_loggingEnabled:ICodec;

    public function CodecUserActionsLoggerCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_loggingEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserActionsLoggerCC = new UserActionsLoggerCC();
      local2.loggingEnabled = this.codec_loggingEnabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserActionsLoggerCC = UserActionsLoggerCC(param2);
      this.codec_loggingEnabled.encode(param1,local3.loggingEnabled);
    }
  }
}
