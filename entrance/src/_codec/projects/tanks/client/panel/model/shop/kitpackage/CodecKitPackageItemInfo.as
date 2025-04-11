package _codec.projects.tanks.client.panel.model.shop.kitpackage {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.kitpackage.KitPackageItemInfo;

  public class CodecKitPackageItemInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_count:ICodec;
    private var codec_crystalPrice:ICodec;
    private var codec_itemName:ICodec;

    public function CodecKitPackageItemInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_count = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_crystalPrice = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_itemName = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:KitPackageItemInfo = new KitPackageItemInfo();
      local2.count = this.codec_count.decode(param1) as int;
      local2.crystalPrice = this.codec_crystalPrice.decode(param1) as int;
      local2.itemName = this.codec_itemName.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:KitPackageItemInfo = KitPackageItemInfo(param2);
      this.codec_count.encode(param1,local3.count);
      this.codec_crystalPrice.encode(param1,local3.crystalPrice);
      this.codec_itemName.encode(param1,local3.itemName);
    }
  }
}
