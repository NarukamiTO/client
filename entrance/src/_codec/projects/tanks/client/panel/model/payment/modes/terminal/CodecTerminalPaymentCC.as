package _codec.projects.tanks.client.panel.model.payment.modes.terminal {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.terminal.TerminalInstance;
  import projects.tanks.client.panel.model.payment.modes.terminal.TerminalPaymentCC;

  public class CodecTerminalPaymentCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_terminals:ICodec;
    private var codec_text:ICodec;
    private var codec_withCalculator:ICodec;

    public function CodecTerminalPaymentCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_terminals = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(TerminalInstance,false),false,1));
      this.codec_text = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_withCalculator = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TerminalPaymentCC = new TerminalPaymentCC();
      local2.terminals = this.codec_terminals.decode(param1) as Vector.<TerminalInstance>;
      local2.text = this.codec_text.decode(param1) as String;
      local2.withCalculator = this.codec_withCalculator.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TerminalPaymentCC = TerminalPaymentCC(param2);
      this.codec_terminals.encode(param1,local3.terminals);
      this.codec_text.encode(param1,local3.text);
      this.codec_withCalculator.encode(param1,local3.withCalculator);
    }
  }
}
