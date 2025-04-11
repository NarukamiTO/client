package _codec.projects.tanks.client.panel.model.shop.clientlayoutkit {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.clientlayoutkit.CCBundleText;

  public class CodecCCBundleText implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_color:ICodec;
    private var codec_fontPercentSize:ICodec;
    private var codec_positionPercentX:ICodec;
    private var codec_positionPercentY:ICodec;
    private var codec_text:ICodec;

    public function CodecCCBundleText() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_color = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_fontPercentSize = param1.getCodec(new TypeCodecInfo(int,true));
      this.codec_positionPercentX = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_positionPercentY = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_text = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CCBundleText = new CCBundleText();
      local2.color = this.codec_color.decode(param1) as int;
      local2.fontPercentSize = this.codec_fontPercentSize.decode(param1) as int;
      local2.positionPercentX = this.codec_positionPercentX.decode(param1) as int;
      local2.positionPercentY = this.codec_positionPercentY.decode(param1) as int;
      local2.text = this.codec_text.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CCBundleText = CCBundleText(param2);
      this.codec_color.encode(param1,local3.color);
      this.codec_fontPercentSize.encode(param1,local3.fontPercentSize);
      this.codec_positionPercentX.encode(param1,local3.positionPercentX);
      this.codec_positionPercentY.encode(param1,local3.positionPercentY);
      this.codec_text.encode(param1,local3.text);
    }
  }
}
