package _codec.projects.tanks.client.tanksservices.model.reconnect {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.reconnect.ReconnectCC;

  public class CodecReconnectCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_configUrlTemplate:ICodec;
    private var codec_serverNumber:ICodec;

    public function CodecReconnectCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_configUrlTemplate = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_serverNumber = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ReconnectCC = new ReconnectCC();
      local2.configUrlTemplate = this.codec_configUrlTemplate.decode(param1) as String;
      local2.serverNumber = this.codec_serverNumber.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ReconnectCC = ReconnectCC(param2);
      this.codec_configUrlTemplate.encode(param1,local3.configUrlTemplate);
      this.codec_serverNumber.encode(param1,local3.serverNumber);
    }
  }
}
