package _codec.projects.tanks.client.panel.model.shop.lootboxandpaintkit {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.shop.lootboxandpaintkit.LootboxAndPaintCC;

  public class CodecLootboxAndPaintCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_button:ICodec;
    private var codec_buttonOver:ICodec;
    private var codec_crystalCount:ICodec;
    private var codec_lootBoxPreview:ICodec;
    private var codec_lootboxCount:ICodec;
    private var codec_paintPreview:ICodec;

    public function CodecLootboxAndPaintCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_button = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_buttonOver = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_crystalCount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_lootBoxPreview = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_lootboxCount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_paintPreview = param1.getCodec(new TypeCodecInfo(ImageResource,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:LootboxAndPaintCC = new LootboxAndPaintCC();
      local2.button = this.codec_button.decode(param1) as ImageResource;
      local2.buttonOver = this.codec_buttonOver.decode(param1) as ImageResource;
      local2.crystalCount = this.codec_crystalCount.decode(param1) as int;
      local2.lootBoxPreview = this.codec_lootBoxPreview.decode(param1) as ImageResource;
      local2.lootboxCount = this.codec_lootboxCount.decode(param1) as int;
      local2.paintPreview = this.codec_paintPreview.decode(param1) as ImageResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:LootboxAndPaintCC = LootboxAndPaintCC(param2);
      this.codec_button.encode(param1,local3.button);
      this.codec_buttonOver.encode(param1,local3.buttonOver);
      this.codec_crystalCount.encode(param1,local3.crystalCount);
      this.codec_lootBoxPreview.encode(param1,local3.lootBoxPreview);
      this.codec_lootboxCount.encode(param1,local3.lootboxCount);
      this.codec_paintPreview.encode(param1,local3.paintPreview);
    }
  }
}
