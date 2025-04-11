package _codec.projects.tanks.client.panel.model.rulesupdate.showing {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.rulesupdate.showing.RulesUpdateShowingCC;

  public class CodecRulesUpdateShowingCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bottomText:ICodec;
    private var codec_showAcceptRulesAlert:ICodec;
    private var codec_topText:ICodec;

    public function CodecRulesUpdateShowingCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bottomText = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_showAcceptRulesAlert = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_topText = param1.getCodec(new TypeCodecInfo(String,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RulesUpdateShowingCC = new RulesUpdateShowingCC();
      local2.bottomText = this.codec_bottomText.decode(param1) as String;
      local2.showAcceptRulesAlert = this.codec_showAcceptRulesAlert.decode(param1) as Boolean;
      local2.topText = this.codec_topText.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RulesUpdateShowingCC = RulesUpdateShowingCC(param2);
      this.codec_bottomText.encode(param1,local3.bottomText);
      this.codec_showAcceptRulesAlert.encode(param1,local3.showAcceptRulesAlert);
      this.codec_topText.encode(param1,local3.topText);
    }
  }
}
