package _codec.projects.tanks.client.panel.model.shop.specialkit {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.specialkit.ShopKitText;

  public class CodecShopKitText implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_color:ICodec;
    private var codec_size:ICodec;
    private var codec_text:ICodec;
    private var codec_x:ICodec;
    private var codec_y:ICodec;

    public function CodecShopKitText() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_color = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_size = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_text = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_x = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_y = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopKitText = new ShopKitText();
      local2.color = this.codec_color.decode(param1) as int;
      local2.size = this.codec_size.decode(param1) as int;
      local2.text = this.codec_text.decode(param1) as String;
      local2.x = this.codec_x.decode(param1) as int;
      local2.y = this.codec_y.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopKitText = ShopKitText(param2);
      this.codec_color.encode(param1,local3.color);
      this.codec_size.encode(param1,local3.size);
      this.codec_text.encode(param1,local3.text);
      this.codec_x.encode(param1,local3.x);
      this.codec_y.encode(param1,local3.y);
    }
  }
}
