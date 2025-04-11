package _codec.projects.tanks.client.panel.model.payment.modes.sms.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.sms.types.SMSOperator;

  public class CodecSMSOperator implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_id:ICodec;
    private var codec_name:ICodec;

    public function CodecSMSOperator() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_id = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SMSOperator = new SMSOperator();
      local2.id = this.codec_id.decode(param1) as int;
      local2.name = this.codec_name.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SMSOperator = SMSOperator(param2);
      this.codec_id.encode(param1,local3.id);
      this.codec_name.encode(param1,local3.name);
    }
  }
}
