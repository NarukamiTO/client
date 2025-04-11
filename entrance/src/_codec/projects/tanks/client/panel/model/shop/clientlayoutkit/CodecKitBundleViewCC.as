package _codec.projects.tanks.client.panel.model.shop.clientlayoutkit {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.shop.clientlayoutkit.CCBundleText;
  import projects.tanks.client.panel.model.shop.clientlayoutkit.KitBundleViewCC;
  import projects.tanks.client.panel.model.shop.clientlayoutkit.entity.BundleImage;

  public class CodecKitBundleViewCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_button:ICodec;
    private var codec_buttonOver:ICodec;
    private var codec_imageBlocks:ICodec;
    private var codec_priceLabelColor:ICodec;
    private var codec_priceLabelFontPercentSize:ICodec;
    private var codec_priceLabelPositionPercentX:ICodec;
    private var codec_priceLabelPositionPercentY:ICodec;
    private var codec_textBlocks:ICodec;

    public function CodecKitBundleViewCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_button = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_buttonOver = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_imageBlocks = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BundleImage,false),false,1));
      this.codec_priceLabelColor = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_priceLabelFontPercentSize = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_priceLabelPositionPercentX = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_priceLabelPositionPercentY = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_textBlocks = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(CCBundleText,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:KitBundleViewCC = new KitBundleViewCC();
      local2.button = this.codec_button.decode(param1) as ImageResource;
      local2.buttonOver = this.codec_buttonOver.decode(param1) as ImageResource;
      local2.imageBlocks = this.codec_imageBlocks.decode(param1) as Vector.<BundleImage>;
      local2.priceLabelColor = this.codec_priceLabelColor.decode(param1) as int;
      local2.priceLabelFontPercentSize = this.codec_priceLabelFontPercentSize.decode(param1) as int;
      local2.priceLabelPositionPercentX = this.codec_priceLabelPositionPercentX.decode(param1) as int;
      local2.priceLabelPositionPercentY = this.codec_priceLabelPositionPercentY.decode(param1) as int;
      local2.textBlocks = this.codec_textBlocks.decode(param1) as Vector.<CCBundleText>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:KitBundleViewCC = KitBundleViewCC(param2);
      this.codec_button.encode(param1,local3.button);
      this.codec_buttonOver.encode(param1,local3.buttonOver);
      this.codec_imageBlocks.encode(param1,local3.imageBlocks);
      this.codec_priceLabelColor.encode(param1,local3.priceLabelColor);
      this.codec_priceLabelFontPercentSize.encode(param1,local3.priceLabelFontPercentSize);
      this.codec_priceLabelPositionPercentX.encode(param1,local3.priceLabelPositionPercentX);
      this.codec_priceLabelPositionPercentY.encode(param1,local3.priceLabelPositionPercentY);
      this.codec_textBlocks.encode(param1,local3.textBlocks);
    }
  }
}
