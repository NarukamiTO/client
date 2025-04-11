package _codec.projects.tanks.client.panel.model.payment.modes.sms.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.sms.types.SMSNumber;

  public class CodecSMSNumber implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_cost:ICodec;
    private var codec_crystals:ICodec;
    private var codec_currency:ICodec;
    private var codec_number:ICodec;
    private var codec_smsText:ICodec;

    public function CodecSMSNumber() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_cost = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_crystals = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_currency = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_number = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_smsText = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SMSNumber = new SMSNumber();
      local2.cost = this.codec_cost.decode(param1) as Number;
      local2.crystals = this.codec_crystals.decode(param1) as int;
      local2.currency = this.codec_currency.decode(param1) as String;
      local2.number = this.codec_number.decode(param1) as String;
      local2.smsText = this.codec_smsText.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SMSNumber = SMSNumber(param2);
      this.codec_cost.encode(param1,local3.cost);
      this.codec_crystals.encode(param1,local3.crystals);
      this.codec_currency.encode(param1,local3.currency);
      this.codec_number.encode(param1,local3.number);
      this.codec_smsText.encode(param1,local3.smsText);
    }
  }
}
